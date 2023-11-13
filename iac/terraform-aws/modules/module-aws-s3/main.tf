

resource "aws_s3_bucket" "s3" {
  for_each = { for _map in var.s3_create : _map.index => _map }
  bucket   = lower(join("-", [var.common_tags.Company, each.value.service, var.common_tags.Environment, each.value.purpose]))
  tags = merge(
    var.common_tags,
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          each.value.service,
          var.common_tags.Environment,
      each.value.purpose])
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryp" {
  for_each = { for _map in var.s3_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.index].id

  rule {
    bucket_key_enabled = lookup(each.value, "bucket_key_enabled", null)
    apply_server_side_encryption_by_default {
      kms_master_key_id = lookup(each.value, "kms_index", null) == null ? null : aws_kms_key.s3_kms_key[each.value.kms_index].arn
      # null -> default ; aws/s3

      sse_algorithm = lookup(each.value, "kms_index", null) == null ? "AES256" : "aws:kms"
      # kms 사용할경우 aws:kms 알고리즘 채택, kms 없을 경우 AES256채택
    }
  }
}

#### s3 - kms ####
resource "aws_kms_key" "s3_kms_key" {
  for_each                = { for _map in var.s3_kms_create : _map.index => _map }
  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days


  tags = merge(
    var.common_tags,
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          each.value.service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })

}

resource "aws_kms_alias" "s3_kms_key_alias" {
  for_each      = { for _map in var.s3_kms_create : _map.index => _map }
  name          = join("-", ["alias/${var.common_tags.Company}", each.value.service, var.common_tags.Environment, each.value.purpose, each.value.type])
  target_key_id = aws_kms_key.s3_kms_key[each.value.index].key_id
}

#######################

resource "aws_s3_bucket_versioning" "s3_versioning" {
  for_each = { for _map in var.s3_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.index].id

  versioning_configuration {
    status = each.value.versioning
    # disable - 버전이 지정되지 않은 S3 버킷에 해당하는 리소스를 생성하거나 가져올 때만 사용해야 합니다. 
    # should only be used when creating or importing resources that correspond to unversioned S3 buckets.
    # 초기 리소스 생성 시 - Enabled, Suspended, Disabled 가능
    # Enabled, Suspended 상태 -> Disabled 상태변경 불가능.
    # Enabled -> Suspended 가능

  }
}

resource "aws_s3_bucket_public_access_block" "s3_pub_access_block" {
  for_each = { for _map in var.s3_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.index].id

  ## ACL 사용할 경우##
  # block_public_acls = each.value.acl == "public-read" ? false : each.value.block_public_acls

  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
  ## default = false -> 퍼블릭 액세스 허용
}



resource "aws_s3_bucket_ownership_controls" "s3_ownership_controls" {
  for_each = { for _map in var.s3_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.index].id

  rule {
    object_ownership = each.value.object_ownership # BucketOwnerPreferred or ObjectWriter or BucketOwnerEnforced
  }
}


######## bucket policy ######
resource "aws_s3_bucket_policy" "s3_policy" {
  for_each = { for _map in var.s3_policy_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.s3_index].id
  policy   = file("${each.value.bucket_policy}")
}

####### s3 web hosting ########

resource "aws_s3_bucket_website_configuration" "web" {
  for_each = { for _map in var.s3_web_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.s3_index].id

  index_document {
    suffix = each.value.index_document
  }

  dynamic "error_document" {
    for_each = lookup(each.value, "error_document", [])
    iterator = e

    content {
      key = e.value.error_html
    }
  }

  routing_rules = lookup(each.value, "routings_rules", null) == null ? null : file("${each.value.routings_rules}")
}

####### s3 CORS ########


resource "aws_s3_bucket_cors_configuration" "cors" {
  for_each = { for _map in var.s3_cors_create : _map.index => _map }
  bucket   = aws_s3_bucket.s3[each.value.s3_index].id

  dynamic "cors_rule" {
    for_each = lookup(each.value, "cors_rule", [])
    iterator = c

    content {
      allowed_headers = lookup(c.value, "allowed_headers", null)
      allowed_methods = c.value.allowed_methods
      allowed_origins = c.value.allowed_origins
      expose_headers  = lookup(c.value, "expose_headers", null)
      id              = lookup(c.value, "id", null)
      max_age_seconds = lookup(c.value, "max_age_seconds", null) ## default = 0
    }

  }
}


#######bucket acl #######

## AWS - ACL 비활성화 권장 : Amazon S3의 최신 사용 사례 대부분은 더 이상 ACL을 사용할 필요가 없습니다.
# 각 객체에 대해 액세스를 개별적으로 제어할 필요가 있는 드문 상황을 제외하고는 ACL을 비활성화한 채로 두는 것이 좋습니다. 
# ACL을 비활성화하면 누가 객체를 버킷에 업로드했는지에 관계없이 정책을 사용하여 버킷의 모든 객체에 대한 액세스를 제어할 수 있습니다.
##

# resource "aws_s3_bucket_acl" "s3_acl" {
#   for_each = { for _map in var.s3_create : _map.index => _map }
#   bucket   = aws_s3_bucket.s3[each.value.index].id

#   acl = each.value.acl ## null 불가

# access_control_policy {
#    grant {
#     grantee {
#       id   = data.aws_canonical_user_id.current.id
#       type = "CanonicalUser"
#     }
#     permission = "READ"
#   }
#   grant {
#     grantee {
#       type = "Group"
#       uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
#     }
#     permission = "READ_ACP"
#   }
#   owner {
#     id = data.aws_canonical_user_id.current.id
#   }
# }


#   depends_on = [
#     aws_s3_bucket_ownership_controls.s3_ownership_controls,
#     aws_s3_bucket_public_access_block.s3_pub_access_block,
#   ]
# }