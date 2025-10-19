# COO-Authenticated-example

Openshift container platform: cluster observability operator
This repo aims to provide an example COO multi tenant deployment with authenticated access to metrics.

https://access.redhat.com/articles/7130526 

#Create test users
```
./00-1-COO-create-users.sh
```
#Set cluster identity provider
```
oc apply -f 00-2-COO-create-identityProvider.yaml
```
#Deploy example COO stack
```
oc apply -f 01-COO-example-stack.yaml
```
#Deploy test app
```
oc apply -f 02-COO-example-app-project-a.yaml  
```
#Create cluster role binding for bearer token tokenreview
```
oc apply -f 03-COO-tokenreview.yaml 
```
#Create secret to encrypt login cookie, create service account(SA), annonote SA for subject access review 
#annotate thanos service for serving certificate creation, create and grant access to SA for bearer token auth test
```
./04-COO-auth-secret-sa-annotate.sh
```

#Update operator managed COO objects - add oauth proxy and edit service to point at the proxy
```
oc apply -f 05-COO-oauth-thanos-deployment.yaml --server-side
```

#Create authenticated route
```
./06-COO-auth-route.sh
```

#Grant test user access to the authenticated route
```
./07-COO-grant-user-access.sh
```

#Repeat for project-b and project-c
```
oc apply -f 08-project-b.yaml
./09-project-b.sh
oc apply -f 10-project-b-oauth-deploy.yaml --server-side
oc apply -f 11-project-c.yaml
./12-project-c.sh
oc apply -f 13-project-c-oauth-deploy.yaml --server-side
```
#test bearer token auth access to project-a
```
14-test-bearer-auth.sh
```
