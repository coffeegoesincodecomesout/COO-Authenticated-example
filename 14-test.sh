#!/bin/bash
TOKEN=$(oc -n project-a create token robot-user)
curl -s -k -H "Authorization: Bearer ${TOKEN}" https://$(oc -n project-a get route thanos-querier-authenticated -o jsonpath='{.status.ingress[*].host}'/api/v1/query) --data-urlencode 'query=up' | jq
