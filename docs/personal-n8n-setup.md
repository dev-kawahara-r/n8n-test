# Personal n8n Workflow Setup

## 1. Preparing Required Information

### Slack Incoming Webhook
1. Go to https://api.slack.com/apps
2. "Create New App" → "From scratch"
3. App name: `n8n-dev-bot`, select workspace
4. "Incoming Webhooks" → ON
5. "Add New Webhook to Workspace" → select channel
6. Copy Webhook URL → Set `SLACK_WEBHOOK_URL` in `.env.n8n`

### OpenAI API Key
1. Visit https://platform.openai.com/api-keys
2. "Create new secret key"
3. Copy key → Set `OPENAI_API_KEY` in `.env.n8n`

### GitHub Configuration
Add to `.env.n8n`:
```bash
GITHUB_USERNAME=your-github-username
GITHUB_REPO=test-repo  # Test repository name
```

## 2. Registering Credentials in n8n

### GitHub Authentication
1. n8n → Credentials → Add Credential → GitHub
2. Name: `Personal GitHub`
3. Access Token: Use token from `.env.n8n`

### OpenAI Authentication
1. n8n → Credentials → Add Credential → OpenAI
2. Name: `Personal OpenAI`
3. API Key: Enter prepared OpenAI API key

## 3. Importing Workflows

1. Workflows → Import from File
2. Select `n8n-workflows/personal-slack-to-github-openai.json`
3. Select credentials for each node:
   - OpenAI Analysis → Personal OpenAI
   - Create GitHub Issue → Personal GitHub

## 4. Verifying Environment Variables

Restart n8n to apply environment variables:
```bash
make restart

# Or traditional command:
docker compose -f docker-compose.n8n.yml --env-file .env.n8n restart
```

## 5. Test Execution

1. Open workflow and click "Execute Workflow" button
2. In Slack Webhook node, click "Listen For Test Event"
3. In another terminal, run test:

```bash
curl -X POST http://localhost:5679/webhook-test/slack-webhook \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Add a show/hide password toggle button to the login screen"
  }'
```

## 6. Verification Points

- OpenAI analyzes message and generates JSON
- GitHub Issue created in personal repository
- Slack receives completion notification

## Troubleshooting

### OpenAI API Errors
- Check API usage limits
- Verify active credits available

### GitHub Issue Creation Errors
- Verify repository name is correct
- Check token permissions (repo permission required)

### Slack Notifications Not Received
- Verify Webhook URL is correct
- Check channel permissions