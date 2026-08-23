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
  default     = "EnohRoland"   # filled in Lab 5
}

variable "github_org_id" {
  description = "Numeric GitHub org/owner ID"
  type        = string
  default     = "68199045"   # filled in Lab 5
}

variable "github_repo_ids" {
  description = "Map of repo name to numeric GitHub repo ID"
  type        = map(string)
  default     = {}   # filled in Lab 5
}