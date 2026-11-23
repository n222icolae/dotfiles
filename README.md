# dotfiles

Personal macOS config.

## Tools

In install order. Paths are relative to `home/`.

### Base

- [Homebrew](https://brew.sh): `Brewfile`

### Terminal

- [Ghostty](https://ghostty.org): `.config/ghostty/`

### Shell

- [zsh](https://www.zsh.org) with [Oh My Zsh](https://ohmyz.sh): `.zshrc`
- [starship](https://starship.rs): `.config/starship.toml`
- [fzf](https://github.com/junegunn/fzf) with [fzf-tab](https://github.com/Aloxaf/fzf-tab): `.fzf.zsh`, `.fzf.bash`, `.bashrc`

### Runtimes

- [mise](https://mise.jdx.dev): `.config/mise/`

### Editor

- [Neovim](https://neovim.io) with [LazyVim](https://www.lazyvim.org): `.config/nvim/`

### Kubernetes

- [k9s](https://k9scli.io) skin: `Library/Application Support/k9s/skins/`

## Install

```sh
./install.sh
```

Links `home/` into `~` (existing files are backed up to `~/.dotfiles_backup/`), installs Homebrew, the Brewfile and mise tools, and sets the k9s skin. Oh My Zsh is installed separately, the script prints the command. Safe to rerun; use `./install.sh --links-only` to only refresh the links.

## Update

- Homebrew: `brew update && brew upgrade`
- Ghostty: Ghostty → Check for Updates
- Oh My Zsh: `omz update`
- mise: `mise upgrade`
- LazyVim and plugins: `:Lazy update`, then commit `lazy-lock.json`
- Neovim tools: `:Mason`, then `U`

After adding or removing a package, update `Brewfile` and run `brew bundle check`.

## Benchmark

Total startup time:

```sh
for i in {1..5}; do /usr/bin/time zsh -i -c exit; done
```

Per-function breakdown with [zprof](https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzprof-Module):

```sh
ZPROF=1 zsh -i -c exit
```
