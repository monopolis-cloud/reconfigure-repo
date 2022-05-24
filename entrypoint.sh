#!/bin/ash -xe

REPO_PATH=$(jq -r '.repository.full_name' $GITHUB_EVENT_PATH)
REF_PATH=$(jq -r '.ref' $GITHUB_EVENT_PATH)
BRANCH=${REF_PATH:11}

MONOPOLIS_URL="https://github-api.monopolis.cloud/reconfigure/$REPO_PATH?branch=$BRANCH"

cat .monopolis/config.yml | \
  curl --fail-with-body -X POST --data-binary @- \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${MONOPOLIS_URL}"

