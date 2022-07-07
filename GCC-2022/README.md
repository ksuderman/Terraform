# GCC 2022 Infrastructure

A simple Terraform plan for launching multiple instances on Jetstream2.

## Prerequisites

1. An `openrc.sh` file from Jetstream2
1. The `gcc-2022` SSH private key if you wish to SSH into any of the instances.
1. A directory named `inventories` in the current directory.  Since the directory is empty it may not be present in the GitHub repository
1. A pre-existing network.  Be sure to change the `network` variable in the `variables.tf` file.

The OpenStack/Jetstream credentials are loaded from environment variables sourced from the `openrc.sh` file.  The credentials and SSH keys are generated in a separate procedure.

## Usage

```bash
source js2-gcc-openrc.sh
terraform init
terraform apply -var "num_nodes=N" -auto-approve
```

The value of `N` is only restricted by the available CPU, memory, and storage in the allocation.

To create multiple clusters from the same plan you must specify the name of the state file for the cluster. The `state` directory is provided for this purpose.

```bash
terraform apply -state=state/GCC-2022 ...
...
terraform destroy -state=state/GCC-2022
```

Inventory files for use with Ansible will be created in the `inventories` directory.

## Notes

A different SSH key can be used by redefining the `key_pair` variable in the `variables.tf` file.

```bash
terraform apply -var "key_pair=my_ssh_key" ...
```

## Future Work

~~Generate a new SSH key as part of the provisioning process.~~ Generating the SSH key should be done in a separate step.

Get building a network/subnet/router working correctly.

Store state in an S3 bucket.
