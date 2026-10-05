#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

EXT="user-theme@gnome-shell-extensions.gcampax.github.com"

has_ext() { gnome-extensions list 2>/dev/null | grep -qx "$EXT"; }

# Only the GNOME Shell theme needs anything installed. The GTK themes ship
# prebuilt, so sassc is a contributor tool, not a user prerequisite.
install_ext() {
    local cmd reply
    if   command -v dnf    >/dev/null; then cmd="sudo dnf install -y gnome-shell-extension-user-theme"
    elif command -v apt    >/dev/null; then cmd="sudo apt install -y gnome-shell-extensions"
    elif command -v pacman >/dev/null; then cmd="sudo pacman -S --noconfirm gnome-shell-extensions"
    elif command -v zypper >/dev/null; then cmd="sudo zypper install -y gnome-shell-extension-user-theme"
    else
        echo "Install the User Themes extension for your distro, then re-run this script." >&2
        return 1
    fi

    echo "The GNOME Shell theme needs the User Themes extension. Installing it with:"
    echo "    $cmd"
    read -r -p "Continue? [Y/n] " reply || return 1   # no tty: treat as declined
    [[ -z "$reply" || "$reply" == [yY] ]] || return 1
    $cmd
}

./apply-gtk-3.sh
./apply-gtk-4.sh
./apply-cursor.sh
./apply-wallpaper.sh

if ! has_ext; then
    install_ext || true
fi

if has_ext; then
    gnome-extensions enable "$EXT" 2>/dev/null || true
    ./apply-gnome-shell-user.sh
else
    echo
    echo "Skipped the GNOME Shell theme. If you just installed the extension, GNOME"
    echo "has to restart before it appears: log out and back in, then re-run this script."
fi

echo
echo "Optional: ./apply-ghostty.sh  ./apply-starship.sh  ./apply-fastfetch.sh  ./apply-grub.sh"
