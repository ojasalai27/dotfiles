#!/usr/bin/env bash
# install.sh — set up Hyprland + dotfiles on Fedora 44
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "==> Updating system"
sudo dnf upgrade --refresh -y

echo "==> Installing Hyprland and core Wayland session pieces"
sudo dnf install -y \
    hyprland \
    xdg-desktop-portal-hyprland \
    hyprpaper \
    hypridle \
    hyprlock \
    hyprpicker \
    waybar \
    wofi \
    kitty \
    dunst \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    polkit-gnome \
    qt6ct \
    nwg-look \
    brightnessctl \
    playerctl \
    pipewire \
    pipewire-pulseaudio \
    wireplumber \
    pavucontrol \
    network-manager-applet \
    blueman \
    nautilus \
    jetbrains-mono-fonts-all

# Nerd Fonts: Fedora repos ship many under this pattern; adjust as needed.
echo "==> Installing a Nerd Font (JetBrainsMono)"
sudo dnf install -y jetbrains-mono-nerd-fonts 2>/dev/null || \
    echo "    jetbrains-mono-nerd-fonts not found in repos — install manually from https://www.nerdfonts.com/"

echo "==> Linking dotfiles into $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"
for dir in hypr waybar wofi kitty dunst; do
    target="$CONFIG_DIR/$dir"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "    Backing up existing $target -> $target.bak"
        mv "$target" "$target.bak"
    fi
    ln -sfn "$DOTFILES_DIR/$dir" "$target"
    echo "    Linked $target -> $DOTFILES_DIR/$dir"
done

mkdir -p "$HOME/Pictures/Wallpapers" "$HOME/Pictures/Screenshots"
echo "==> NOTE: put a wallpaper at ~/Pictures/Wallpapers/wallpaper.jpg"
echo "    (referenced by hypr/hyprpaper.conf and hypr/hyprlock.conf)"

echo "==> Done. Log out and select Hyprland from your display manager (or run 'Hyprland' from a TTY)."
