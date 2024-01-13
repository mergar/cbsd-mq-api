#!/bin/sh
HOST="http://127.0.0.1:65531"

curl -s -4 -X POST -H "Accept: multipart/form-data" --form file='@iac.yaml' ${HOST}/api/v1/iac/vm1

