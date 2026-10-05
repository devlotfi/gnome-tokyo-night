#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying GTK 3 theme..."

mkdir -p ~/.config/gtk-3.0

if command -v sassc >/dev/null; then
    sassc -a "$SCRIPT_DIR/gtk-3/theme/gtk.scss" "$SCRIPT_DIR/gtk-3/build/gtk.css"
fi

cp -a "$SCRIPT_DIR/gtk-3/build/." ~/.config/gtk-3.0/

echo "Done."