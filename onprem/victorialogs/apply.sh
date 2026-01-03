#!/bin/bash

# Requires secrets to already be present

helm upgrade vls vm/victoria-logs-single -f values.yaml --namespace xivgear-victoria

kubectl apply -f cftunnel.yaml -n xivgear-victoria