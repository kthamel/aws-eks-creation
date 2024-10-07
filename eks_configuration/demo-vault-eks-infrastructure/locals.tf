locals {
  Name    = "Resource_EKS"
  Project = "DevOps"
}

locals {
  common_tags = {
    Name           = local.Name
    DevOps_Project = local.Project
  }
}
