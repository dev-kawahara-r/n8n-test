.PHONY: up down logs restart clean test-webhook status

# デフォルトターゲット
help:
	@echo "n8n-test プロジェクトコマンド:"
	@echo "  make up          - n8nコンテナを起動"
	@echo "  make down        - n8nコンテナを停止"
	@echo "  make logs        - ログをリアルタイム表示"
	@echo "  make restart     - n8nコンテナを再起動"
	@echo "  make clean       - データを削除して初期化"
	@echo "  make test-webhook - Webhookテストを実行"
	@echo "  make status      - コンテナの状態を確認"

# n8nコンテナを起動
up:
	docker compose -f docker-compose.n8n.yml --env-file .env.n8n up -d

# n8nコンテナを停止
down:
	docker compose -f docker-compose.n8n.yml down

# ログをリアルタイム表示
logs:
	docker compose -f docker-compose.n8n.yml logs -f

# n8nコンテナを再起動
restart: down up

# データを削除して初期化
clean:
	docker compose -f docker-compose.n8n.yml down -v
	rm -rf n8n-data/.n8n
	@echo "データを削除しました。"

# Webhookテストを実行
test-webhook:
	@echo "Slack webhook テストを送信..."
	@curl -X POST http://localhost:5679/webhook/slack-webhook \
		-H "Content-Type: application/json" \
		-d '{"text": "テストメッセージ: ヘッダーのロゴサイズを大きくしてほしい。"}' \
		|| echo "エラー: n8nが起動していることを確認してください"

# コンテナの状態を確認
status:
	docker compose -f docker-compose.n8n.yml ps