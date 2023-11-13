resource "aws_instance" "bastion" {
  for_each               = { for _map in var.ec2_bastion_create : _map.index => _map }
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  subnet_id              = var.subnet_info[each.value.sub_index].id
  vpc_security_group_ids = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  key_name               = lookup(each.value, "key_name", null)
  iam_instance_profile   = aws_iam_instance_profile.ec2_bastion_profile.name

  root_block_device {
    volume_size = lookup(each.value, "volume_size", null)
    volume_type = lookup(each.value, "volume_type", null)
  }


  tags = merge(
    var.common_tags,
    {
      NetworkBoundary = each.value.network_boundary
      Type            = each.value.type
      Purpose         = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
          each.value.network_boundary,
          each.value.region_az,
      each.value.type])
  })

}

# instance type, ami, vpc, subnet, eip , key pair, IAM 없음 , 보안그룹 , 퍼블릭 DNS 할당, 스토리지는 root만..

resource "aws_eip" "bastion" {
  for_each = { for _map in var.ec2_bastion_create : _map.index => _map if lookup(_map, "eip_required", false) }
  vpc      = true
  instance = aws_instance.bastion[each.value.index].id


  tags = merge(
    var.common_tags,
    {
      NetworkBoundary = each.value.network_boundary
      Type            = "eip"
      Purpose         = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
          each.value.network_boundary,
          each.value.region_az,
      "eip"])
  })


}