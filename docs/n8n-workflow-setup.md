# n8n Workflow Configuration Guide

## 1. Setting Up Credentials

### GitHub Authentication
1. n8n Dashboard → Credentials → Add credential
2. Select "GitHub"
3. Enter Personal Access Token (requires repo, workflow permissions)

### Slack Webhook
1. Create app at https://api.slack.com/apps
2. Enable Incoming Webhooks
3. Copy Webhook URL
4. Set `SLACK_WEBHOOK_URL` in .env.n8n

### Anthropic API
1. n8n Dashboard → Credentials → Add credential
2. Select "Anthropic"
3. Enter API Key

## 2. Importing Workflows

1. n8n Dashboard → Workflows → Import from File
2. Select `n8n-workflows/slack-to-github-issue.json`
3. Configure credentials for each node after import

## 3. Webhook URL Configuration

1. Open "Slack Webhook" node
2. Copy Production URL (e.g., http://localhost:5679/webhook/xxx)
3. Configure this URL in Slack app's Event Subscriptions

## 4. Testing

```bash
# Webhook test
curl -X POST http://localhost:5679/webhook/slack-webhook \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Please increase the header logo size for better mobile visibility."
  }'
```

## 5. Production Preparation

1. **Slack App Configuration**
   - Subscribe to message events in Event Subscriptions
   - Restrict to specific channels only

2. **GitHub Configuration**
   - Recommend using Fine-grained PAT
   - Grant only necessary permissions

3. **Error Handling**
   - Add Error Trigger node
   - Configure Slack notifications for failures

## Troubleshooting

### Webhook Not Working
- Verify n8n is running in Production mode
- Check firewall/proxy settings

### AI Analysis Failing
- Verify Anthropic API Key is correctly configured
- Check API usage limits

### GitHub Issue Creation Failing
- Verify PAT permissions (repo permission required)
- Confirm repository name is correct