{{- define "cron-e2e-chart.imagePullSecret" }}
{{- $res := "{ \"auths\": {" -}}
{{- $authDict := dict -}}
{{- range $i, $secret := .Values.pullSecrets -}}
    {{- $_ := set $authDict $secret.host (printf "\"%s\": {\"auth\": \"%s\"}" $secret.host (printf "%s:%s" $secret.authentication.username $secret.authentication.password | b64enc)) -}}
{{- end -}}
{{- if .Values.pullSecrets -}}
    {{- range $i, $secret := .Values.pullSecrets -}}
        {{- $_ := set $authDict $secret.host (printf "\"%s\": {\"auth\": \"%s\"}" $secret.host (printf "%s:%s" $secret.authentication.username $secret.authentication.password | b64enc)) -}}
    {{- end -}}
{{- end -}}
{{- cat $res (join "," (values $authDict)) "}}" | b64enc -}}
{{- end }}
