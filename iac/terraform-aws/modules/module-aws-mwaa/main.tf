resource "aws_mwaa_environment" "this" {
  for_each = { for _map in var.mwaa_create : _map.index => _map }
  name     = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "mwaa"])

  dag_s3_path                    = each.value.dags_path
  requirements_s3_path           = each.value.requirements_s3_path
  airflow_version                = lookup(each.value, "airflow_version", null)
  source_bucket_arn              = var.s3_bucket_info[each.value.s3_index].arn
  requirements_s3_object_version = lookup(each.value, "requirements_s3_object_version", null)

  network_configuration {
    security_group_ids = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
    subnet_ids         = [for sub_ids in each.value.sub_index : var.subnet_info[sub_ids].id]
  }

  webserver_access_mode = lookup(each.value, "webs_access_mode", null)
  # PUBLIC_ONLY OR PRIVATE_ONLY

  execution_role_arn = aws_iam_role.this.arn

  environment_class = lookup(each.value, "environment_class", null)
  max_workers       = lookup(each.value, "max_workers", null)
  min_workers       = lookup(each.value, "min_workers", null)
  schedulers        = lookup(each.value, "scheduler_count", null)

  logging_configuration {
    dynamic "dag_processing_logs" {
      for_each = lookup(each.value, "dag_processing_logs", [])

      content {
        enabled   = lookup(dag_processing_logs.value, "dag_logs", null)
        log_level = lookup(dag_processing_logs.value, "dag_logs_level", null)
      }
    }

    dynamic "scheduler_logs" {
      for_each = lookup(each.value, "scheduler_logs", [])

      content {
        enabled   = lookup(scheduler_logs.value, "scheduler_logs", null)
        log_level = lookup(scheduler_logs.value, "scheduler_logs_level", null)
      }
    }

    dynamic "task_logs" {
      for_each = lookup(each.value, "task_logs", [])

      content {
        enabled   = lookup(task_logs.value, "task_logs", null)
        log_level = lookup(task_logs.value, "task_logs_level", null)
      }
    }

    dynamic "webserver_logs" {
      for_each = lookup(each.value, "webserver_logs", [])

      content {
        enabled   = lookup(webserver_logs.value, "webserver_logs", null)
        log_level = lookup(webserver_logs.value, "webserver_logs_level", null)
      }
    }

    dynamic "worker_logs" {
      for_each = lookup(each.value, "worker_logs", [])

      content {
        enabled   = lookup(worker_logs.value, "worker_logs", null)
        log_level = lookup(worker_logs.value, "worker_logs_level", null)
      }
    }

  }

  lifecycle {
    ignore_changes = [airflow_version]
  }

  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
      "mwaa"])
  })

  depends_on = [aws_iam_role_policy_attachment.attach, aws_iam_role.this, aws_iam_policy.policy]

}