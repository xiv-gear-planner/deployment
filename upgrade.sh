#!/bin/bash

set -e

cd xivgear-chart

helm dependency update && helm upgrade xivgear . -f ./values.yaml