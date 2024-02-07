#!/usr/bin/env bash
set -e
if [ -z "$1" ]
then
  echo "You must give path to your tfvars file"
  exit 1
fi
VARFILE=$1
shift
set -x
terraform apply -var-file=$VARFILE $@
set +x
MW_DNS=$(terraform show -json | jq -r .values.outputs.dns_name.value)
echo "** Run following curl command to test that at least RASENMAEHER container is up **"
echo "  curl -s https://"$MW_DNS"/api/v1/healthcheck/services | jq ."
echo "** When curl replies run following SSH command to get the admin login code **"
echo "  ssh azureuser@"$MW_DNS" 'sudo docker exec rmvm-rmapi-1 /bin/bash -lc \"rasenmaeher_api addcode\"'"
