module "dev_tools_mymodule" {
  source = "./module"

  resource_group_name = module.resource_group.name
  region = var.region
}

resource local_file outputs {
  filename = "${path.cwd}/.outputs"

  content = jsonencode({
    name = module.dev_tools_mymodule.name
    id = module.dev_tools_mymodule.id
    region = module.dev_tools_mymodule.location
    resource_group_name = module.resource_group.name
  })
}
