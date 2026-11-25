[[ -n $ZPROF ]] && zmodload zsh/zprof

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(gcloud)
# skip compaudit security check (speeds up compinit)
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# fzf-tab (must load after oh-my-zsh's compinit)
source "$HOMEBREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

# neovim
export EDITOR='nvim'

# kubectl
alias k=kubectl

# mise
eval "$(mise activate zsh)"

# opentofu (installed via mise)
alias tf=tofu
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C tofu tofu

# terragrunt: drive opentofu instead of terraform
export TG_TF_PATH=tofu

# gcloud
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# starship
eval "$(starship init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -n $ZPROF ]] && zprof
