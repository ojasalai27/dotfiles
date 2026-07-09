# Hyprland dotfiles — Fedora 44

A minimal, working Hyprland setup: waybar, wofi, kitty, dunst, hyprlock/hypridle/hyprpaper.
Catppuccin Mocha color scheme throughout.

## Contents

```
dotfiles/
├── hypr/
│   ├── hyprland.conf   # main compositor config, keybinds, rules
│   ├── hyprpaper.conf  # wallpaper
│   ├── hypridle.conf   # idle timeouts -> lock/dpms/suspend
│   └── hyprlock.conf   # lock screen look
├── waybar/
│   ├── config.jsonc
│   └── style.css
├── wofi/
│   ├── config
│   └── style.css
├── kitty/
│   └── kitty.conf
├── dunst/
│   └── dunstrc
└── install.sh
```

## Install

```bash
chmod +x install.sh
./install.sh
```

This installs Hyprland and companion packages via `dnf`, then symlinks each
config folder into `~/.config/`. Anything already there gets backed up with
a `.bak` suffix first.

After running it:
1. Drop a wallpaper at `~/Pictures/Wallpapers/wallpaper.jpg` (or edit the
   path in `hypr/hyprpaper.conf` and `hypr/hyprlock.conf`).
2. Log out, pick "Hyprland" at your display manager (GDM/SDDM), or launch it
   directly from a TTY with `Hyprland`.

## Key bindings (default $mainMod = SUPER)

| Bind                  | Action                          |
|-----------------------|----------------------------------|
| `SUPER + Return`      | Open terminal (kitty)           |
| `SUPER + D`           | App launcher (wofi)              |
| `SUPER + Q`           | Close focused window             |
| `SUPER + E`           | File manager (nautilus)          |
| `SUPER + V`           | Toggle floating                  |
| `SUPER + F`           | Fullscreen                       |
| `SUPER + L`           | Lock screen                      |
| `SUPER + C`           | Clipboard history (cliphist)     |
| `SUPER + 1..0`        | Switch workspace                 |
| `SUPER + SHIFT + 1..0`| Move window to workspace         |
| `SUPER + arrows`      | Move focus                       |
| `SUPER + SHIFT + arrows` | Move window                   |
| `SUPER + SHIFT + S`   | Screenshot region -> clipboard + file |
| `SUPER + SHIFT + Q`   | Exit Hyprland                    |

Edit `hypr/hyprland.conf` to change `$terminal`, `$fileManager`, `$browser`,
or any bind.

## Notes on Fedora 44 specifically

- Hyprland and its ecosystem (waybar, hyprpaper, hypridle, hyprlock, wofi,
  dunst) are packaged in Fedora's official repos as of recent releases —
  `install.sh` uses plain `dnf install`, no COPR needed. If a package name
  has shifted by the time you run this, `dnf search <name>` will find the
  current one.
- `xdg-desktop-portal-hyprland` is required for screen sharing and file
  pickers to work correctly in Wayland apps (e.g. browsers).
- If `jetbrains-mono-nerd-fonts` isn't available in your repos, grab it
  manually from nerdfonts.com and drop it in `~/.local/share/fonts/`, then
  run `fc-cache -fv`.
- Multi-monitor: run `hyprctl monitors` after first login and replace the
  `monitor=,preferred,auto,1` line in `hyprland.conf` with explicit lines
  per output.

## Customizing

- Colors follow Catppuccin Mocha — swap hex values in `waybar/style.css`,
  `wofi/style.css`, and `kitty/kitty.conf` for a different palette.
- Add autostart programs at the top of `hyprland.conf` under `exec-once`.
- Waybar modules are documented at the Waybar wiki if you want to add
  things like `mpd`, `bluetooth`, or custom scripts.
