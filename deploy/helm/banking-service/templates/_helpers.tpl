{{- define "banking-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "banking-service.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" .Values.app.serviceName | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "banking-service.labels" -}}
app.kubernetes.io/name: {{ include "banking-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: internet-banking
app.kubernetes.io/component: {{ .Values.app.serviceName }}
version: {{ .Values.app.version | quote }}
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "banking-service.selectorLabels" -}}
app: {{ .Values.app.serviceName }}
{{- end -}}

{{- define "banking-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "banking-service.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
