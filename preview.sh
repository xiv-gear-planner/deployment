#!/bin/bash

set -e


for dir in $(find . -type f -name "Chart.yaml" -exec dirname {} \;); do
  pushd "$dir"
  helm dependency update
  popd
done

cd xivgear-chart

export HELM_DIFF_USE_UPGRADE_DRY_RUN=true
helm dependency update && helm diff upgrade xivgear . -f ./values.yaml --dry-run=server --debug
