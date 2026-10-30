#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Select environment to test
case "${1:-all}" in
  qs)
    environments=("qs")
    ;;
  production)
    environments=("production")
    ;;
  all)
    environments=("qs" "production")
    ;;
  *)
    echo "Usage: $0 [qs|production|all]"
    exit 1
    ;;
esac

# Read Container App FQDNs from Terraform
fqdns=$(terraform -chdir=terraform-local output -json container_app_fqdns)

for env in "${environments[@]}"; do
  fqdn=$(
    echo "$fqdns" |
      python3 -c 'import json,sys; print(json.load(sys.stdin)[sys.argv[1]])' "$env"
  )

  echo "Testing $env ($fqdn)..."

  response=$(curl -fsS \
    --retry 5 \
    --retry-delay 2 \
    -H "Host: $fqdn" \
    http://localhost:4577/)

  if [[ "$response" == *"Environment: <strong>${env}</strong>"* ]]; then
    echo "PASS: $env"
  else
    echo "FAIL: $env"
    exit 1
  fi
done

echo "All requested smoke tests passed."