<img src="https://raw.githubusercontent.com/devlotfi/gnome-tokyo-night/main/github-assets/github-banner.png">

# 📜 gnome-tokyo-night

A Tokyo Night Theme for Gnome

# 📌 Contents

- [Theme setup](#-theme-setup)
- [Install](#install)
- [Uninstall](#uninstall)
- [Preview](#-preview)

# 📂 Theme Setup

This themes GTK 3 and GTK 4 applications, the GNOME Shell, the cursor and the
wallpaper. Icons, terminals and browsers have their own theming systems and are
listed separately below.

## Gnome Extensions

- [User Themes](https://extensions.gnome.org/extension/19/user-themes/) — **required** for the shell theme. `install.sh` offers to install it.
- [Blur My Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) — optional, matches the screenshots
- [Dash To Dock](https://extensions.gnome.org/extension/307/dash-to-dock/) — optional

## Other

- [MacOS Tahoe Icons](https://github.com/vinceliuice/MacTahoe-icon-theme) — icons are not part of this theme, install separately
- [VSCode Tokyo night theme](https://marketplace.visualstudio.com/items?itemName=enkia.tokyo-night)

## Install

```bash
$ ./install.sh
```

This applies the GTK 3, GTK 4, GNOME Shell, cursor and wallpaper themes.

Nothing has to be installed first. The GTK and shell themes ship prebuilt, so
a SCSS compiler is only needed if you edit the sources.

The GNOME Shell theme is the one exception: it needs the **User Themes**
extension. `install.sh` detects your package manager (dnf, apt, pacman or
zypper), shows you the exact command, and asks before running it. Decline and
everything else is still applied. A freshly installed extension only becomes
visible after GNOME restarts, so on Wayland log out and back in, then re-run.

### Optional

Run these individually if you use the tool:

```bash
$ ./apply-ghostty.sh
$ ./apply-starship.sh
$ ./apply-fastfetch.sh
```

### Uninstall

```bash
$ ./uninstall.sh
```

Removes only the files the theme installed and returns the settings it changed
to the GNOME defaults. The GRUB theme and the system-wide shell theme are not
covered, since both need root.

### Not applied by install.sh

Two scripts stay opt-in because they need root and `uninstall.sh` cannot revert them:

```bash
$ ./apply-gnome-shell-system.sh
```

Themes the GDM login screen by replacing the system `gnome-shell-theme.gresource`.
This is an alternative to the User Themes route, not an addition. A `gnome-shell`
package update restores the stock file, so it has to be re-run.

```bash
$ ./apply-grub.sh
```

> **Warning:** this replaces `/etc/default/grub` in full, including your kernel
> command line. See issue #3 before running it.

### Other applications

- **Ptyxis** (the default terminal on Fedora 41+): Preferences > Appearance > Palette > **Tokyo Night Storm**, which ships with Ptyxis and uses the same `#24283b` background as this theme
- **GNOME Terminal**: theme selection > **More Themes** > **Tokyo night**
- **Chromium/Brave**: extensions > enable dev mode > load unpacked > select the `brave` folder
- **JetBrains IDEs**: import the theme from the `jetbrains` folder
- **DuckDuckGo**: paste the string in `duckduckgo/duckduckgo.txt` into Settings > Appearance > Theme > Custom

Firefox is not covered. Its UI does not follow the GTK theme, so it needs a
Firefox theme or [Firefox Color](https://color.firefox.com).

### Troubleshooting

**The top panel looks like a flat dark bar instead of blurred.** Blur My Shell
dims the blur to 60% by default, and the wallpapers here are plain sky across
the top of the screen, so there is very little detail for the blur to show.
The result is a flat, dark strip even though the blur is working correctly.

Raise the blur brightness in Blur My Shell's preferences, under the panel
section, or pick a wallpaper with more detail near the top.

### Contributing

Editing the SCSS sources needs `sassc`. When it is installed the apply scripts
rebuild the CSS; otherwise they use the committed build output.

# 📷 Preview

<img src="https://raw.githubusercontent.com/devlotfi/gnome-tokyo-night/main/github-assets/preview-1.png">
<img src="https://raw.githubusercontent.com/devlotfi/gnome-tokyo-night/main/github-assets/preview-2.png">
<img src="https://raw.githubusercontent.com/devlotfi/gnome-tokyo-night/main/github-assets/preview-3.png">
