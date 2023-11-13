

resource "aws_secretsmanager_secret" "sm" {
  for_each                       = { for _map in var.sm_create : _map.index => _map }
  name                           = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.type])
  description                    = lookup(each.value, "description", null)
  kms_key_id                     = lookup(each.value, "kms_index", null) == null ? "alias/aws/secretsmanager" : aws_kms_key.sm_kms_key[each.value.kms_index].arn
  force_overwrite_replica_secret = lookup(each.value, "force_overwrite_replica_secret", null) # 대상 리전에서 이름이 같은 암호를 덮어쓸지 여부를 지정. true or false / defalut = false
  recovery_window_in_days        = lookup(each.value, "recovery_window_in_days", null)        # default = 30


  dynamic "replica" {
    for_each = lookup(each.value, "replica", null) == null ? [] : each.value.replica
    content {
      region     = lookup(replica.value, "region", null)
      kms_key_id = lookup(replica.value, "r_kms_index", null) == null ? "alias/aws/secretsmanager" : aws_kms_key.sm_kms_key[replica.value.r_kms_index].arn
    }
  }

  tags = merge(
    var.common_tags,
    {
      Type = each.value.type
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
      each.value.type])
  })

  #   policy                         = lookup(each.value, "policy", null) ## Resource permissions

}

resource "aws_secretsmanager_secret_version" "sm-ver" {
  for_each       = { for _map in var.sm_create : _map.index => _map }
  secret_id      = aws_secretsmanager_secret.sm[each.value.index].id
  secret_string  = lookup(each.value, "secret_string", null) == null ? null : jsonencode(each.value.secret_string)
  secret_binary  = lookup(each.value, "secret_binary", null) == null ? null : base64encode(each.value.secret_binary)
  version_stages = lookup(each.value, "version_stages", null) ## default = AWSCURRENT
  depends_on     = [aws_secretsmanager_secret.sm]

  lifecycle {
    ignore_changes = [
      secret_string,
      secret_binary,
      secret_id,
    ]
  }
}




#### sm - kms ####
resource "aws_kms_key" "sm_kms_key" {
  for_each                = { for _map in var.sm_kms_create : _map.index => _map }
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

# resource "aws_kms_alias" "rds_kms_key_alias" {
# for_each                = { for _map in var.s3_kms_create : _map.index => _map }
#   name          = "alias/my-key-alias"
#   target_key_id = aws_kms_key.s3_kms_key[each.value.index].key_id
# }

#######################

##### lambda 및 관련 Policy 고려 필요 ######
# resource "aws_secretsmanager_secret_rotation" "sm-ro" {
#   for_each = { for _map in var.sm_ro_create : _map.index => _map }
#   secret_id           = aws_secretsmanager_secret.sm[each.value.index].id
#   rotation_lambda_arn = lookup(each.value, "rotation_lambda_arn")

#   rotation_rules {
#     automatically_after_days = lookup(each.value, "automatically_after_days", null)
#     duration = lookup(each.value, "duration", null)
#     schedule_expression = lookup(each.value, "schedule_expression", null) ## rate() or cron() "cron(30 18 * * * *)"
#   }
#   depends_on = [aws_secretsmanager_secret.sm]

#   lifecycle {
#     ignore_changes = [
#       secret_id
#     ]
#   }
# }