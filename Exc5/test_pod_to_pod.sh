#!/bin/bash

# Определяем список проверок (src → dest)
TESTS=(
    "front-end-app back-end-app"
    "admin-front-end-app admin-back-end-app"
    "front-end-app admin-back-end-app" # Ожидаем блокировку
    "back-end-app admin-front-end-app" # Ожидаем блокировку
)

echo "Запуск тестов соединения между подами..."
for test in "${TESTS[@]}"; do
    set -- $test  # Разбираем строку на src и dest
    src=$1
    dest=$2
    echo "Проверка соединения: $src → $dest"

    # Проверяем, есть ли curl в контейнере
    kubectl exec $src -- sh -c "command -v curl > /dev/null" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "[ERROR]: В контейнере $src нет curl, тест невозможен"
    else
        kubectl exec $src -- curl -s --max-time 2 http://$dest && echo "[OK]: Доступен" || echo "[FAIL]: Недоступен"
    fi
    echo "-----------------------------"
done