## df-app-frontend

Frontend container used by example webapp.

It serves the static `index.html` via `nginx` and reverse-proxies API calls to the backend:
- `GET /` serves the landing page
- `GET /api/*` is proxied to the backend container on `http://backend:8000/*`

### Folder structure
- `Dockerfile` - builds a production Nginx image
- `configs/nginx.conf` - Nginx configuration (static + `/api` proxy)
- `src/index.html` - the landing page UI

### Local run (Compose)
Bring up everything from the repo root:

```bash
docker compose up --build
```

Then open:
- `http://localhost:8080`

If you click “Check backend health”, the frontend calls `GET /api/health`.
