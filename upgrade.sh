#!/bin/bash

set -e


for dir in $(find . -maxdepth 1 -type d -name "xivgear-*" -exec test -f "{}/Chart.yaml" \; -print); do
  pushd "$dir"
  helm dependency update --skip-refresh
  popd
done

cd xivgear-chart

helm dependency update && helm upgrade xivgear . -f ./values.yaml