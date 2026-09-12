# Zen Pharma Platform Documentation

Start here before any Kubernetes deployment:

1. Study the [Dev Deployment Handbook](DEV-DEPLOYMENT-HANDBOOK.md) for the complete reusable architecture, delivery, operations, and troubleshooting guide.
2. Review [Kubernetes Deployment Design](KUBERNETES-DEPLOYMENT-DESIGN.md) for the current-state audit, target architecture, security model, delivery flow, implementation phases, and approval record.
3. Use the [Pre-Deployment Checklist](PRE-DEPLOYMENT-CHECKLIST.md) as the release gate for each environment.
4. Review the [Dev Deployment Record](DEV-DEPLOYMENT-RECORD.md) for the deployed versions, validation evidence, runtime diagram, and rollback approach.
5. Review the [Dev Teardown Record](DEV-TEARDOWN-RECORD.md) for the current offline state, preserved assets, cost notes, and redeployment sequence.

The former `dev` workload was intentionally destroyed on 2026-09-12 to reduce cost. ECR images, Terraform state, code, and documentation are preserved. This does not affect QA or production.
