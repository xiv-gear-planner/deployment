{{/*
Return pod anti-affinity rules that prefer to schedule pods on different nodes,
based on a combined chart name and release revision label.
Accepts an optional parameter "extra" to append to the label value.
This template returns only the podAntiAffinity section for merging with other affinity settings.
*/}}
{{- define "xivgear-commonlib.affinity" -}}
  {{- $label := include "xivgear-commonlib.deploymentAffinityLabel" . | fromYaml }}
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      podAffinityTerm:
        labelSelector:
          matchExpressions:
            - key: {{ $label.key | quote }}
              operator: In
              values:
                - {{ $label.value | quote }}
        topologyKey: "kubernetes.io/hostname"
{{- end }}

{{/*
Generate the value for the deploymentAffinityKey label. Accepts optional suffix.
*/}}
{{- define "xivgear-commonlib.deploymentAffinityLabelValue" -}}
{{- $context := index . 0 -}}
{{- $extra := index . 1 | default "" -}}
{{- printf "%s-%s%s" $context.Chart.Name (toString $context.Release.Revision) (ternary (printf "-%s" $extra) "" (eq $extra "")) -}}
{{- end }}

{{/*
Generate the full label key and value as a dictionary. Accepts optional suffix.
*/}}
{{- define "xivgear-commonlib.deploymentAffinityLabel" -}}
{{- $context := index . 0 -}}
{{- $extra := index . 1 | default "" -}}
{{- $key := "deploymentAffinityKey" -}}
{{- $value := include "xivgear-commonlib.deploymentAffinityLabelValue" (list $context $extra) -}}
{{- printf "key: %s\nvalue: %s" $key $value -}}
{{- end }}

{{/*
Generate a single line of label key-value for use in metadata.labels. Accepts optional suffix.
*/}}
{{- define "xivgear-commonlib.deploymentAffinityLabelLine" -}}
{{- $context := index . 0 -}}
{{- $extra := index . 1 | default "" -}}
{{- $label := (include "xivgear-commonlib.deploymentAffinityLabel" (list $context $extra)) | fromYaml -}}
{{ printf "%s: \"%s\"" $label.key $label.value }}
{{- end }}

{{/*
Generate the full label key and value as a dictionary. Accepts optional suffix.
*/}}
{{- define "xivgear-commonlib.podSpreadLabel" -}}
{{- $context := index . 0 -}}
{{- $extra := index . 1 | default "" -}}
{{- $key := "podSpreadKey" -}}
{{- $value := include "xivgear-commonlib.podSpreadLabelValue" (list $context $extra) -}}
{{- printf "key: %s\nvalue: %s" $key $value -}}
{{- end }}

{{/*
Generate the value for the podSpread label. Accepts optional suffix.
*/}}
{{- define "xivgear-commonlib.podSpreadLabelValue" -}}
{{- $context := index . 0 -}}
{{- $extra := index . 1 | default "" -}}
{{- printf "%s%s" $context.Chart.Name (ternary "" (printf "-%s" $extra) (eq $extra "")) -}}
{{/*{{- printf "%s-%s" $context.Chart.Name (ternary $extra "" false) -}}*/}}
{{- end }}

{{/*
Generate a single line of label key-value for use in metadata.labels. Accepts optional suffix.
*/}}
{{- define "xivgear-commonlib.podSpreadLabelLine" -}}
{{- $context := index . 0 -}}
{{- $extra := index . 1 | default "" -}}
{{- $label := (include "xivgear-commonlib.podSpreadLabel" (list $context $extra)) | fromYaml -}}
{{ printf "%s: \"%s\"" $label.key $label.value }}
{{- end }}

{{- define "xivgear-commonlib.podSpread" -}}
topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: "kubernetes.io/hostname"
    whenUnsatisfiable: ScheduleAnyway
    labelSelector: {}
    matchLabelKeys:
    - pod-template-hash
{{- end }}
{{- define "xivgear-commonlib.podSpread2" -}}
topologySpreadConstraints:
  - maxSkew: 1
{{/*    labelSelector:*/}}
{{/*      matchLabels:*/}}
{{/*        {{- include "xivgear-commonlib.podSpreadLabelLine" }}*/}}
{{- end }}
