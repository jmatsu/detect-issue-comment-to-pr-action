#!/usr/bin/env bash

set -eu
set -o pipefail

source /toolkit.sh

if [[ -z "$(cat $GITHUB_EVENT_PATH | jq -r '.issue.pull_request // empty')" ]]; then
  github::debug "Commented to non pull request"
  github::set_output "is_pull_request" "false"
  github::success # does not use a failure status
fi

github::set_output "pull_number" "$(cat $GITHUB_EVENT_PATH | jq -r '.issue.number')"
github::set_output "is_pull_request" "true"
github::success