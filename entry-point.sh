#!/usr/bin/env bash

set -eu
set -o pipefail

source /toolkit.sh

cat $GITHUB_EVENT_PATH | github::debug

readonly issue_number="$(cat $GITHUB_EVENT_PATH | jq -r '.issue_comment.html_url' | sed 's/^.*\/issues\/\([0-9]*\)#.*$/\1/')"

if [[ -z $(curl -X GET \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$issue_number" | \
  jq -r '.pull_request // empty') ]]; then
  github::debug "Commented to non pull request"
  github::set_output "is_pull_request" "false"
  github::success # does not use a failure status
fi

github::set_output "pull_number" "$issue_number"
github::set_output "is_pull_request" "true"
github::success