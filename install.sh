#!/bin/bash
# ── Dotfiles installer ──
# Run with: bash install.sh

set -uo pipefail

echo ":: Dotfiles installer"
echo ""

# ── Detect package manager ──
if command -v dnf &>/dev/null; then
  PKG="dnf"
elif command -v apt &>/dev/null; then
  PKG="apt"
elif command -v pacman &>/dev/null; then
  PKG="pacman"
else
  echo "Unsupported package manager"
  exit 1
fi

# ── Install system packages ──
echo ":: Installing system packages..."

case "$PKG" in
  dnf)
    sudo dnf install -y zsh bat eza ripgrep fd-find jq fzf zoxide
    ;;
  apt)
    sudo apt install -y zsh bat ripgrep fd-find jq fzf
    ;;
  pacman)
    sudo pacman -S --noconfirm zsh bat eza ripgrep fd jq fzf zoxide
    ;;
esac

# ── Install via scripts (not in default repos) ──
echo ":: Installing additional tools..."

install_github_release() {
  local name=$1 url=$2 archive=$3 binary=$4
  if command -v "$name" &>/dev/null; then
    echo "  ✓ $name already installed"
    return
  fi
  echo "  Installing $name..."
  local tmpd; tmpd=$(mktemp -d)
  curl -sSL "$url" -o "$tmpd/$archive"
  tar xf "$tmpd/$archive" -C "$tmpd"
  sudo cp "$tmpd"/*/"$binary" /usr/local/bin/ 2>/dev/null || sudo cp "$tmpd/$binary" /usr/local/bin/ 2>/dev/null || sudo find "$tmpd" -name "$binary" -exec cp {} /usr/local/bin/ \;
  rm -rf "$tmpd"
}

install_github_release starship \
  "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz" \
  "starship.tar.gz" "starship"

install_github_release bottom \
  "https://github.com/ClementTsang/bottom/releases/latest/download/bottom_x86_64-unknown-linux-musl.tar.gz" \
  "bottom.tar.gz" "btm"

install_github_release lazygit \
  "$(curl -sL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep browser_download_url | grep -i linux_x86_64 | cut -d'"' -f4)" \
  "lazygit.tar.gz" "lazygit"

install_github_release atuin \
  "https://github.com/atuinsh/atuin/releases/latest/download/atuin-x86_64-unknown-linux-gnu.tar.gz" \
  "atuin.tar.gz" "atuin"

# ── Change shell to zsh ──
if [ "$SHELL" != "$(which zsh)" ]; then
  echo ""
  echo ":: Changing default shell to zsh (password required)"
  chsh -s "$(which zsh)"
fi

# ── Stow dotfiles ──
echo ""
echo ":: Stowing dotfiles..."
cd "$(dirname "$0")"

stow -t ~ zsh            && echo "  ✓ zsh"
mkdir -p ~/.config
stow -t ~/.config starship && echo "  ✓ starship"
mkdir -p ~/.config/atuin
stow -t ~/.config/atuin atuin && echo "  ✓ atuin"
mkdir -p ~/.config/bottom
stow -t ~/.config/bottom bottom && echo "  ✓ bottom"
mkdir -p ~/.config/lazygit
stow -t ~/.config/lazygit lazygit && echo "  ✓ lazygit"

# Stow existing packages
for pkg in kitty nvim yazi; do
  if [ -d "$pkg" ]; then
    stow -t ~/.config "$pkg" && echo "  ✓ $pkg"
  fi
done

echo ""
echo ":: Done! Restart your terminal or run: exec zsh"
