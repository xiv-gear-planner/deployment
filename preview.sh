#!/bin/bash

set -e


for dir in $(find . -maxdepth 1 -type d -name "xivgear-*" -exec test -f "{}/Chart.yaml" \; -print); do
  pushd "$dir"
  helm dependency update --skip-refresh
  popd
done

cd xivgear-chart

export HELM_DIFF_USE_UPGRADE_DRY_RUN=true
helm dependency update && helm diff upgrade xivgear . -f ./values.yaml --dry-run=server --debug
