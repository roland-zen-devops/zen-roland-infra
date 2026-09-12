# Development Kubernetes platform

This directory records the pinned Helm configuration used for the Zen Pharma
development EKS cluster. It does not contain secret values.

## Cluster identity

- AWS account: `651706754162`
- Region: `us-east-1`
- EKS cluster: `pharma-dev-cluster`
- kubectl context: `pharma-dev`
- VPC: `vpc-0ee0ea7c821090976`

## Platform releases

| Release | Namespace | Chart | Version | Purpose |
|---|---|---|---:|---|
| `metrics-server` | `kube-system` | `metrics-server/metrics-server` | `3.14.0` | Resource metrics API |
| `aws-load-balancer-controller` | `kube-system` | `eks/aws-load-balancer-controller` | `3.5.0` | ALB reconciliation |
| `external-secrets` | `external-secrets` | `external-secrets/external-secrets` | `2.10.0` | AWS Secrets Manager synchronization |
| `argocd` | `argocd` | `argo/argo-cd` | `10.9.0` | GitOps reconciliation |

## Trust boundaries

- AWS Load Balancer Controller uses IRSA role
  `pharma-dev-alb-controller-role`.
- External Secrets Operator uses IRSA role `pharma-dev-eso-role`.
- Argo CD is exposed only as a `ClusterIP`; access is through an authenticated
  local port-forward until company SSO and TLS are configured.
- Application delivery is restricted to the `dev` namespace.

## Installation order

```text
Metrics Server
  -> AWS Load Balancer Controller
  -> External Secrets Operator
  -> Argo CD
  -> dev namespace and ExternalSecret resources
  -> Argo CD project and nine dev Applications
```

Every Helm release must complete with `--wait`. Verify controller rollouts and
CRDs before proceeding to the next layer. Application deployment requires a
separate approval after the platform-controller health review.
