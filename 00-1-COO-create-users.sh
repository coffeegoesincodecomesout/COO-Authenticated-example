#!/bin/bash
htpasswd -c -B -b  redhatusers.htpasswd user1 RedHat!
htpasswd -B -b  redhatusers.htpasswd user2 RedHat!
htpasswd -B -b  redhatusers.htpasswd user3 RedHat!
oc create secret generic htpass-secret --from-file=htpasswd=redhatusers.htpasswd -n openshift-config 
