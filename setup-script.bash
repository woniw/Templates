#!/bin/bash
set -e
trap 'echo "❌ Error occurred at line $LINENO. Exiting."' ERR

echo "🚀 Starting Fedora Sway web dev setup..."

# 1️⃣ Update system
echo "Updating system..."
sudo dnf update -y

# 2️⃣ Install essential packages
ESSENTIALS=(
  git sway waybar mako grim slurp rofi
  kitty pavucontrol brightnessctl unzip python3 python3-pip nodejs npm flatpak jq
  tmux htop btop bat fzf ripgrep
)
echo "Installing essential packages..."
sudo dnf install -y "${ESSENTIALS[@]}"

# 3️⃣ Setup Git
echo "Configuring Git..."
read -p "Enter your Git user.name: " GIT_NAME
read -p "Enter your Git user.email: " GIT_EMAIL
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor "nvim"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global color.ui auto
git config --global credential.helper store
echo "✅ Git configured globally."

# 4️⃣ Install global Node utilities
echo "Installing global Node utilities..."
npm install -g nodemon npm-check-updates

# 5️⃣ Install TailwindCSS 3.3 + PostCSS + Autoprefixer
echo "Installing TailwindCSS 3.3 CLI and dependencies..."
npm install -g tailwindcss@3.3 postcss autoprefixer

# 6️⃣ Create helper script to initialize Tailwind projects
TAILWIND_HELPER="$HOME/bin/init-tailwind.sh"
mkdir -p "$(dirname "$TAILWIND_HELPER")"
cat >"$TAILWIND_HELPER" <<'EOF'
#!/bin/bash
# Tailwind 3.3 project initializer

if [ -z "$1" ]; then
  echo "Usage: init-tailwind.sh <project-name>"
  exit 1
fi

PROJECT="$1"
mkdir -p "$PROJECT"
cd "$PROJECT" || exit

echo "📦 Initializing npm project..."
npm init -y

echo "🎨 Installing TailwindCSS + PostCSS + Autoprefixer..."
npm install -D tailwindcss@3.3 postcss autoprefixer

echo "📝 Creating Tailwind config..."
npx tailwindcss init

echo "✅ Tailwind project '$PROJECT' created!"
EOF

chmod +x "$TAILWIND_HELPER"

# 7️⃣ Install Nerd Font for Neovim and terminal status bars
echo "Installing FiraCode Nerd Font..."
FONTS_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONTS_DIR"
curl -L -o "$FONTS_DIR/FiraCode.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
unzip -o "$FONTS_DIR/FiraCode.zip" -d "$FONTS_DIR"
fc-cache -fv

# 8️⃣ Extra tip
echo "💡 Optional: You can create a Sway workspace launcher script next to auto-open Neovim, terminals, and browser all tiled!"

echo "🎉 Fedora Sway web dev environment setup is complete!"
echo "💻 Use '$TAILWIND_HELPER <project-name>' to start new Tailwind 3.3 projects quickly."
echo "🗂 Git is ready to use globally with your configured user name and email."
