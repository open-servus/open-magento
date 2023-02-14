# Learn Terraform - Provision a Magento application on AWS

Terraform configuration files to provision a Magento application on AWS.

Select Latest Debian AMI from here:
https://wiki.debian.org/Cloud/AmazonEC2Image/Bullseye

To run the code you need to clone the repository on your local development environment:
* Needed software:
  * ansible >= 2.7 (for ansible-vault)
  * terraform >= 1.2.x
  * make
  * git

After you clone the current repo:<br />
``git clone git@github.com:open-servus/open-magento.git``

### cd terraform/

you need to add your private credentials:
1. Ansible Vault credentials that you have on your local machine, usually on below path:<br />
``~/.config/ansible/vault_pass_data``<br />
ansible-vault edit tf-env-config/secrets/ansible.enc.yml <br />
``###The file will contain as below###``<br />
ansible_vault_password: xxx <br />
``######``<br />


2. AWS Account Credentials: Access key ID & Secret access key
on the file:<br />
terraform/tf-env-config/secrets
run ansible-vault:
ansible-vault edit tf-env-config/secrets/aws_private_info.enc.yml<br />
``###The file will contain as below###``<br />
access_key: XXXX<br />
secret_key: XXXX<br />
``######``<br />

3. Your SSH Public key to access the servers
ansible-vault edit tf-env-config/secrets/ssh_public_key.enc.yml<br />
``###The file will contain as below###``<br />
ansible_vault_public_key: "ssh-xxx xxxx"<br />
``######``<br />

4. Your RDS master passwrod
ansible-vault edit tf-env-config/secrets/infra.enc.yml<br />
``###The file will contain as below###``<br />
aws_rds_master_pass: xxxx<br />
``######``<br />

5. Your Magento crendentials and some secured cred like db user pass
ansible-vault edit ansible/group_vars/all/magento.enc.yml<br />
``###The file will contain as below###``<br />
magento_public_key: xxx<br />
magento_private_key: xxx<br />
pma_project_pass: xxx<br />
db_user_pass: xxx<br />
``######``<br />


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