#!/usr/bin/env bash


# Show environment info at startup
echo "=== Docker Environment Info ==="

# Docker server (engine) version
docker_server_version=$(docker version --format '{{.Server.Version}}' 2>/dev/null || echo "unknown")
echo "Docker engine version: ${docker_server_version}"

# docker buildx version
buildx_version=$(docker buildx version 2>/dev/null || echo "unknown")
echo "Docker buildx: ${buildx_version}"

# Docker provider detection - check context name/host, then docker info
docker_context=$(docker context inspect --format '{{.Name}} {{.Endpoints.docker.Host}}' 2>/dev/null | head -1 || echo "")

if echo "${docker_context}" | grep -qi "colima"; then
  provider="colima"
elif echo "${docker_context}" | grep -qi "lima"; then
  provider="lima"
elif echo "${docker_context}" | grep -qi "desktop"; then
  provider="docker-desktop"
elif docker info 2>/dev/null | grep -qi "docker desktop"; then
  provider="docker-desktop"
elif docker info 2>/dev/null | grep -qi "colima"; then
  provider="colima"
else
  provider="unknown (context: ${docker_context})"
fi
echo "Docker provider: ${provider}"

echo "==============================="

set -eu -o pipefail
set -x

(for i in $(seq 1 1000); do docker-compose build --no-cache; done)

