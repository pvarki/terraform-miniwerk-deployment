#!/bin/sh

MW_DNS=`jq .dns_name.value $(jsonOutputVariablesPath)`
watch -g curl -s https://"$MW_DNS"/api/v1/healthcheck/services | jq ."
echo "$(sshkeypriv)" > ~/.ssh/sshkey
chmod 400 ~/.ssh/sshkey
ssh -i ~/.ssh/sshkey azureuser@"$MW_DNS" 'sudo docker exec rmvm-rmapi-1 /bin/bash -lc \"rasenmaeher_api addcode\"'"
