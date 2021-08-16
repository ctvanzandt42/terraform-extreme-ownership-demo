output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "dynamo_hash_key" {
  value = aws_dynamodb_table.us-east-1.hash_key
}

output "ld_key" {
  value     = data.launchdarkly_environment.ld_env.api_key
  sensitive = true
}
