resource "aws_efs_file_system" "this" {
  for_each                        = { for _map in var.efs_create : _map.index => _map }
  creation_token                  = lower(join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type]))
  encrypted                       = lookup(each.value, "encrypted", null)
  kms_key_id                      = lookup(each.value, "kms_index", null) == null ? null : aws_kms_key.efs_kms_key[each.value.kms_index].arn ## managed -> CMK 변경 하고 싶은 경우 efs 지웠다가 다시 프로비저닝 
  performance_mode                = lookup(each.value, "performance_mode", null)                                                             #default = generalPurpose
  provisioned_throughput_in_mibps = lookup(each.value, "mibps", null)                                                                        # throuthput_mode가 provisioned일 때 만 적용됨.
  throughput_mode                 = lookup(each.value, "throughput_mode", null)                                                              #elastic, bursting,provisioned / default = bursting

  dynamic "lifecycle_policy" {
    for_each = lookup(each.value, "lifecycle_policy", [])

    content {
      transition_to_ia                    = lookup(lifecycle_policy.value, "into_IA", null)
      transition_to_primary_storage_class = lookup(lifecycle_policy.value, "out_of_IA", null)
    }
  }


  tags = merge(
    var.common_tags,
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

resource "aws_efs_file_system_policy" "this" {
  for_each       = { for _map in var.efs_policy_create : _map.index => _map }
  file_system_id = aws_efs_file_system.this[each.value.efs_index].id
  policy         = file("${each.value.efs_policy}")

}


resource "aws_efs_backup_policy" "policy" {
  for_each       = { for _map in var.efs_create : _map.index => _map }
  file_system_id = aws_efs_file_system.this[each.value.index].id

  backup_policy {
    status = lookup(each.value, "backup_status", "ENABLED") # ENABLED OR DISABLED
  }
}

resource "aws_efs_access_point" "test" {
  for_each       = { for _map in var.efs_access_point_create : _map.index => _map }
  file_system_id = aws_efs_file_system.this[each.value.efs_index].id
  tags           = { Name = each.value.name }
  dynamic "posix_user" {
    for_each = lookup(each.value, "posix_user", [])
    content {
      gid            = posix_user.value.gid
      uid            = posix_user.value.uid
      secondary_gids = lookup(posix_user.value, "secondary_gids", null)
    }
  }

  dynamic "root_directory" {
    for_each = lookup(each.value, "root_directory", [])

    content {
      path = lookup(root_directory.value, "path", null)

      dynamic "creation_info" {
        for_each = lookup(root_directory.value, "creation_info", [])
        content {
          owner_gid   = creation_info.value.owner_gid
          owner_uid   = creation_info.value.owner_uid
          permissions = creation_info.value.permissions
        }
      }
    }
  }


}

resource "aws_efs_mount_target" "alpha" { ## mount 할 서브넷 ( 가용 영역 상관 없이 마운트는 가능합니다)
  for_each       = { for _map in var.efs_mount_target_create : _map.index => _map }
  file_system_id = aws_efs_file_system.this[each.value.efs_index].id

  subnet_id       = var.subnet_info[each.value.sub_index].id
  ip_address      = lookup(each.value, "ip_address", null)
  security_groups = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]


}

#### efs - kms ####
resource "aws_kms_key" "efs_kms_key" {
  for_each                = { for _map in var.efs_kms_create : _map.index => _map }
  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days


  tags = merge(
    var.common_tags,
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

resource "aws_kms_alias" "efs_kms_key_alias" {
  for_each      = { for _map in var.efs_kms_create : _map.index => _map }
  name          = join("-", ["alias/${var.common_tags.Company}", var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.type])
  target_key_id = aws_kms_key.efs_kms_key[each.value.index].key_id
}
