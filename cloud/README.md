# OCI Container Instance

The OCI Container Instance Service is chosen to expedite the migration process.

## New Architecture Diagram

![Reference Architecture](img/oci_webapp_architecture.svg)

### Why OCI Container Instance Services?

- **Low infrastructure complexity**
- **Flexibility to specify instance shapes**
- **Scalability and high availability**
- **Automation based on events**

The legacy web app encounters scalability issues due to resource constraints. OCI Container Instance, being serverless, eliminates the need for complex setups like Kubernetes clusters or VMs with a load balancer. The migration involves adopting DevOps practices and services for automated development, testing, and deployment.

**Console Migration Option:**

While it is possible to perform migration tasks through the Oracle Cloud Infrastructure (OCI) web console, using Terraform is recommended for its idempotency, cost-effectiveness in avoiding duplicated resources, and reduction of human errors in the deployment process.

1. Create a repository on OCIR.;
2. Build and push container image to OCIR;
3. Create a container instance and point to that image.;
4. Choose container shape, network, and image from OCIR.;
5. Create an event rule, select the condition "Event Type" service "Resource Manager" event Type "Stack-Create," and follow the documentation [OCI Container Instances Overview](https://docs.oracle.com/en-us/iaas/Content/container-instances/overview-of-container-instances.htm).;
6. Create OCI autonomous database;
7. Create a database dump;
6. Use Oracle Data Pump;
9. Test Application;
10. Change DNS records to public loadbalancer or WAF.


---


### Option for the future

**GitLab SCM for DevOps and Kubernetes**

1. **Prepare GitLab SCM:**
   - Create a corporate account email on GitLab.
   - Establish an organization.
   - Create a project.
   - Set up a Kanban board for planning.
   - Create a repository and upload the web app code.
   - Use SemVer tagging.
   - Implement a GitLab CI pipeline.
   - Employ self-managed runners.

2. **For Future Plans:**
   - Consider transitioning to a microservices architecture.
   - Adopt Kubernetes orchestration for scalability.

**DevOps Architecture**

![Reference Architecture](img/devops-architecture.svg)

**Container Engine for Kubernetes (OKE)**

![Reference Architecture](img/deploy_oke_with_atp_in_oci.svg)

GitLab SCM serves as the platform for code storage and automation. Terraform is utilized for deployment to Oracle Cloud Infrastructure (OCI). This approach ensures idempotent infrastructure provisioning.

1. A developer pushes a commit to a remote Git repository.
2. The commit triggers a CI/CD pipeline upon reaching a conventional branch.
3. A runner executes the automation routine, accessing secrets from Oracle Key Vault.
4. After tests, a new release tag is created.
5. An image is built and pushed to Oracle Container Registry (OCIR).
6. Update Oracle Container Instance to the latest tag.

## Database Migration

### On-Premises Database Migration to Oracle Cloud

1. **Assessment:**
   - Identify the on-premises database schema, data size, and dependencies.
   - Evaluate Oracle Cloud Database options (e.g., Autonomous Database, Database Cloud Service).

2. **Data Migration:**
   - Use Oracle Data Pump or other compatible tools to export data from the on-premises database.
   - Create a database in Oracle Cloud Infrastructure (OCI).
   - Import the data into the OCI database.

3. **Application Configuration:**
   - Update the web app configuration to connect to the new OCI database.
   - Test the web app to ensure proper connectivity and functionality.

4. **DNS**
   - Point DNS records to public loadbalancer or WAF if it's available

### Container Image Migration

1. **Image Building:**
   - Review the existing Dockerfile for the web app container.
   - Make necessary adjustments for compatibility with OCI Container Instance.
   - Build a new container image.

2. **Registry Push:**
   - Push the new container image to Oracle Container Registry (OCIR).

3. **Container Instance Update:**
   - Update OCI Container Instance configuration to use the latest container image.

## DNS Migration

DNS records don't need migration but are easier to manage with Infrastructure as Code (IAC) using an API endpoint. Change the A record to the WAF or public load balancer IP and wait for TTL for access to the new services.

## Auto Scaler with OCI Functions

OCI Functions act as smart helpers for Container Instances, providing serverless scaling abilities. They automatically add resources during busy periods, ensuring optimal performance. A Python script for OCI Functions can be found [here](https://github.com/karthicgit/ocifunctions-sample/tree/main/CIautoscale).

## Preview of Terraform Resources

Explore the terraform folder (/cloud/app/terraform) for provisioning a part of this infrastructure.

Click on the image below:

[<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/2560px-Terraform_Logo.svg.png" width="300">](app/terraform/README.md)


---

*Note: For a quicker setup, many of these configurations can also be done easily through the Oracle Cloud web console.*

**References:**
- [Terraform Provider for OCI Documentation](https://registry.terraform.io/providers/oracle/oci/latest/docs)
- [Autoscaling Oracle Container Instances](https://docs.oracle.com/en/solutions/autoscale-oracle-container-instances/index.html#GUID-2796F988-7CBA-4049-8E03-352117950CD1)
- [OCI Container Instance Sample](https://github.com/cpruvost/ocicontinst)
- [OCI Autonomous Database Documentation](https://docs.oracle.com/en-us/iaas/tools/terraform-provider-oci/5.24/docs/r/database_autonomous_database.html)
- [OCI Functions Auto Scaler Python Script](https://github.com/karthicgit/ocifunctions-sample/tree/main/CIautoscale)
- [OCI Notification Alarm Variables](https://github.com/karthicgit/Terraformoci/blob/main/NotificationAlarm/variables.tf)
- [OCI Networking Terraform Module](https://github.com/oracle-quickstart/terraform-oci-networking?ref=0.2.0)
- [Use Oracle Data Pump](https://docs.oracle.com/en-us/iaas/autonomous-database/doc/use-oracle-data-pump.html)
