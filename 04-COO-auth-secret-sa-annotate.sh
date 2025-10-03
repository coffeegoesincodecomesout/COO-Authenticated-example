#!/bin/bash
oc -n project-c create secret generic thanos-proxy --from-literal=session_secret=$(head -c 32 /dev/urandom | base64)
oc -n project-a create serviceaccount thanos-querier
oc -n project-a annotate serviceaccount thanos-querier serviceaccounts.openshift.io/oauth-redirectreference.thanos-querier='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"thanos-querier-authenticated"}}'
oc -n project-a annotate service thanos-querier-example-coo-thanos service.alpha.openshift.io/serving-cert-secret-name="thanos-tls"
