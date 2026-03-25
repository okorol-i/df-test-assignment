## df-app-backend

Minimal backend service for example webapp.

It is an `Express` + `pg` API that exposes:
- `GET /health` (also verifies PostgreSQL connectivity)

### Folder structure
- `Dockerfile` - multi-stage build for a small production image
- `src/server.js` - Express server + `/health` endpoint
- `package.json` - runtime dependencies (`express`, `pg`)

### Run locally (Compose)
The repo’s top-level `docker-compose.yml` wires the backend to `postgres` using env vars from `.env`.

Environment variables expected:
- `PORT` (default `8000`)
- `DB_HOST` (default `postgres`)
- `DB_PORT` (default `5432`)
- `DB_USER`
- `DB_PASSWORD`
- `DB_NAME`

### Endpoints
- `GET /health`
  - responds with `{ status: "ok", dbTime: ... }` when PostgreSQL is reachable
