#TODO: Delete if we start to use "direnv"
export TF_VAR_environment = prod
#export TF_LOG=DEBUG

TERRAFORM_PROJECTS = 1_bootstrap
INIT_TARGETS = $(addprefix init_, $(TERRAFORM_PROJECTS))
PLAN_TARGETS = $(addprefix plan_, $(TERRAFORM_PROJECTS))
APPLY_TARGETS = $(addprefix apply_, $(TERRAFORM_PROJECTS))
DESTROY_TARGETS = $(addprefix destroy_, $(TERRAFORM_PROJECTS))
UNLOCK_TARGETS = $(addprefix unlock_, $(TERRAFORM_PROJECTS))

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# -----------------------------------------------------------------
# initial project setup
# -----------------------------------------------------------------
.PHONY: setup
setup:
	mkdir -p ~/.config/ansible/
	mkdir -p ~/.terraform.d/plugin-cache/
	[ ! -f ~/.terraformrc ] && echo "plugin_cache_dir   = \"$(HOME)/.terraform.d/plugin-cache\"" > ~/.terraformrc || true
	$(info ---)
	$(info  Please make sure you have exported ENV Vars)
	$(info ---)
#	 ./backend.sh >> /dev/null 2>&1

# -----------------------------------------------------------------
# terraform  init
# -----------------------------------------------------------------
.PHONY: init
init: setup $(INIT_TARGETS) ## create ~/.kube/config-um and run terraform init all

$(INIT_TARGETS): setup
	terraform -chdir=$(subst init_,,$@) init
	terraform -chdir=$(subst init_,,$@) workspace select ${TF_VAR_environment} || terraform -chdir=$(subst init_,,$@) workspace new ${TF_VAR_environment}

# -----------------------------------------------------------------
# terraform  plan
# -----------------------------------------------------------------
.PHONY: plan
plan: $(PLAN_TARGETS) ## terraform plan all

.PHONY: $(PLAN_TARGETS)
$(PLAN_TARGETS):
	terraform -chdir=$(subst plan_,,$@) plan -compact-warnings

# -----------------------------------------------------------------
# terraform  apply
# -----------------------------------------------------------------
.PHONY: apply
apply: ## terraform apply -auto-approve all
	for target in $(subst apply_,,$(APPLY_TARGETS)) ; do \
		terraform -chdir=$$target apply -auto-approve ; \
	done

.PHONY: $(APPLY_TARGETS)
$(APPLY_TARGETS):
	terraform -chdir=$(subst apply_,,$@) apply
#terraform -chdir=$(subst apply_,,$@) import module.acm[0].aws_acm_certificate.cert arn:aws:acm:me-south-1:XXX

# -----------------------------------------------------------------
# terraform  destroy
# -----------------------------------------------------------------
.PHONY: $(DESTROY_TARGETS)
$(DESTROY_TARGETS):
	terraform -chdir=$(subst destroy_,,$@) destroy

# -----------------------------------------------------------------
# terraform  unlock
# -----------------------------------------------------------------
.PHONY: $(UNLOCK_TARGETS)
$(UNLOCK_TARGETS):
	terraform -chdir=$(subst unlock_,,$@) force-unlock 52c52e8a-c2b4-a857-453e-6f1bd1f55386


.PHONY: magento
magento: ## setup magento
	ansible-playbook --private-key=~/.ssh/privateKey ansible/site.yml

# -----------------------------------------------------------------
# remove temporary terraform files
# -----------------------------------------------------------------
.PHONY: clean
clean: ## remove .terraform
	find . -name .terraform -exec rm -rf {} \;
