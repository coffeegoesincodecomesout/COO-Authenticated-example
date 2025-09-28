#!/bin/bash
oc -n project-c create secret generic thanos-proxy --from-literal=session_secret=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c43)
oc -n project-c create serviceaccount thanos-querier
oc -n project-c annotate serviceaccount thanos-querier serviceaccounts.openshift.io/oauth-redirectreference.thanos-querier='{"kind":"OAuthRedirectReference","apiVersion":"v1","reference":{"kind":"Route","name":"thanos-querier-authenticated"}}'
oc -n project-c annotate service thanos-querier-example-coo-thanos service.alpha.openshift.io/serving-cert-secret-name="thanos-tls"
oc -n project-c create route reencrypt thanos-querier-authenticated --service=thanos-querier-example-coo-thanos --port=proxy --insecure-policy=Redirect
oc -n project-c adm policy add-role-to-user view user2
