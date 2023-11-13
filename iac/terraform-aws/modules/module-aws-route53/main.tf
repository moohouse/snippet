resource "aws_route53_zone" "this" {
  for_each      = { for _map in var.hostzone_create : _map.index => _map }
  name          = each.value.name
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  dynamic "vpc" {
    for_each = lookup(each.value, "private_zone", [])
    iterator = p

    content {
      vpc_id     = var.vpc_info[p.value.vpc_index].id
      vpc_region = lookup(p.value, "vpc_region", null)
    }
  }

}



resource "aws_route53_record" "this" {
  for_each = { for _map in var.record_create : _map.index => _map }
  zone_id  = aws_route53_zone.this[each.value.zone_index].id

  name    = each.value.name
  type    = each.value.type
  ttl     = lookup(each.value, "ttl", null)                                                        # alias 아닐 경우 필수 옵션
  records = lookup(each.value, "alias", null) == null ? lookup(each.value, "records", null) : null # records 또는 alias는 필수로 지정해야합니다.
  # set_identifier                   = lookup(each.value, "set_identifier", null) #라우팅 정책이 있는 레코드를 서로 구별하는 고유 식별자입니다.
  # multivalue_answer_routing_policy = lookup(each.value, "multivalue_answer_routing_policy", null) # true or false

  dynamic "alias" {
    for_each = lookup(each.value, "alias", [])
    iterator = a

    content {
      name                   = a.value.name                                     # DNS 도메인 name
      zone_id                = a.value.zone_id                                  # 별칭 호스팅 영역 ID
      evaluate_target_health = lookup(a.value, "evaluate_target_health", false) # ELB의 경우 Evaluate target health true
    }
  }

  # dynamic "failover_routing_policy" {
  #   for_each = length(keys(lookup(each.value, "failover_routing_policy", {}))) == 0 ? [] : [true]

  #   content {
  #     type = each.value.failover_routing_policy.type
  #   }
  # }

  # dynamic "latency_routing_policy" {
  #   for_each = length(keys(lookup(each.value, "latency_routing_policy", {}))) == 0 ? [] : [true]

  #   content {
  #     region = each.value.latency_routing_policy.region
  #   }
  # }

  # dynamic "weighted_routing_policy" {
  #   for_each = length(keys(lookup(each.value, "weighted_routing_policy", {}))) == 0 ? [] : [true]

  #   content {
  #     weight = each.value.weighted_routing_policy.weight
  #   }
  # }

  # dynamic "geolocation_routing_policy" {
  #   for_each = length(keys(lookup(each.value, "geolocation_routing_policy", {}))) == 0 ? [] : [true]

  #   content {
  #     continent   = lookup(each.value.geolocation_routing_policy, "continent", null)
  #     country     = lookup(each.value.geolocation_routing_policy, "country", null)
  #     subdivision = lookup(each.value.geolocation_routing_policy, "subdivision", null)
  #   }
  # }

  lifecycle {
    ignore_changes = [alias, records]
  }


}


