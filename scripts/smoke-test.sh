#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

for env in qs production; do
  fqdn=$(
    terraform -chdir=terraform-local output -json container_app_fqdns |
      python3 -c 'import json,sys; print(json.load(sys.stdin)[sys.argv[1]])' "$env"
  )

  echo "Testing $env ($fqdn)..."

  response=$(curl -fsS \
    --retry 5 \
    -H "Host: $fqdn" \
    http://localhost:4577/)

  if [[ "$response" == *"Environment: <strong>${env}</strong>"* ]]; then
    echo "PASS: $env"
  else
    echo "FAIL: $env"
    exit 1
  fi
done

echo "All smoke tests passed."