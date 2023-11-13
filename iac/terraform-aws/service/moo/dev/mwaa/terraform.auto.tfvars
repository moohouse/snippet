#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}
mwaa_create = [
  { index                = "mwaa-1"
    dags_path            = "dags/"
    s3_index             = "s3-6"
    requirements_s3_path = "requirements.txt"
    sg_index             = ["dev_mwaa_pri"]
    sub_index            = ["sbn9", "sbn10"]
    webs_access_mode     = "PUBLIC_ONLY"
    task_logs = [
      { task_logs       = true
        task_logs_level = "INFO"
      }
    ]
    worker_logs = [
      { worker_logs       = true
        worker_logs_level = "INFO"
      }
    ]
    airflow_version = "2.5.1"
}]

mwaa_policy_create = [
  { index  = "policy-1"
    policy = "iam-mwaa-policy.json"
}]

mwaa_policy_attach = [
  { index               = "attach-1"
    custom_policy_index = "policy-1"
  }
]