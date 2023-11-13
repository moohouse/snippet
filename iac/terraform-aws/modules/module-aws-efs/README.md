<!-- BEGIN_TF_DOCS -->

# AWS bastion efs module
##### efs를 생성하는 모듈입니다.

# Usage
```
module "efs" {
  source = "../../../../modules/module-aws-efs"

  # tfvars
  common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
  }

  efs_create = [
    { index           = "efs1"
      encrypted       = true
      kms_index       = "efs-kms1"
      throughput_mode = "elastic"
     lifecycle_policy = [
      { into_IA = "AFTER_30_DAYS"
       }
     ]
      purpose         = "telemetry"
      type            = "efs"
    }
  ]

  efs_mount_target_create = [
    { index     = "efs-mt-1"
      efs_index = "efs1"
      sub_index = "sbn1"
      sg_index  = ["dev_efs_pri"]
    },
    { index     = "mt-2"
      efs_index = "efs1"
      sub_index = "sbn2"
      sg_index  = ["dev_efs_pri"]
    }
  ]

  efs_access_point_create = [
    { index     = "efs-ap-1"
      efs_index = "efs1"
      posix_user = [
        { gid = 50000
          uid = 50000}
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
          uid = 50001
        secondary_gids = null }
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
    }
  ]

  sg_info    = data.terraform_remote_state.remote.outputs.vpc_info
  subnet_info = data.terraform_remote_state.remote.outputs.subnet_info

}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_efs_access_point_create"></a> [efs\_access\_point\_create](#input\_efs\_access\_point\_create) | Defined efs mount target configuration option values | `any` | n/a | yes |
| <a name="input_efs_backup_policy_create"></a> [efs\_backup\_policy\_create](#input\_efs\_backup\_policy\_create) | Defined efs backup policy configuration option values | `any` | `[]` | no |
| <a name="input_efs_create"></a> [efs\_create](#input\_efs\_create) | Defined efs configuration option values | `any` | n/a | yes |
| <a name="input_efs_kms_create"></a> [efs\_kms\_create](#input\_efs\_kms\_create) | Defined efs kms key configuration option values | `any` | `[]` | no |
| <a name="input_efs_mount_target_create"></a> [efs\_mount\_target\_create](#input\_efs\_mount\_target\_create) | Defined efs mount target configuration option values | `any` | n/a | yes |
| <a name="input_efs_policy_create"></a> [efs\_policy\_create](#input\_efs\_policy\_create) | Defined efs policy configuration option values | `any` | `[]` | no |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | `[]` | no |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_info"></a> [efs\_info](#output\_efs\_info) | efs  information map type output |
<!-- END_TF_DOCS -->