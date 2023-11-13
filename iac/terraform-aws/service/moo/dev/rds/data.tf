data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "${var.common_tags.Service}-${var.common_tags.Environment}-tfstate"
    key    = "isp/${var.common_tags.Service}-${var.common_tags.Environment}-network.state"
    region = "ap-northeast-2"
  }
}