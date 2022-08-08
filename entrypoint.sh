#!/bin/ash -e

REPO_PATH=$(jq -r '.repository.full_name' $GITHUB_EVENT_PATH)
REF_PATH=$(jq -r '.ref' $GITHUB_EVENT_PATH)
BRANCH=${REF_PATH:11}

MONOPOLIS_URL="https://github-api.monopolis.cloud/reconfigure/$REPO_PATH?branch=$BRANCH"

echo "Validating configuration..."

STATUSCODE=$(cat monopolis.yml | curl --silent --output /dev/stderr --write-out "%{http_code}" -X POST --data-binary @- -H "Authorization: Bearer ${GITHUB_TOKEN}" "${MONOPOLIS_URL}")

if test $STATUSCODE -ne 200; then
	echo "Validation failure so exiting"
	exit 1
fi

