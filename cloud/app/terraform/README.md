### Terraform

[**This Terraform template is baed on module composition**](https://developer.hashicorp.com/terraform/language/modules/develop/composition)

| **What Works**               | **To be developed**                   |
| ---------------------------- | ------------------------------------------ |
| ✅ Container_Instance        | ❌ Provision WAF                           |
| ✅ Private_Subnet_CI          | ❌ Create Object Storage                    |
| ✅ Public_Subnet_LB           | ❌ Online Migration Services with IPSec and CPE |
| ✅ Load_Balancer              | ❌ AutoScale Trigger for OCI Instance      |
| ✅ VCN                        | ❌ Alarm Notifications                      |
| ✅ KMS_Compartment            | ❌ Basic Groups, Users, and Policies       |
| ✅ Autonomous_Database        |                                            |


---

### Provisioning

1. [Generate OCI API Key for console authentication](https://askmedawaa.wordpress.com/2022/09/05/generate-an-api-signing-key-using-console-in-oci-for-the-user/)
2. [Install Terraform](https://developer.hashicorp.com/terraform/install)
3. Edit variables in `./cloud/app/terraform/terraform.tfvars.json`
4. Run the following commands:

```bash
cd cloud/app/terraform/
terraform plan -var-file terraform.tfvars.json
terraform apply -var-file terraform.tfvars.json
```
