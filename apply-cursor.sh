#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying Cursor theme..."

THEME_NAME="Bibata-Tokyo-Night"

# The theme must live in its own directory for GTK to resolve it by name.
mkdir -p ~/.local/share/icons/"$THEME_NAME"
cp -rf "$SCRIPT_DIR"/cursor/* ~/.local/share/icons/"$THEME_NAME"/

gsettings set org.gnome.desktop.interface cursor-theme "$THEME_NAME"

echo "Done."