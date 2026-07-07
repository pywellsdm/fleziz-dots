#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "==> Installing official repo packages..."
sudo pacman -S --needed - < "$DOTFILES_DIR/install/pkglist.txt"

echo "==> Checking for yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    echo "yay not found, installing it first..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
fi

echo "==> Installing AUR packages..."
yay -S --needed - < "$DOTFILES_DIR/install/aur-pkglist.txt"

echo "==> Backing up existing configs..."
timestamp=$(date +%Y%m%d-%H%M%S)
for dir in hypr hyprlock waybar rofi mako kitty waypaper wal matugen fastfetch xsettingsd gtk-3.0 gtk-4.0; do
    if [ -d "$CONFIG_DIR/$dir" ]; then
        mv "$CONFIG_DIR/$dir" "$CONFIG_DIR/${dir}.bak-${timestamp}"
        echo "  backed up existing $dir -> ${dir}.bak-${timestamp}"
    fi
done

echo "==> Symlinking dotfiles..."
for dir in "$DOTFILES_DIR"/.config/*/; do
    name=$(basename "$dir")
    ln -sfn "$dir" "$CONFIG_DIR/$name"
    echo "  linked $name"
done

for file in "$DOTFILES_DIR"/.config/gtkrc "$DOTFILES_DIR"/.config/gtkrc-2.0; do
    [ -f "$file" ] && ln -sfn "$file" "$CONFIG_DIR/$(basename "$file")"
done

echo "==> Installing helper scripts to ~/.local/bin..."
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES_DIR"/bin/*; do
    name=$(basename "$script")
    chmod +x "$script"
    ln -sfn "$script" "$HOME/.local/bin/$name"
    echo "  linked $name -> ~/.local/bin/$name"
done

echo "==> Checking ~/.local/bin is in PATH..."
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "  WARNING: ~/.local/bin is not in your PATH."
    echo "  Add this to your shell rc file: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo "==> Done! Restart Hyprland or log back in to apply everything."
