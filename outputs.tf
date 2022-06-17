output "id" {
  description = "The Object Storage instance id"
  value       = data.ibm_database.etcd.id
}

output "name" {
  description = "The Object Storage instance name"
  value       = local.name
  depends_on  = [data.ibm_database.etcd]
}

output "crn" {
  description = "The crn of the Object Storage instance"
  value       = data.ibm_database.etcd.id
}

output "location" {
  description = "The Object Storage instance location"
  value       = var.region
  depends_on  = [data.ibm_database.etcd]
}

output "service" {
  description = "The name of the key provisioned for the Object Storage instance"
  value       = local.service
  depends_on = [data.ibm_database.etcd]
}

output "label" {
  description = "The label used for the Object Storage instance"
  value       = var.label
  depends_on = [data.ibm_database.etcd]
}

output "type" {
  description = "The type of the resource"
  value       = null
}

output "username" {
  description = "The username for the database user"
  value       = local.db_user
}

output "password" {
  description = "The password for the database user"
  value       = random_password.user_password.result
}

output "https_connection_url" {
  description = "The https url for the connection to the etcd database"
  value       = data.ibm_database_connection.database_connection.https[0].composed[0]
}

output "https_certificate_base64" {
  description = ""
  value       = data.ibm_database_connection.database_connection.https[0].certificate[0].certificate_base64
}
