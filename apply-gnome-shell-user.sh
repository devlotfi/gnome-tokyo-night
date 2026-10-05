#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Building GNOME Shell theme..."

# Ensure the output directory exists (creates it if missing, no-op if present)
mkdir -p "$SCRIPT_DIR/gnome-shell/build"

# sassc overwrites OUT_FILE if it already exists, and creates it if not
if command -v sassc >/dev/null; then
    sassc -a "$SCRIPT_DIR/gnome-shell/theme/gnome-shell-dark.scss" "$SCRIPT_DIR/gnome-shell/build/gnome-shell.css"
fi

echo "Installing User GNOME Shell Theme..."

THEME_NAME="TokyoNight"

THEME_DIR="$SCRIPT_DIR/gnome-shell-user/build/$THEME_NAME"

# Ensure the output directory exists (creates it if missing, no-op if present)
mkdir -p "$THEME_DIR/gnome-shell"

cp "$SCRIPT_DIR/gnome-shell/build/gnome-shell.css" "$THEME_DIR/gnome-shell/gnome-shell.css"

echo "Applying GNOME Shell theme..."

mkdir -p ~/.local/share/themes

rm -rf "$HOME/.local/share/themes/$THEME_NAME"
cp -a "$THEME_DIR" ~/.local/share/themes/

echo "Enabling Shell theme..."

gsettings set org.gnome.shell.extensions.user-theme name "$THEME_NAME"

echo "Reloading GTK..."

# Reload GTK settings
gsettings reset org.gnome.desktop.interface gtk-theme >/dev/null 2>&1 || true

echo "Reloading GNOME Shell..."

EXT=user-theme@gnome-shell-extensions.gcampax.github.com

gnome-extensions disable "$EXT"
sleep 0.2
gnome-extensions enable "$EXT"

echo "Done."