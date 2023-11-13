sm_create = [
  { index = "sm1"
    type  = "sm1"
    # description                    = "dev/isp Secrets manager"
    recovery_window_in_days = 0 # 0 or 7~30 가능. 0 : 즉시 삭제 default = 30


    secret_string = {
      # key1 = "value1"
      # key2 = "value2"
    }
    version_stages = null
    secret_binary  = null

  },
  { index = "sm1"
    type  = "sm"
    # description                    = "dev/isp Secrets manager"
    recovery_window_in_days = 0 # 0 or 7~30 가능. 0 : 즉시 삭제 default = 30


    secret_string = {
      # key1 = "value1"
      # key2 = "value2"
    }
    version_stages = null
    secret_binary  = null

  }
]

#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

