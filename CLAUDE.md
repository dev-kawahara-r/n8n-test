# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is an n8n workflow automation project for automating development workflows. The main purpose is to create automated workflows that:
- Convert Slack messages to GitHub Issues
- Use AI to analyze and structure requests
- Automatically implement simple tasks
- Handle PR creation and review processes

## Core Architecture

### Docker Environment
- **n8n service**: Main workflow engine on port 5679 (container: n8n-test-app)
- **PostgreSQL**: Database backend for n8n workflow data (container: n8n-test-postgres)
- **Data persistence**: `n8n-data/` directory for configuration and logs
- **Workflow storage**: `n8n-workflows/` directory for JSON workflow definitions
- **Network**: n8n-test-network for internal communication
- **Volume**: n8n-test-postgres-data for database persistence

### Key Components
- **docker-compose.n8n.yml**: Main orchestration file
- **.env.n8n**: Environment variables and credentials
- **n8n-workflows/**: Contains workflow JSON files
- **docs/**: Setup and configuration documentation

## Development Commands

### Quick Commands (Makefile)
```bash
# Show available commands
make

# Start n8n
make up

# Stop n8n
make down

# View logs
make logs

# Restart n8n
make restart

# Test webhook
make test-webhook

# Check status
make status

# Clean all data (reset)
make clean
```

### Direct Docker Commands
```bash
# Start n8n with all dependencies
docker compose -f docker-compose.n8n.yml --env-file .env.n8n up -d

# View logs
docker compose -f docker-compose.n8n.yml logs -f

# Stop the environment
docker compose -f docker-compose.n8n.yml down
```

### Workflow Management
- Access n8n UI at http://localhost:5679
- Import workflows from `n8n-workflows/` directory
- Basic auth: admin / (password from .env.n8n)

### Testing Webhooks
```bash
# Test Slack webhook
curl -X POST http://localhost:5679/webhook/slack-webhook \
  -H "Content-Type: application/json" \
  -d '{"text": "Sample request message"}'
```

## Configuration
- **Environment variables**: Stored in `.env.n8n`
- **Required integrations**: GitHub PAT, Slack webhook, AI API keys
- **Database**: PostgreSQL with automatic health checks
- **Authentication**: Basic auth for n8n UI access

## Workflow Structure
The main workflow (`slack-to-github-issue.json`) follows this pattern:
1. **Slack Webhook** - Receives messages from Slack
2. **AI Analysis** - Uses Claude to analyze and structure requests
3. **GitHub Integration** - Creates issues with appropriate labels
4. **Response** - Sends confirmation back to Slack

## Important Notes
- Use production mode for webhook functionality
- Ensure proper API key configuration in credentials
- Monitor n8n logs for debugging workflow issues
- Workflow JSON files should be imported via n8n UI