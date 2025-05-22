#!/bin/bash

set -e


for dir in $(find . -type f -name "Chart.yaml" -exec dirname {} \;); do
  pushd "$dir"
  helm dependency update
  popd
done

cd xivgear-chart

helm dependency update && helm upgrade xivgear . -f ./values.yaml