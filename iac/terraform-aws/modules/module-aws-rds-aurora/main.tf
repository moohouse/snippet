######## Note #########
# Changes to an RDS Cluster can occur when you manually change a parameter, 
# such as port, and are reflected in the next maintenance window. 
# Because of this, Terraform may report a difference in its planning phase because a modification has not yet taken place. 
# You can use the apply_immediately flag to instruct the service to apply the change immediately 
# using apply_immediately can result in a brief downtime as the server reboots.
######################
# KMS - cluster(default = aws/rds (관리형 키)), master (secret manager - default = aws/secretsmanager) , monitoring (performance_insights_kms_key_id)

resource "aws_rds_cluster" "aurora_cluster" {
  for_each = { for _map in var.aurora_rds_cluster_create : _map.index => _map }

  cluster_identifier = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  engine             = lookup(each.value, "engine", null)
  engine_version     = each.value.engine_version
  port               = lookup(each.value, "port", null)
  database_name      = lookup(each.value, "db_name", null) # default = null -> AWS에서 DB 생성 안함.

  manage_master_user_password   = lookup(each.value, "master_secret_manager", null) == false ? null : lookup(each.value, "master_secret_manager", null)                          # true/false -> false 시에도 master_password와 충돌. false -> null 처리하도록 코드 작성.
  master_user_secret_kms_key_id = lookup(each.value, "master_user_kms_index", null) == null ? null : aws_kms_key.aurora_rds_kms_key[each.value.aurora_master_user_kms_index].arn # default = aws/secretsmanager
  master_username               = each.value.master_username
  master_password               = lookup(each.value, "master_secret_manager", null) == true ? null : each.value.master_password # 시크릿매니저 사용할경우 null or line 제거 

  vpc_security_group_ids          = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  db_subnet_group_name            = aws_db_subnet_group.aurora_sbng[each.value.aurora_cluster_sbng_index].id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_pg[each.value.aurora_cluster_pg_index].id

  skip_final_snapshot = each.value.skip_final_snapshot

  kms_key_id        = lookup(each.value, "kms_index", null) == null ? null : aws_kms_key.aurora_rds_kms_key[each.value.aurora_kms_index].arn
  storage_encrypted = each.value.storage_encrypted

  deletion_protection = each.value.deletion_protection
  apply_immediately   = lookup(each.value, "apply_immediately", null)


  lifecycle {
    ignore_changes = [engine_version, master_password, availability_zones]
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

  ##추후 요구사항 발생시 추가 옵션
  #   backup_retention_period = each.value. # default = 1 . 백업을 보존할 날짜
  #   preferred_backup_window = each.value. 
  #   preferred_maintenance_window = each.value. #시스템 유지 관리가 발생할 수 있는 주간 시간 범위(UTC) 예: wed:04:00-wed:04:30
  # availability_zones        =lookup(each.value, "multi_azs", null) == null ? null : each.value.multi_azs                        # 다중 AZ

}

resource "aws_rds_cluster_instance" "aurora_cluster_instances" {
  for_each           = { for _map in var.aurora_rds_cluster_instances_create : _map.index => _map }
  identifier         = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.cluster_purpose, each.value.type, each.value.number]))
  cluster_identifier = aws_rds_cluster.aurora_cluster[each.value.cluster_index].id

  instance_class          = each.value.instance_class
  engine                  = aws_rds_cluster.aurora_cluster[each.value.cluster_index].engine
  engine_version          = aws_rds_cluster.aurora_cluster[each.value.cluster_index].engine_version
  availability_zone       = each.value.az
  db_parameter_group_name = aws_db_parameter_group.aurora_instance_pg[each.value.aurora_instance_pg_index].id

  performance_insights_kms_key_id = lookup(each.value, "performance_kms_index", null) == null ? null : aws_kms_key.aurora_rds_kms_key[each.value.aurora_performance_kms_index].arn
  performance_insights_enabled    = lookup(each.value, "performance_insights_enabled", null)

  auto_minor_version_upgrade = each.value.auto_minor_version_upgrade

  lifecycle {
    ignore_changes = [engine_version]
  }

  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type    = each.value.type
      Purpose = each.value.cluster_purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.cluster_purpose,
          each.value.type,
      each.value.number])
  })
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_pg" {
  for_each    = { for _map in var.aurora_rds_cluster_pg_create : _map.index => _map }
  name        = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  family      = each.value.family                       # ex. "aurora-mysql8.0"
  description = lookup(each.value, "description", null) # default = managed by Terraform 

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

resource "aws_db_parameter_group" "aurora_instance_pg" {
  for_each    = { for _map in var.aurora_rds_instance_pg_create : _map.index => _map }
  name        = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  family      = each.value.family
  description = lookup(each.value, "description", null) # default = managed by Terraform 

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

resource "aws_db_subnet_group" "aurora_sbng" {
  for_each   = { for _map in var.aurora_rds_sbng_create : _map.index => _map }
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
resource "aws_kms_key" "aurora_rds_kms_key" {
  for_each                = { for _map in var.aurora_rds_kms_create : _map.index => _map }
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

resource "aws_kms_alias" "aurora_rds_kms_key_alias" {
  for_each      = { for _map in var.aurora_rds_kms_create : _map.index => _map }
  name          = join("-", ["alias/${var.common_tags.Company}", var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type])
  target_key_id = aws_kms_key.aurora_rds_kms_key[each.value.index].key_id
}

#######################
