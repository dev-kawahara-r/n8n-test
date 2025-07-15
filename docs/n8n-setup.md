# n8n Development Workflow Setup Guide

## Overview
This guide covers the setup process for n8n workflow automation environment.

## Starting the Environment

### Make Commands (Recommended)
```bash
# Start n8n containers
make up

# View logs
make logs

# Stop containers
make down

# Restart containers
make restart

# Check status
make status
```

### Traditional Docker Commands
```bash
# Start n8n with all dependencies
docker compose -f docker-compose.n8n.yml --env-file .env.n8n up -d

# View logs
docker compose -f docker-compose.n8n.yml logs -f

# Stop the environment
docker compose -f docker-compose.n8n.yml down
```

## Access Information

- **URL**: http://localhost:5679
- **Username**: admin
- **Password**: Set in .env.n8n file

## Initial Setup

1. Access http://localhost:5679
2. Login with basic authentication
3. Complete the initial account creation (first time only)

## Planned Workflows

### 1. Slack → GitHub Issue Automation
- Receive requests via Slack
- Analyze content with AI
- Automatically create GitHub Issues
- Assess implementation difficulty

### 2. AI Implementation Flow
- Simple fixes implemented automatically by AI
- Branch creation → Implementation → PR creation
- Automated test execution

### 3. Review Request Flow
- Request human engineer review after PR creation
- Automatic deployment to dev environment
- Completion notification to Slack

## Required Credentials (add to .env.n8n)

```bash
# GitHub Integration
GITHUB_PERSONAL_ACCESS_TOKEN=your_github_pat

# Slack Integration
SLACK_WEBHOOK_URL=your_slack_webhook_url

# AI Integration (choose one)
OPENAI_API_KEY=your_openai_key
ANTHROPIC_API_KEY=your_anthropic_key

# AWS (for deployment)
AWS_ACCESS_KEY_ID=your_aws_key_id
AWS_SECRET_ACCESS_KEY=your_aws_secret
AWS_REGION=ap-northeast-1
```

## Next Steps

1. Configure credentials in .env.n8n
2. Login to n8n and create basic workflows
3. Configure Slack Webhook
4. Setup GitHub integration
5. Choose and configure AI provider

## Troubleshooting

### Forgot Password
```bash
# Reset data (Make command)
make clean
make up

# Or traditional commands
docker compose -f docker-compose.n8n.yml down
rm -rf n8n-data/.n8n
docker compose -f docker-compose.n8n.yml up -d
```

### Port 5679 Already in Use
Modify the port configuration in docker-compose.n8n.yml.