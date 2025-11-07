# Traefik Configuration

- Dynamic routes live under `traefik/dynamic/`. Update `services.yml` whenever you add a new hostname so Traefik knows where to forward requests.
- TLS certificates are referenced via `tls.certificates` (dev self-signed by default). In production, point to your real cert/key or configure `certResolver` to use LetsEncrypt; `docker/compose.gateway.yml` already mounts `traefik/certs` and `traefik/acme` for this purpose.
- Salt state `traefik.gateway` ensures `/etc/traefik/dynamic` exists; mount this repo path into the Traefik container using the compose file in `docker/compose.gateway.yml`.
- Keep secrets (API tokens, ACME account keys) in Pillar (`services:traefik:tls`) or environment variables injected by `saltdocker deploy --pillar` rather than committing them.
