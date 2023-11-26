#!/bin/bash
echo -n "Send terraform output to callback url"
# Callback url tulee TF_VARreissa enviin, voi lukea sieltä skriptiin
terraform output -json | jq -rc | sed 's/"/\\"/g' \
| xargs -i bash -c "curl -X POST $TF_VAR_CALLBACK_URL -H 'Content-Type: application/json' -d '{}'"
