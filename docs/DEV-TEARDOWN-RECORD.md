# Dev Teardown Record

## Status

The Zen Pharma `dev` runtime was intentionally removed on 2026-09-12 to stop
cost-bearing development infrastructure when it was no longer in use.

Approval received:

> APPROVE DEV TEARDOWN AND PERMANENT DATABASE DATA DELETION. PRESERVE ECR
> IMAGES, TERRAFORM STATE, CODE, AND DOCUMENTATION.

No QA or production environment was changed.

## Teardown result

| Resource group | Result |
| --- | --- |
| Nine Argo CD dev applications | Deleted with cascading workload cleanup |
| Kubernetes `dev` namespace | Deleted |
| Application Load Balancer | Deleted and independently verified absent |
| EKS cluster and four-node managed node group | Deleted and independently verified absent |
| RDS PostgreSQL instance | Deleted without final snapshot, as approved |
| NAT Gateway, Internet Gateway, subnets, routes, and VPC | Deleted and independently verified absent |
| Dev IAM roles, policies, and OIDC providers | Deleted |
| Dev Secrets Manager secrets | Deleted and independently verified absent |
| Terraform-managed runtime resources | 80 resources destroyed |

The reviewed Terraform plan contained `0 to add, 0 to change, 80 to destroy`.
It was created with explicit targets that excluded the ECR module.

## Preserved assets

| Asset | Preservation evidence |
| --- | --- |
| Application source and workflows | Stored in GitHub repositories |
| Infrastructure source | Stored on the infrastructure repository `main` branch |
| GitOps desired state | Stored in the GitOps repository |
| Documentation and diagrams | Stored under `docs/` on `main` |
| Terraform remote state | `s3://zen-pharma-terraform-state-roland/envs/dev/terraform.tfstate` |
| Container images | All nine ECR repositories preserved |
| ECR lifecycle configuration | Preserved in Terraform state |

Preserved repositories:

1. `api-gateway`
2. `auth-service`
3. `drug-catalog-service`
4. `inventory-service`
5. `manufacturing-service`
6. `notification-service`
7. `pharma-ui`
8. `qc-service`
9. `supplier-service`

ECR storage and the S3 state object can still incur small storage charges. The
major dev runtime costs from EKS, EC2 nodes, RDS, NAT Gateway, and ALB have been
removed.

## Data-loss record

The RDS module was configured with `skip_final_snapshot = true` and backup
retention `0`. The dev database and its data were permanently deleted. On the
next deployment, application Flyway migrations will create fresh schemas and seed
development data. This teardown is not a database restore point.

## Redeployment outline

The next deployment is a fresh dev build, not a cluster power-on operation:

1. Review current AWS, Kubernetes, Terraform provider, and Helm chart versions.
2. Confirm required GitHub environment secrets and approvals exist.
3. Run the Terraform workflow for `dev` and approve the reviewed apply.
4. Update the local kubeconfig for the newly created EKS cluster.
5. Install pinned platform controllers using `kubernetes/dev/platform-values/`.
6. Confirm External Secrets recreates the Kubernetes secrets.
7. Bootstrap the dev Argo CD project and nine Applications from `zen-gitops`.
8. Confirm all applications are Synced/Healthy and all pods are Ready.
9. Verify ALB target health, UI, authentication health, and service health.
10. Record the new resource IDs, endpoint, image tags, and validation evidence.

The new RDS endpoint, VPC ID, subnet IDs, ALB hostname, EKS OIDC issuer, and role
ARNs will differ from the deleted deployment. Update GitOps environment values
that contain generated endpoints or ARNs before workload synchronization.

## Monitoring note

The deleted deployment included Metrics Server only. Prometheus and Grafana were
not installed. Their design and GitOps configuration must be implemented and
reviewed before claiming full metrics visibility on the next deployment.

## Verification evidence

Post-teardown AWS checks returned:

- EKS `ResourceNotFoundException` for `pharma-dev-cluster`.
- RDS `DBInstanceNotFound` for `pharma-dev-postgres`.
- EC2 `InvalidVpcID.NotFound` for `vpc-0ee0ea7c821090976`.
- No non-deleted dev NAT Gateways.
- ELB `LoadBalancerNotFound` for the former dev ALB.
- No `/pharma/dev/` secrets, including secrets pending deletion.
- Nine ECR repositories still present.
- Remote Terraform state object present and updated after teardown.

## Future cost check

After billing data catches up, review AWS Cost Explorer and the following services:

- EKS and EC2
- RDS
- EC2 NAT Gateway and Elastic IP
- Elastic Load Balancing
- ECR storage
- S3 state storage
- KMS keys scheduled for deletion

AWS billing metrics are not immediate. Resource absence is the operational proof;
Cost Explorer may take hours to reflect the reduction.
