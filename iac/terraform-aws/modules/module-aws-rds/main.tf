resource "aws_db_instance" "rds_db_instance" {
  for_each              = { for _map in var.rds_create : _map.index => _map }
  allocated_storage     = each.value.storage
  storage_type          = lookup(each.value, "storage_type", null)
  iops                  = lookup(each.value, "iops", null)
  multi_az              = each.value.multi_az # true or false
  max_allocated_storage = lookup(each.value, "max_allocated_storage", null)

  identifier     = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  engine         = lookup(each.value, "engine", null)
  engine_version = each.value.engine_version
  port           = lookup(each.value, "port", null)
  db_name        = lookup(each.value, "db_name", null) # default = null -> AWS에서 DB 생성 안함.

  manage_master_user_password   = lookup(each.value, "master_secret_manager", null) == false ? null : lookup(each.value, "master_secret_manager", null)            # true/false -> false 시에도 master_password와 충돌. false -> null 처리하도록 코드 작성.
  master_user_secret_kms_key_id = lookup(each.value, "master_user_kms_index", null) == null ? null : aws_kms_key.rds_kms_key[each.value.master_user_kms_index].arn # default = aws/secretsmanager
  username                      = each.value.username
  password                      = lookup(each.value, "master_secret_manager", null) == true ? null : each.value.password # 시크릿매니저 사용할경우 null or line 제거 

  vpc_security_group_ids = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  db_subnet_group_name   = aws_db_subnet_group.sbng[each.value.db_sbng_index].id
  parameter_group_name   = aws_db_parameter_group.pg[each.value.pg_index].id
  option_group_name      = each.value.engine == "postgres" ? null : aws_db_option_group.og[each.value.og_index].id


  performance_insights_kms_key_id = lookup(each.value, "performance_kms_index", null) == null ? null : aws_kms_key.rds_kms_key[each.value.performance_kms_index].arn
  performance_insights_enabled    = lookup(each.value, "performance_insights_enabled", null)

  auto_minor_version_upgrade = each.value.auto_minor_version_upgrade
  availability_zone          = each.value.az ## DB instance 생성될 위치

  instance_class      = each.value.instance_class
  deletion_protection = each.value.deletion_protection
  maintenance_window  = lookup(each.value, "maintenance_window", null)

  skip_final_snapshot = each.value.skip_final_snapshot
  apply_immediately   = lookup(each.value, "apply_immediately", null)

  kms_key_id        = lookup(each.value, "kms_index", null) == null ? null : aws_kms_key.rds_kms_key[each.value.kms_index].arn
  storage_encrypted = each.value.storage_encryp

  lifecycle {
    ignore_changes = [engine_version, password]
  }

  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })

}

### option group ###
resource "aws_db_option_group" "og" {
  for_each                 = { for _map in var.og_create : _map.index => _map }
  name                     = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  option_group_description = lookup(each.value, "description", null) == null ? null : each.value.description # default = managed by Terraform 
  engine_name              = each.value.engine_name
  major_engine_version     = each.value.major_engine_version

  dynamic "option" {
    for_each = try(each.value.option, {})
    iterator = o
    content {
      option_name = o.value.option_name
      option_settings {
        name  = o.value.name
        value = o.value.value
      }
    }
  }

  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })

}

### parameter group ###

resource "aws_db_parameter_group" "pg" {
  for_each    = { for _map in var.pg_create : _map.index => _map }
  name        = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  family      = each.value.family
  description = lookup(each.value, "description", null) == null ? null : each.value.description # default = managed by Terraform 

  dynamic "parameter" {
    for_each = try(each.value.parameter, {})
    iterator = p
    content {
      name         = p.value.name
      value        = p.value.value
      apply_method = lookup(p.value, "apply_method", null)
    }
  }
  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })
}

### subnet group ### 

resource "aws_db_subnet_group" "sbng" {
  for_each   = { for _map in var.sbng_create : _map.index => _map }
  name       = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.network_boundary, each.value.type]))
  subnet_ids = [for sub_ids in each.value.sub_index : var.subnet_info[sub_ids].id]

  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type            = each.value.type
      Purpose         = each.value.purpose
      NetworkBoundary = each.value.network_boundary
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
          each.value.network_boundary,
      each.value.type])
  })
}

#### rds - kms ####
resource "aws_kms_key" "rds_kms_key" {
  for_each                = { for _map in var.rds_kms_create : _map.index => _map }
  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days


  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })
}

resource "aws_kms_alias" "rds_kms_key_alias" {
  for_each      = { for _map in var.rds_kms_create : _map.index => _map }
  name          = join("-", ["alias/${var.common_tags.Company}", var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type])
  target_key_id = aws_kms_key.rds_kms_key[each.value.index].key_id
}

######################