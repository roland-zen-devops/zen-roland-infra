variable "db_password" {
  description = "Master password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret for the application"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "GitHub username or organization"
  type        = string
  default     = "roland-zen-devops"
}

variable "github_org_id" {
  description = "Numeric GitHub org/owner ID"
  type        = string
  default     = " 320181056" # filled in Lab 5
}

variable "github_repo_ids" {
  description = "Map of repo name to numeric GitHub repo ID"
  type        = map(string)

  default = {
    "zen-roland-infra"         = "1343724092"
    "roland-zen-backend-lab1"  = "1344126819"
    "roland-zen-phama-backend" = "1344126169"
    "roland-zen-frontend"      = "1344127987"
  }
}
