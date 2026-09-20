#!/bin/bash

# Requires secrets to already be present

helm upgrade vls vm/victoria-metrics-single -f values.yaml --namespace xivgear-victoria-metrics

kubectl apply -f cftunnel.yaml -n xivgear-victoria-metrics
