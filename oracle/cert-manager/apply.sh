#!/bin/bash

helm upgrade -n cert-manager cert-manager jetstack/cert-manager -f values.yaml