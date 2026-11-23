#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

case "${1:-}" in
  "") ;;
  --links-only) LINKS_ONLY=1 ;;
  *) echo "usage: $0 [--links-only]"; exit 1 ;;
esac

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok      $dst"
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP/$(dirname "${dst#$HOME/}")"
    mv "$dst" "$BACKUP/${dst#$HOME/}"
    echo "backup  $dst -> $BACKUP"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link    $dst"
}

for src in "$DOTFILES"/home/.[!.]*; do
  [ "$(basename "$src")" = ".config" ] && continue
  link "$src" "$HOME/$(basename "$src")"
done

for src in "$DOTFILES"/home/.config/*; do
  link "$src" "$HOME/.config/$(basename "$src")"
done

K9S="Library/Application Support/k9s"
for src in "$DOTFILES/home/$K9S"/*; do
  link "$src" "$HOME/$K9S/$(basename "$src")"
done

if [ -z "${LINKS_ONLY:-}" ]; then
  command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle --file="$DOTFILES/Brewfile" || echo "warn: some Brewfile entries failed, rerun brew bundle"
  if command -v mise >/dev/null; then
    mise install
  else
    echo "note: mise not installed, rerun ./install.sh after fixing brew bundle"
  fi
fi

K9S_CONFIG="$HOME/$K9S/config.yaml"
if command -v yq >/dev/null; then
  [ -f "$K9S_CONFIG" ] || echo "k9s: {}" >"$K9S_CONFIG"
  yq -i '.k9s.ui.skin = "terminal"' "$K9S_CONFIG"
  echo "set     k9s skin"
else
  echo "note: yq not found, set k9s.ui.skin: terminal in $K9S_CONFIG"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "note: Oh My Zsh not found, install with:"
  echo '  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc'
fi
