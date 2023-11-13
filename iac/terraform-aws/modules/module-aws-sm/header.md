
# Secrets Manager

# Usage 
```
module "secrets-manager" {
    source = "../../../modules/module-aws-sm"

    sm_create = [{ 
        index                          = "sm1"
        type                           = "sm"
        kms_index                      = "sm1-kms1" # CMK 사용할 경우 아래 sm_kms_create 변수와 함께 사용. default = aws/secretsmanager
        description                    = "dev/isp Secrets manager"
        recovery_window_in_days        = 0    # 0 or 7~30 가능. 0 : 즉시 삭제 /  default = 30
        
        secret_string = {
            key1 = "value1"
            key2 = "value2"
        }
    }]

    sm_kms_create    = [{ 
        index                   = "sm1-kms1"
        description             = "sm kms key"
        purpose                 = "sm"
        type                    = "kms"
    }]
    
    common_tags     = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

}

```

