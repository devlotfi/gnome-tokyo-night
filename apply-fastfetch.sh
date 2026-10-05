#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying Fastfetch theme..."

mkdir -p ~/.config/fastfetch
cp -rf "$SCRIPT_DIR"/fastfetch/*  ~/.config/fastfetch/

echo "Done."