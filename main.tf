resource "null_resource" "test" {
  count = 1
}

output "id" {
  value = null_resource.test[0].id
}
