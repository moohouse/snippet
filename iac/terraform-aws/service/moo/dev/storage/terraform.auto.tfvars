#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

######## S3 #########

s3_create = [
  { index                   = "s3-1"
    service                 = "isp"
    purpose                 = "tempo"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerEnforced"

  },
  { index                   = "s3-2"
    service                 = "isp"
    purpose                 = "loki"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerEnforced"

  },
  { index                   = "s3-3"
    service                 = "isp"
    purpose                 = "file"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerPreferred"

  },
  { index                   = "s3-4"
    service                 = "isp"
    purpose                 = "frontend"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
    object_ownership        = "ObjectWriter"

  },
  { index                   = "s3-5"
    service                 = "isp"
    purpose                 = "dspa"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerEnforced"
  },
  { index                   = "s3-6"
    service                 = "isp"
    purpose                 = "mwaa"
    type                    = "s3"
    versioning              = "Enabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerEnforced"
  },
  { index                   = "s3-7"
    service                 = "isp"
    purpose                 = "codebuild"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerEnforced"
  },
  { index                   = "s3-8"
    service                 = "isp"
    purpose                 = "pub-file"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
    object_ownership        = "ObjectWriter"
  },
  { index                   = "s3-9"
    service                 = "labide"
    purpose                 = "admin"
    type                    = "s3"
    versioning              = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    object_ownership        = "BucketOwnerEnforced"
  }
]

s3_policy_create = [
  { index         = "s3-policy-1"
    s3_index      = "s3-4"
    bucket_policy = "./s3-public-policy.json"
  },
  { index         = "s3-policy-2"
    s3_index      = "s3-3"
    bucket_policy = "./s3-public-policy_file.json"
  },
  { index         = "s3-policy-4"
    s3_index      = "s3-8"
    bucket_policy = "./s3-policy_pub-file.json"
  }
]

s3_web_create = [
  { index          = "s3-web-1"
    s3_index       = "s3-4"
    index_document = "index.html"
    # error_document = "error.html"
  },
  { index          = "s3-web-2"
    s3_index       = "s3-5"
    index_document = "index.html"
    # error_document = "error.html"
  }
]

s3_cors_create = [
  { index    = "s3-cors1"
    s3_index = "s3-3"
    cors_rule = [
      {
        allowed_headers = ["*"]
        allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
        allowed_origins = ["http://localhost:3000",
          "http://localhost:3020",
          "http://localhost:3030"]
        expose_headers  = []
        max_age_seconds = 0
      }
    ]
  },
  { index    = "s3-cors2"
    s3_index = "s3-8"
    cors_rule = [
      {
        allowed_headers = ["*"]
        allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
        allowed_origins = ["http://localhost:3000",
          "http://localhost:3020",
          "http://localhost:3030"]
        expose_headers  = []
        max_age_seconds = 0
      }
    ]
  }
]

#####################

######### EFS ##########


efs_create = [
  { index           = "efs1"
    encrypted       = true
    throughput_mode = "elastic"
    into_IA         = "AFTER_30_DAYS"
    out_of_IA       = null
    purpose         = "telemetry"
    type            = "efs"
  },
  # { index           = "efs2"
  #   encrypted       = true
  #   throughput_mode = "elastic"
  #   lifecycle_policy = [
  #     { into_IA = "AFTER_30_DAYS"
  #     }
  #   ]
  #   purpose = "keycloak"
  #   type    = "efs"
  # }
]

efs_access_point_create = [
  { index     = "efs-ap-1"
    efs_index = "efs1"
    posix_user = [
      { gid = 50000
        uid = 50000
      secondary_gids = null }
    ]

    root_directory = [
      { path = "/prometheus-0-dev"
        creation_info = [
          { owner_gid = 50000
            owner_uid = 50000
          permissions = 700 }
      ] }
    ]
    name = "prometheus-0-dev"
  },
  { index     = "efs-ap-2"
    efs_index = "efs1"
    posix_user = [
      { gid = 50001
      uid = 50001 }
    ]

    root_directory = [
      { path = "/prometheus-1-dev"
        creation_info = [
          { owner_gid = 50001
            owner_uid = 50001
          permissions = 700 }
      ] }
    ]
    name = "prometheus-1-dev"
  },
  { index     = "efs-ap-3"
    efs_index = "efs1"
    posix_user = [
      { gid = 50002
        uid = 50002
      secondary_gids = null }
    ]

    root_directory = [
      { path = "/grafana-0-dev"
        creation_info = [
          { owner_gid = 50002
            owner_uid = 50002
          permissions = 700 }
      ] }
    ]
    name = "grafana-0-dev"
  },
  { index     = "efs-ap-4"
    efs_index = "efs1"
    posix_user = [
      { gid = 50003
      uid = 50003 }
    ]

    root_directory = [
      { path = "/loki-0-dev"
        creation_info = [
          { owner_gid = 50003
            owner_uid = 50003
          permissions = 700 }
      ] }
    ]
    name = "loki-0-dev"
  }
  ,
  { index     = "efs-ap-4-2"
    efs_index = "efs1"
    posix_user = [
      { gid = 50005
      uid = 50005 }
    ]

    root_directory = [
      { path = "/loki-1-dev"
        creation_info = [
          { owner_gid = 50005
            owner_uid = 50005
          permissions = 700 }
      ] }
    ]
    name = "loki-1-dev"
  },
  { index     = "efs-ap-5"
    efs_index = "efs1"
    posix_user = [
      { gid = 50004
      uid = 50004 }
    ]

    root_directory = [
      { path = "/tempo-0-dev"
        creation_info = [
          { owner_gid = 50004
            owner_uid = 50004
          permissions = 700 }
      ] }
    ]
    name = "tempo-0-dev"
  },
  { index     = "efs-ap-5-2"
    efs_index = "efs1"
    posix_user = [
      { gid = 50006
      uid = 50006 }
    ]

    root_directory = [
      { path = "/tempo-1-dev"
        creation_info = [
          { owner_gid = 50006
            owner_uid = 50006
          permissions = 700 }
      ] }
    ]
    name = "tempo-1-dev"
  },
  # { index     = "efs-keycloak-ap-0"
  #   efs_index = "efs2"
  #   posix_user = [
  #     { gid = 50000
  #     uid = 50000 }
  #   ]

  #   root_directory = [
  #     { path = "/providers-0-dev"
  #       creation_info = [
  #         { owner_gid = 50000
  #           owner_uid = 50000
  #         permissions = 700 }
  #     ] }
  #   ]
  #   name = "providers-0-dev"
  # },
  # { index     = "efs-keycloak-ap-1"
  #   efs_index = "efs2"
  #   posix_user = [
  #     { gid = 50001
  #     uid = 50001 }
  #   ]

  #   root_directory = [
  #     { path = "/themes-0-dev"
  #       creation_info = [
  #         { owner_gid = 50001
  #           owner_uid = 50001
  #         permissions = 700 }
  #     ] }
  #   ]
  #   name = "themes-0-dev"
  # },
  # { index     = "efs-keycloak-ap-2"
  #   efs_index = "efs2"
  #   posix_user = [
  #     { gid = 50002
  #     uid = 50002 }
  #   ]

  #   root_directory = [
  #     { path = "/data-0-dev"
  #       creation_info = [
  #         { owner_gid = 50002
  #           owner_uid = 50002
  #         permissions = 700 }
  #     ] }
  #   ]
  #   name = "data-0-dev"
  # },
  # { index     = "efs-keycloak-ap-3"
  #   efs_index = "efs2"
  #   posix_user = [
  #     { gid = 50003
  #     uid = 50003 }
  #   ]

  #   root_directory = [
  #     { path = "/conf-0-dev"
  #       creation_info = [
  #         { owner_gid = 50003
  #           owner_uid = 50003
  #         permissions = 700 }
  #     ] }
  #   ]
  #   name = "conf-0-dev"
  # }

]

efs_mount_target_create = [
  { index     = "efs-mt-1"
    efs_index = "efs1"
    sub_index = "sbn5"
    sg_index  = ["dev_efs_pri"]
  },
  { index     = "mt-2"
    efs_index = "efs1"
    sub_index = "sbn6"
    sg_index  = ["dev_efs_pri"]
  },
  # { index     = "mt-3"
  #   efs_index = "efs2"
  #   sub_index = "sbn5"
  #   sg_index  = ["dev_efs_pri"]
  # },
  # { index     = "mt-4"
  #   efs_index = "efs2"
  #   sub_index = "sbn6"
  #   sg_index  = ["dev_efs_pri"]
  # }
]
