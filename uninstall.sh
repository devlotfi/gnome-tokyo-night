#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

# Keep these in step with apply-cursor.sh and apply-gnome-shell-user.sh.
CURSOR_THEME="Bibata-Tokyo-Night"
SHELL_THEME="TokyoNight"

# Removes only the files this theme installed, working from the repo contents
# rather than a manifest, then returns the settings it changed to their GNOME
# defaults. Anything the theme did not put there is left alone.

remove_installed() { # $1 = source dir in repo, $2 = installed location
    [ -d "$1" ] || return 0
    (cd "$1" && find . -type f -print0) | while IFS= read -r -d '' f; do
        rm -f "$2/${f#./}"
    done
    # Clean up directories the theme created, but only if now empty.
    (cd "$1" && find . -mindepth 1 -depth -type d -print0) | while IFS= read -r -d '' d; do
        rmdir "$2/${d#./}" 2>/dev/null || true
    done
}

echo "Removing theme files..."

remove_installed gtk-3/build   ~/.config/gtk-3.0
remove_installed gtk-4         ~/.config/gtk-4.0
remove_installed ghostty       ~/.config/ghostty
remove_installed fastfetch     ~/.config/fastfetch

rm -rf ~/.local/share/icons/"$CURSOR_THEME"
rm -rf ~/.local/share/themes/"$SHELL_THEME"

if [ -f ~/.config/starship.toml.bak ]; then
    mv ~/.config/starship.toml.bak ~/.config/starship.toml
    echo "Restored your previous starship.toml."
fi

echo "Restoring settings..."

gsettings reset org.gnome.desktop.interface cursor-theme
gsettings reset org.gnome.desktop.background picture-uri
gsettings reset org.gnome.desktop.background picture-uri-dark
gsettings reset org.gnome.shell.extensions.user-theme name 2>/dev/null || true

echo
echo "Done. Settings are back to the GNOME defaults, not to any custom values"
echo "you had set before installing."
echo
echo "Not touched: the GRUB theme (/etc/default/grub) and the system GNOME Shell"
echo "theme, if you applied those. Both need root and are reverted by hand."
