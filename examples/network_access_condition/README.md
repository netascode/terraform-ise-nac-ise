<!-- BEGIN_TF_DOCS -->
# ISE Network Access Condition Example

Set environment variables pointing to ISE:

```bash
export ISE_USERNAME=admin
export ISE_PASSWORD=Cisco123
export ISE_URL=https://10.1.1.1
```

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

#### `network_access_condition.yaml`

```yaml
---
ise:
  network_access:
    policy_elements:
      conditions:
        - name: CertificateNotExpired
          type: LibraryConditionAttributes
          is_negate: false
          dictionary_name: CERTIFICATE
          attribute_name: Is Expired
          operator: equals
          attribute_value: "False"
```

#### `main.tf`

```hcl
module "ise" {
  source  = "netascode/nac-ise/ise"
  version = ">= 0.1.0"

  yaml_files = ["network_access_condition.yaml"]
}
```
<!-- END_TF_DOCS -->