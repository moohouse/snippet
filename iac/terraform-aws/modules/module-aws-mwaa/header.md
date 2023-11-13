# AWS MWAA module

# Usage 
```
module "mwaa" {
    source = "../../../modules/module-aws-mwaa"
    
    mwaa_create  = [{
        index = "mwaa-1"
        dags_path = "dags/"
        s3_index = "s3-1"
        requirements_s3_path = "requirements.txt"
        sg_index = ["dev_mwaa_pri"]
        sub_index = ["sbn3","sbn4"]
        webs_access_mode = "PRIVATE_ONLY"
        task_logs = [{ 
            task_logs = true
            task_logs_level = "INFO"
        }]
        worker_logs = [{ 
            worker_logs = true
            worker_logs_level = "INFO"
        }]
        airflow_version = "2.5.1"
    }]
        
    mwaa_policy_create = [{
        index = "policy-1"
        policy = "./mwaa.json"
    }]
    
    mwaa_policy_attach = [{
        index = "attach-1"
        custom_policy_index = "policy-1"
    },
    {
        index = "attach-2"
        policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    }]
        
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
        
    subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
    sg_info = data.terraform_remote_state.remote.outputs.sg_info
    s3_bucket_info = data.terraform_remote_state.remote_s3.outputs.s3_bucket_info

}
```