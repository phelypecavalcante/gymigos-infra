# gymigos-infra

Local development infrastructure for Gymigos. Contains Docker Compose setup, Makefiles, and environment configuration to run the entire Gymigos stack locally.

## Prerequisites

Clone all repos as siblings before running:

```
gymigos/
  gymigos-api/
  gymigos-web/
  gymigos-mobile/
  gymigos-contracts/
  gymigos-infra/       ← you are here
```

## Getting Started

```bash
cp .env.example .env  # configure your local environment
make up               # start all services
```

## Commands

```bash
make up               # build and start all services
make down             # stop all services
make logs             # follow logs for all services
make api-logs         # follow API logs only
make db-logs          # follow DB logs only
make ps               # show running services
make restart          # restart all services
```

## Services

| Service | Port |
|---|---|
| PostgreSQL | 5432 |
| gymigos-api | 8080 |
| gymigos-web | 5173 (coming soon) |

## Environment Variables

See `.env.example` for all available variables.
