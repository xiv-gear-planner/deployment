#!/bin/bash

set -e

cd xivgear-chart

helm dependency update && helm diff upgrade xivgear . -f ./values.yaml --dry-run=server --debug
