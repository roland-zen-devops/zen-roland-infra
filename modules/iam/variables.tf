variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name (dev, qa, prod)"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the EKS OIDC provider"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or username that owns frontend and backend"
  type        = string
}

variable "github_org_id" {
  description = "Numeric GitHub organization/owner ID. Fetch via: curl https://api.github.com/orgs/<github_org>"
  type        = string
}

variable "github_repo_ids" {
  description = "Map of GitHub repo name to its numeric GitHub repository ID. Fetch via: curl https://api.github.com/repos/<github_org>/<repo>"
  type        = map(string)
}

variable "github_actions_repositories" {
  description = "Map of repository names to immutable GitHub IDs allowed to assume the Actions role"
  type        = map(string)
}

variable "github_actions_ecr_repositories" {
  description = "ECR repositories to which GitHub Actions may publish images"
  type        = set(string)
}
