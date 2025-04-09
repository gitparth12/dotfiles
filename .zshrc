# ZSH SETUP
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export ZSH="$HOME/.oh-my-zsh"
# export ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# plugins=( git zsh-syntax-highlighting zsh-autosuggestions fzf wd zsh-nvm )
# source $ZSH/oh-my-zsh.sh
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load zinit
# source "${HOME}/.zinit/bin/zinit.zsh"
source "$(brew --prefix zinit)/zinit.zsh"

# Plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light junegunn/fzf
zinit light rupa/z
zinit light lukechilds/zsh-nvm
zinit light atuinsh/atuin

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

set -o vi
bindkey -v '^?' backward-delete-char

# ALIASES
alias vim=nvim
if [ -x "$(command -v eza)" ]; then
    alias ls="eza"
    alias la="eza --long --all --group"
fi
alias rebuild="darwin-rebuild switch --flake ~/dotfiles/.config/nix-darwin#pro"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias tmx="tmux-sessionizer"
alias gcam="git add . && git commit -m "
alias wattage="system_profiler SPPowerDataType | grep Wattage"

# OTHER SETUPS
# bitwarden cli
export BWS_ACCESS_TOKEN="0.7818611c-65cd-4903-b802-b2ba002cc6df.a1UYOkHEtCHcTvpN8rUzXbQqFYtYLh:EYRStaJcU47LAD1rSEJvkw=="
# homebrew ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# make compilers discover ruby
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# sdkman homebrew setup
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# add ruby gems to path
PATH=$PATH:$(ruby -e 'puts Gem.bindir')

# add personal scripts directory to path
export PATH="$HOME/scripts:$PATH"

# atuin
eval "$(atuin init zsh)"

# add Go bin directory to path
export PATH=$PATH:$HOME/go/bin

# starship
# eval "$(starship init zsh)"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

