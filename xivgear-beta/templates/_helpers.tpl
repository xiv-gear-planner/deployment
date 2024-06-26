{{/*
Expand the name of the chart.
*/}}
{{- define "xivgear-beta.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "xivgear-beta.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}
{{- define "xivgear-beta.preview-fullname" -}}
{{- printf "%s-preview" (include "xivgear-beta.fullname" .)}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "xivgear-beta.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "xivgear-beta.labels" -}}
helm.sh/chart: {{ include "xivgear-beta.chart" . }}
{{ include "xivgear-beta.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- define "xivgear-beta.previewLabels" -}}
helm.sh/chart: {{ include "xivgear-beta.chart" . }}
{{ include "xivgear-beta.previewSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "xivgear-beta.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xivgear-beta.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "xivgear-beta.previewSelectorLabels" -}}
app.kubernetes.io/name: {{ include "xivgear-beta.name" . }}-preview
app.kubernetes.io/instance: {{ .Release.Name }}-preview
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "xivgear-beta.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "xivgear-beta.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
