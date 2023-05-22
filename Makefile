dev:
    rm -rf .terraform*
    git pull
    terrfile -f env-dev/Terrafile
    #terraform init
    #terraform apply --auto-approve


prod:
    rm -rf .terraform*
    git pull
    terrfile -f env-prod/Terrafile
    #terraform init
    #terraform apply --auto-approve


dev-destroy:
    rm -rf .terraform*
    git pull
    terrfile -f env-dev/Terrafile
    #terraform init
    #terraform destroy --auto-approve


prod-destroy:
    rm -rf .terraform*
    git pull
    terrfile -f env-prod/Terrafile
    #terraform init
    #terraform destroy --auto-approve
