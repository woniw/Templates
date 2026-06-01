echo "Installing FiraCode Nerd Font..."
FONTS_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONTS_DIR"
curl -L -o "$FONTS_DIR/FiraCode.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
unzip -o "$FONTS_DIR/FiraCode.zip" -d "$FONTS_DIR"
fc-cache -fv
