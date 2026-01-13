# Qwen Code - Инструкция по проекту Ordering App

## Обзор проекта

Ordering App - это микросервисное приложение, написанное на языке Go. Проект состоит из нескольких сервисов: `userservice`, `productservice`, `paymentservice`, `orderservice` и `notificationservice`. Каждый сервис отвечает за свою область ответственности и взаимодействует с другими сервисами через gRPC и сообщения в RabbitMQ. Для мониторинга используется Prometheus и Grafana.

## Архитектура

Проект использует микросервисную архитектуру, где каждый сервис реализует определенную бизнес-логику. Сервисы взаимодействуют друг с другом через gRPC и асинхронные сообщения, передаваемые через RabbitMQ. Для хранения данных используется MySQL. Для мониторинга производительности и ошибок применяются Prometheus и Grafana.

## Сборка и запуск

Для сборки проекта используется команда `brewkit build`. Для запуска проекта используется `docker compose up --build -d`. Также можно использовать `docker compose up --build` для запуска без отсоединения от терминала.

## Технологии

- Go (версия 1.25.3)
- gRPC
- RabbitMQ
- MySQL
- Prometheus
- Grafana
- Docker
- Temporal (для управления workflow)

## Структура проекта

- `rp-userservice-main` - сервис для управления пользователями
- `rp-productservice` - сервис для управления продуктами
- `rp-paymentservice` - сервис для обработки платежей
- `rp-orderservice` - сервис для управления заказами
- `rp-notificationservice` - сервис для отправки уведомлений
- `config` - конфигурационные файлы
- `readme` - документация
- `scripts` - скрипты для автоматизации задач
- `docker-compose.yml` - конфигурация для запуска проекта в Docker
- `prometheus.yml` - конфигурация Prometheus
- `kind-config.yaml` - конфигурация Kind (Kubernetes in Docker)