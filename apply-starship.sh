#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying Starship theme..."

if [ -f ~/.config/starship.toml ] && [ ! -f ~/.config/starship.toml.bak ]; then
    cp -a ~/.config/starship.toml ~/.config/starship.toml.bak
fi
cp -rf "$SCRIPT_DIR/starship/starship.toml"  ~/.config/starship.toml

echo "Done."