
locals {
  service = "databases-for-etcd"
  name_prefix = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  name        = var.name != "" ? var.name : "${replace(local.name_prefix, "/[^a-zA-Z0-9_\\-\\.]/", "")}-${var.label}"
  service_endpoints = var.disable_public_endpoints ? "private" : "public-and-private"
  db_user = "etcd_user"
}

resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'Resource group name: ${var.resource_group_name}'"
  }
}

data ibm_resource_group rg {
  depends_on = [null_resource.print_names]

  name = var.resource_group_name
}

resource random_password admin_password {
  length = 16

  special = false
}

resource random_password user_password {
  length = 16

  special = false
}

resource ibm_database etcd {
  count             = var.provision ? 1 : 0

  resource_group_id            = data.ibm_resource_group.rg.id
  name                         = local.name
  service                      = local.service
  plan                         = var.plan
  location                     = var.region
  version                      = var.database_version
  service_endpoints            = local.service_endpoints
  adminpassword                = random_password.admin_password.result
  members_memory_allocation_mb = var.memory_allocation
  members_disk_allocation_mb   = var.disk_allocation
  members_cpu_allocation_count = var.cpu_allocation
  backup_id                    = var.backup_etcd_crn
  remote_leader_id             = var.remote_leader_etcd_crn
  key_protect_instance         = var.key_protect_instance
  key_protect_key              = var.key_protect_key
  backup_encryption_key_crn    = var.backup_key_protect_key
  tags                         = var.tags

  users {
    name     = local.db_user
    password = random_password.user_password.result
    type     = "database"
  }
}

data ibm_database etcd {
  depends_on = [ibm_database.etcd]

  name              = local.name
  location          = var.region
  service           = local.service
  resource_group_id = data.ibm_resource_group.rg.id
}

data ibm_database_connection database_connection {
  endpoint_type = var.disable_public_endpoints ? "private" : "public"
  deployment_id = data.ibm_database.etcd.id
  user_id       = local.db_user
  user_type     = "database"
}
