#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying GTK 4 theme..."

mkdir -p ~/.config/gtk-4.0

cp -a "$SCRIPT_DIR/gtk-4/." ~/.config/gtk-4.0/

echo "Done."