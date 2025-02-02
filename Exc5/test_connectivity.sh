#!/bin/bash

# Определяем список сервисов для проверки
SERVICES=("front-end-app" "back-end-app" "admin-front-end-app" "admin-back-end-app")

# Создаём временный тестовый под
echo "Запуск тестового пода..."
kubectl run test-client --image=alpine --restart=Never --command -- sleep 30

# Ждём, пока под запустится
echo "Ожидание готовности пода test-client..."
kubectl wait --for=condition=Ready pod/test-client --timeout=10s

# Проверяем соединения, выполняя wget из test-client
for service in "${SERVICES[@]}"; do
    echo "Проверка соединения с сервисом: $service"
    kubectl exec test-client -- wget -qO- --timeout=2 http://$service && echo "[OK]: Доступен" || echo "[FAIL]: Недоступен"
    echo "-----------------------------"
done

# Удаляем тестовый под
kubectl delete pod test-client --ignore-not-found=true
