# Zen Pharma Pre-Deployment Checklist

This checklist is the release gate companion to `KUBERNETES-DEPLOYMENT-DESIGN.md`. A blank item is a deployment blocker unless the owner records an approved exception.

## Scope and ownership

- [ ] First target is explicitly limited to `dev`, or QA/prod Terraform has been added and approved.
- [ ] AWS account, region, cluster, domains, namespaces, and repository URLs are recorded.
- [ ] Application, platform, security, database, and incident owners are named.
- [ ] `workflow-intro` is confirmed as training-only and has no production credentials.

## Infrastructure

- [ ] Terraform format, validate, and reviewed plan pass.
- [ ] EKS version and all managed add-on versions are supported together.
- [ ] Node capacity supports requests, disruption, rolling updates, and an Availability Zone failure.
- [ ] ECR repositories exist for all nine workloads.
- [ ] RDS is private, encrypted, backed up, monitored, and reachable only from approved workloads.
- [ ] QA and production do not reference the dev database.
- [ ] AWS Load Balancer Controller, External Secrets Operator, Metrics Server, DNS/TLS, and monitoring are installed and healthy.

## GitOps

- [ ] Exactly one Argo CD Application/ApplicationSet owns each workload.
- [ ] Invalid `pharma-qa` and `pharma-prod` values-directory Applications are removed.
- [ ] Duplicate auth Applications are removed.
- [ ] All nine workloads exist in each enabled environment.
- [ ] Production does not use automated sync or floating `HEAD` policy.
- [ ] Helm lint, template, schema validation, kubeconform, server dry-run, and policy tests pass.
- [ ] No account IDs, endpoints, secret data, placeholders, or `latest` tags violate policy.

## Application and container

- [ ] Backend test suites and frontend tests pass at required coverage.
- [ ] Each image builds reproducibly and runs using its Kubernetes security context.
- [ ] Images run as non-root and support a read-only root filesystem, or have a reviewed exception.
- [ ] Startup, readiness, and liveness probes are semantically correct.
- [ ] Graceful shutdown completes within the configured termination period.
- [ ] Runtime configuration names match the application contract.
- [ ] Non-local profiles fail startup when DB or JWT secrets are absent.
- [ ] UI-to-gateway and gateway-to-service routes pass contract tests.

## Security

- [ ] GitHub Actions use OIDC and least-privilege IAM; no static AWS key exists.
- [ ] Images pass vulnerability policy and verify with Cosign.
- [ ] GitHub Actions and platform charts are version pinned.
- [ ] External Secrets uses environment-scoped IRSA permissions.
- [ ] Pod Security Admission and admission policy tests pass.
- [ ] Network policy allows only documented traffic and DNS/RDS/provider egress.
- [ ] TLS, WAF, security headers, CORS, and rate-limit policy are approved.
- [ ] Argo CD access uses SSO, RBAC, TLS, and restricted network exposure.

## Data and resilience

- [ ] Each schema has a single migration owner.
- [ ] Migrations are backward compatible with the prior application version.
- [ ] Backup restore has been timed and verified in a non-production environment.
- [ ] PDB, HPA, topology spread, and rollout strategy are tested under disruption.
- [ ] Rollback to the prior image digest is tested.
- [ ] RTO and RPO are approved and supported by backups/replication.

## Observability and release

- [ ] Structured logs, metrics, traces, dashboards, and alerts are visible.
- [ ] Release annotations connect deployments to commits and image digests.
- [ ] Automated smoke tests cover login and every gateway route.
- [ ] Load and failure tests pass agreed thresholds.
- [ ] Runbook, escalation path, change record, observation window, and rollback owner are ready.
- [ ] All exceptions have owner, risk, expiry, and compensating control.

## Final authorization

- [ ] Dev deployment approved.
- [ ] QA promotion approved after dev evidence.
- [ ] Production readiness review approved after QA evidence.
- [ ] Production change approved for a specific commit and image digest set.
