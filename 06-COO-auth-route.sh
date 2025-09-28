oc -n project-a create route reencrypt thanos-querier-authenticated --service=thanos-querier-example-coo-thanos --port=proxy --insecure-policy=Redirect
