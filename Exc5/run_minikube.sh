#!/bin/bash

echo "Запускаем MiniKube с поддержкой Calico"

minikube start --network-plugin=cni --cni=calico