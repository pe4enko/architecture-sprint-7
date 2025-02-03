#!/bin/bash

echo "Удаление сервисов и подов..."

kubectl delete pod front-end-app --ignore-not-found=true
kubectl delete pod back-end-app --ignore-not-found=true
kubectl delete pod admin-front-end-app --ignore-not-found=true
kubectl delete pod admin-back-end--app --ignore-not-found=true

kubectl delete svc front-end-app --ignore-not-found=true
kubectl delete svc back-end-app --ignore-not-found=true
kubectl delete svc admin-front-end-app --ignore-not-found=true
kubectl delete svc admin-back-end-app --ignore-not-found=true

echo "Очистка завершена!"
kubectl get pods
