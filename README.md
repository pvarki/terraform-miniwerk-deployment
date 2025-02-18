# Terraform config to provision a full RASENMAEHER+TAK in Azure

## Usage

Provisioning requires Terraform & Azure CLI. Before provisioning you need to
authenticate, different authentication schemes are documented [here](https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash?tabs=bash#5-authenticate-terraform-to-azure).

After the authentication is completed, you must once initialize your local TF state:

```bash
terraform init
```

To preserve your sanity create `myname.tfvars` -file with the RSA key you
use for SSH (needed to get the first time login code):

```bash
SSH_PUBLIC_KEY = "ssh-rsa REDACTED me@mymachine.local!"
```

Make sure you have [jq](https://jqlang.github.io/jq/) installed.
Then to provision a new instance run:

```bash
terraform workspace new my_deployment
./tf_wrapper.sh myname.tfvars
```

Any extra options given to `tf_wrapper.sh` will be passed to `terraform apply`.
if you like to live dangerously`--auto-approve` is a good one.

The script will then do things, if you didn't add auto-approve TF will ask for confirmation,
it will then do more things and finally you get a bit more instructions that looke like this:

```
** Run following curl command to test that at least RASENMAEHER container is up **
  curl -s https://deployment-name.pvarki.fi/api/v1/healthcheck/services | jq .
** When curl replies run following SSH command to get the admin login code **
  ssh azureuser@deployment-name.pvarki.fi 'sudo docker exec rmvm-rmapi-1 /bin/bash -lc "rasenmaeher_api addcode"'
```

Since TF will return long before cloud-init finishes running you need to use curl to check when RASENMAEHER container
is actually up, after that it's just a call over SSH to generate admin login code.

## Usage with Azure DevOps pipeline

Requires Azure crendentials for PVARKI and access to keyvault *pvarki-shared-kv001*.

Log in to ```portal.azure.com``` with our PVARKI credentials and use service search and navigate to
*AzureDevops organizations*. Go to *My Azure DevOps Organizations* link. Link opens to new tab.

Under projects, navigate to *PVARKI* then to *Pipelines*. Under pipelines, choose pvarki.terraform-miniwerk-deployment.
There will be warning shown, ignore that. Choose *Run Pipeline*. From *Branch/tag* change branch to *azurepipelines* and
variables will be shown.

To *SSH_PUBLIC_KEY* copy and paste contents of *sshpubkey* (SSH public key). Optionally you can use your own key pair.
To *WORKSPACE_NAME* put unique name for your unique name for deployment. Other variables are auto-generated. Click *Run*.
You can check progress by clicking Create action. When pipeline has ran through, you can check deployment name from
*Terraform apply* steps outputs.

It will take some time after Terraform deployment has completed to all of the containers be up and running. You can check status with:

```
** Run following curl command to test that at least RASENMAEHER container is up **
  curl -s https://deployment-name.pvarki.fi/api/v1/healthcheck/services | jq .
```

Once service reports to be healthy, for admin login code run:

```
** When curl replies run following SSH command to get the admin login code **
  ssh azureuser@deployment-name.pvarki.fi 'sudo docker exec rmvm-rmapi-1 /bin/bash -lc "rasenmaeher_api addcode"'
```

To clean up, run pipeline again with same *WORKSPACE_NAME* and uncheck *CREATE* checkbox. This will run Terraform destroy for said
deployment.

## pre-commit considerations

We use [pre-commit framework][pc] for various things, most notably it will autogenerate
the docs below, you need to run `pre-commit run --all-files` before committing to
make sure everything is ok and up-to-date.

Remember to also enable pre-commit on your local checkout with `pre-commit install`

You will need `terraform-docs` and `tflint` installed in PATH, everything else pre-commit
should be able to handle by itself.

[pc]: https://pre-commit.com/#install

# Terraform docs (autogenerarated)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |
| <a name="requirement_xkcdpass"></a> [xkcdpass](#requirement\_xkcdpass) | ~>1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.82.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_xkcdpass"></a> [xkcdpass](#provider\_xkcdpass) | 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.bl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.fake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.kc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.mtls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.mtls_bl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.mtls_fake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.mtls_kc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.mtls_tak](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.tak](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_pet.rg_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [xkcdpass_generate.kc_admin_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.kc_db_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.kc_keystore_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.kc_ldap_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.kc_truststore_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.postgres_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.rm_db_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.tak_db_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.tak_jks1_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [xkcdpass_generate.tak_jks2_pass](https://registry.terraform.io/providers/advian-oss/xkcdpass/latest/docs/resources/generate) | resource |
| [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CERTBOT_EMAIL"></a> [CERTBOT\_EMAIL](#input\_CERTBOT\_EMAIL) | Email address to send certificate expiration notifications. | `string` | `"benjam.gronmark_arkiproj@hotmail.com"` | no |
| <a name="input_DEPLOYMENT_NAME"></a> [DEPLOYMENT\_NAME](#input\_DEPLOYMENT\_NAME) | Set DNS name, if not set will be automatically generated | `string` | `null` | no |
| <a name="input_DOCKER_COMPOSITION_REPO"></a> [DOCKER\_COMPOSITION\_REPO](#input\_DOCKER\_COMPOSITION\_REPO) | The repo to use to get the docker-composition from | `string` | `"https://github.com/pvarki/docker-rasenmaeher-integration.git"` | no |
| <a name="input_DOCKER_REPO_TAG"></a> [DOCKER\_REPO\_TAG](#input\_DOCKER\_REPO\_TAG) | The branch/tag in DOCKER\_COMPOSITION\_REPO to use | `string` | `"1.7.0"` | no |
| <a name="input_DOCKER_TAG_EXTRA"></a> [DOCKER\_TAG\_EXTRA](#input\_DOCKER\_TAG\_EXTRA) | If you want to deploy for example a PR tagged version, messing this up is a good way to make everything take forever | `string` | `""` | no |
| <a name="input_EXPIRES"></a> [EXPIRES](#input\_EXPIRES) | ISO 8601 date (yyyy-mm-dd) after which this resource is cleaned up, defaults to 30days from now | `string` | `null` | no |
| <a name="input_RESOURCE_GROUP_LOCATION"></a> [RESOURCE\_GROUP\_LOCATION](#input\_RESOURCE\_GROUP\_LOCATION) | Location of the resource group. | `string` | `"northeurope"` | no |
| <a name="input_RESOURCE_GROUP_NAME_PREFIX"></a> [RESOURCE\_GROUP\_NAME\_PREFIX](#input\_RESOURCE\_GROUP\_NAME\_PREFIX) | Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription. | `string` | `"rg-miniwerk"` | no |
| <a name="input_SSH_PUBLIC_KEY"></a> [SSH\_PUBLIC\_KEY](#input\_SSH\_PUBLIC\_KEY) | RSA (Azure does not support Elliptic Curve keys) Public key for admin SSH-connections (required) | `string` | n/a | yes |
| <a name="input_VITE_ASSET_SET"></a> [VITE\_ASSET\_SET](#input\_VITE\_ASSET\_SET) | Which asset set to use for RM UI | `string` | `"neutral"` | no |
| <a name="input_VM_DISK_SIZE"></a> [VM\_DISK\_SIZE](#input\_VM\_DISK\_SIZE) | Disk size for VM | `string` | `"30"` | no |
| <a name="input_VM_SIZE"></a> [VM\_SIZE](#input\_VM\_SIZE) | The SKU which should be used for this Virtual Machine, e.g. Standard\_B4ms | `string` | `"Standard_B4ms"` | no |
| <a name="input_ZONE_DNS_NAME"></a> [ZONE\_DNS\_NAME](#input\_ZONE\_DNS\_NAME) | DNS Zone to place mumbler server under | `string` | `"solution.dev.pvarki.fi"` | no |
| <a name="input_ZONE_RESOURCE_GROUP"></a> [ZONE\_RESOURCE\_GROUP](#input\_ZONE\_RESOURCE\_GROUP) | Resource group where the DNS zone resides | `string` | `"FDF-PVARKI-SOLUTION-static"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | FQDN for RASENMAEHER |
<!-- END_TF_DOCS -->
