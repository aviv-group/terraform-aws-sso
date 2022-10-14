data "aws_ssoadmin_instances" "this" {}

data "aws_identitystore_group" "this" {
  for_each          = toset(local.groups)
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  filter {
    attribute_path  = "DisplayName"
    attribute_value = each.value
  }
}

data "aws_identitystore_user" "this" {
  for_each          = toset(local.users)
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  filter {
    attribute_path  = "UserName"
    attribute_value = each.value
  }
}

data "aws_ssoadmin_permission_set" "this" {
  for_each = local.referenced_only_permission_sets

  instance_arn = local.ssoadmin_instance_arn
  name = each.value
}