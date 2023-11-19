# Learn Terraform - Provision a Magento application on AWS

Terraform configuration files to provision a Magento application on AWS.

Select Latest Debian AMI from here:
https://wiki.debian.org/Cloud/AmazonEC2Image/Bookworm

To run the code you need to clone the repository on your local development environment:
* Needed software:
  * ansible >= 2.7 (for ansible-vault)
  * terraform >= 1.2.x
  * make
  * git

After you clone the current repo:<br />
``git clone git@github.com:open-servus/open-magento.git``

### cd terraform/

you need to export your private ENV credentials:


1. AWS Account Credentials: Access key ID & Secret access key
2. Your SSH Public key to access the servers
3. Your RDS master passwrod
4. Your Magento crendentials and some secured cred like db user pass
```
export AWS_ACCESS_KEY_ID="xxxx"
export AWS_SECRET_ACCESS_KEY="xxxx"
export ssh_public_key="ssh-xxx xxxxxx"
export aws_rds_master_pass="testtest"
export magento_public_key="xxx"
export magento_private_key="xxx"
export pma_project_pass="testtest"
export db_user_pass="testtest"


##
export TF_VAR_ssh_public_key=$ssh_public_key
export TF_VAR_aws_rds_master_pass=$aws_rds_master_pass
export TF_VAR_environment="prod"
```

Now you are good to go.

Next step run:
#### make init

#### make plan_1_bootstrap
#if no errors 

#### make apply_1_bootstrap

#### make magento

To delete the environment and AWS resources
#### make destroy_1_bootstrap

This will clear all AWS resources.