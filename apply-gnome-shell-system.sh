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

echo "Applying System GNOME Shell Theme..."

cp "$SCRIPT_DIR/gnome-shell/build/gnome-shell.css" "$SCRIPT_DIR/gnome-shell-system/gresource/gnome-shell-light.css"
cp "$SCRIPT_DIR/gnome-shell/build/gnome-shell.css" "$SCRIPT_DIR/gnome-shell-system/gresource/gnome-shell-dark.css"

cd "$SCRIPT_DIR/gnome-shell-system/gresource"

rm -f gnome-shell-theme.gresource
glib-compile-resources --target=gnome-shell-theme.gresource gnome-shell-theme.gresource.xml

sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource  
sudo chown root:root /usr/share/gnome-shell/gnome-shell-theme.gresource
sudo chmod 644 /usr/share/gnome-shell/gnome-shell-theme.gresource  

sudo cp "$SCRIPT_DIR/gnome-shell-system/95-gdm-settings" /etc/dconf/db/gdm.d/95-gdm-settings
sudo dconf update

echo "Done."