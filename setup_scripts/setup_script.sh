#!/bin/bash
set -e  # stop on errors
trap 'echo "❌ Error occurred at line $LINENO. Exiting."' ERR

echo "🚀 Starting safe Manjaro Sway dev setup..."

# 1️⃣ Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# 2️⃣ Install essential packages
ESSENTIALS=(
  base-devel curl wget git neovim lazygit sway waybar mako grim slurp rofi \
  kitty pavucontrol brightnessctl unzip python python-pip nodejs npm flatpak jq htop
)
echo "Installing essential packages..."
sudo pacman -S --noconfirm "${ESSENTIALS[@]}"

# 3️⃣ Install yay (AUR helper) safely
echo "Installing yay (AUR helper)..."
YAY_DIR="/tmp/yay"
rm -rf "$YAY_DIR" 2>/dev/null || true
git clone https://aur.archlinux.org/yay.git "$YAY_DIR"
cd "$YAY_DIR"
makepkg -si --noconfirm
cd -

# 4️⃣ Install VSCode extensions
echo "Installing VSCode extensions..."
VSCODE_EXTS=(
  "aaron-bond.better-comments"
  "formulahendry.code-runner"
  "usernamehw.errorlens"
  "HookyQR.formatting-toggle"
  "DavidAnson.vscode-html-css"
  "xabikos.javascriptsnippets"
  "ms-vscode.vscode-typescript-next"
  "ritwickdey.LiveServer"
  "pkief.material-icon-theme"
  "christian-kohler.npm-intellisense"
  "alefragnani.order-imports"
  "naumovs.color-highlight"
  "christian-kohler.path-intellisense"
  "esbenp.prettier-vscode"
  "ms-python.python"
)