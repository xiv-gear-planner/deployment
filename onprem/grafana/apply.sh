#!/usr/bin/env bash
set -euo pipefail

# Requires a Helm repository named "grafana" to be configured.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Requires Helm read access to vm-secret in xivgear-victoria-metrics and
# vl-secret in xivgear-victoria. The Helm values copy them into this namespace.
helm upgrade --install grafana grafana/grafana \
  --namespace xivgear-grafana \
  --create-namespace \
  --values "${SCRIPT_DIR}/values.yaml"
