# elasticsearch
###  Prerequisites
- **Ansible** 
- **Terraform**

## How to run 
Export the below env in the host machie

```
export    TF_VAR_USER_NAME=ubuntu
export    TF_VAR_PRIVATE_KEY=<path_to_the_privatekey>
export    TF_VAR_PUBLIC_KEY=<path_to_the_publickey>
export    AWS_ACCESS_KEY=*********'
export    AWS_SECRET_KEY=************'
```

- **Run the below steps**
```
terraform plan
```

```
terraform apply 
```
