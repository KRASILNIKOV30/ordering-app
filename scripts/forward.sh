#!/bin/bash

PIDS=()
cleanup() {
    echo "🛑 Остановка..."
    for pid in "${PIDS[@]}"; do kill $pid 2>/dev/null; done
    exit
}
trap cleanup SIGINT

# Функция проброса
pf() {
    echo "🔄 Подключаю $1 ($2/$3)..."
    kubectl port-forward -n $2 svc/$3 $4:$5 > /dev/null 2>&1 &
    PIDS+=($!)
}

echo "🚀 Запуск проброса портов..."

# --- INFRASTRUCTURE ---
pf "🐰 RabbitMQ"   "infrastructure" "rabbitmq"    15672 15672
pf "⏳ Temporal UI" "infrastructure" "temporal-ui" 8080  8080
pf "🗄️  MySQL"      "infrastructure" "mysql"       3307  3306

# --- APPS (Default Namespace) ---
# Локальный порт -> Порт в k8s (8081)
pf "👤 User API"         "application" "user-api"         8081 8081
pf "📦 Product API"      "application" "product-api"      8083 8081
pf "💳 Payment API"      "application" "payment-api"      8085 8081
pf "🛒 Order API"        "application" "order-api"        8087 8081
pf "🔔 Notification API" "application" "notification-api" 8089 8081

sleep 2
echo "------------------------------------------------"
echo "✅ Готово! Ссылки:"
echo "   🐰 RabbitMQ:    http://localhost:15672"
echo "   ⏳ Temporal:    http://localhost:8080"
echo "   🗄️  MySQL:       localhost:3307"
echo ""
echo "✅ API (gRPC):"
echo "   👤 User:         localhost:8081"
echo "   📦 Product:      localhost:8083"
echo "   💳 Payment:      localhost:8085"
echo "   🛒 Order:        localhost:8087"
echo "   🔔 Notification: localhost:8089"
echo "------------------------------------------------"
echo "⚡ Ctrl+C для выхода"
wait