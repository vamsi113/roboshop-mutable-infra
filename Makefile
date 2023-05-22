
dev:
	rm -rf .terraform*

#prod:
#    rm -rf .terraform*
#    git pull
#    terrafile -f env-prod/Terrafile
#    #terraform init
#    #terraform apply --auto-approve
#
#
#dev-destroy:
#    rm -rf .terraform*
#    git pull
#    terrafile -f env-dev/Terrafile
#    #terraform init
#    #terraform destroy --auto-approve
#
#
#prod-destroy:
#    rm -rf .terraform*
#    git pull
#    terrafile -f env-prod/Terrafile
#    #terraform init
#    #terraform destroy --auto-approve
