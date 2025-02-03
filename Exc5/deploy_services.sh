#!/bin/bash

echo "Развёртывание сервисов в Kubernetes..."

kubectl run front-end-app --image=nginx --labels role=front-end --expose --port=80
kubectl run back-end-app --image=nginx --labels role=back-end-api --expose --port=80
kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port=80
kubectl run admin-back-end-app --image=nginx --labels role=admin-back-end-api --expose --port=80

echo "Все сервисы развернуты!"
kubectl get pods -o wide