# dotfiles

Personal macOS config:

- [Homebrew](https://brew.sh) bundle
- [iTerm2](https://iterm2.com) profile
- [zsh](https://www.zsh.org) ([Oh My Zsh](https://ohmyz.sh) + [starship](https://starship.rs))
- [fzf](https://github.com/junegunn/fzf)
- [Neovim](https://neovim.io) ([LazyVim](https://www.lazyvim.org))
- [k9s](https://k9scli.io) theme

## Layout

```
home/
  .zshrc  .bashrc  .fzf.zsh  .fzf.bash
  .config/starship.toml
  .config/nvim/
  Library/Application Support/k9s/skins/
  Library/Application Support/iTerm2/DynamicProfiles/dotfiles.json
iterm2/
Brewfile
install.sh
```

## Benchmark

Total startup time:

```sh
for i in {1..5}; do /usr/bin/time zsh -i -c exit; done
```

Per-function breakdown with [zprof](https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzprof-Module):

```sh
ZPROF=1 zsh -i -c exit
```
