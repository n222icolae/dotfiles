#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

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

ITERM="Library/Application Support/iTerm2/DynamicProfiles"
for src in "$DOTFILES/home/$ITERM"/*; do
  link "$src" "$HOME/$ITERM/$(basename "$src")"
done

if [ "${1:-}" = "--brew" ]; then
  command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle --file="$DOTFILES/Brewfile"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "note: Oh My Zsh not found — install with:"
  echo '  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc'
fi
