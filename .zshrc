# ZSH SETUP
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=( git zsh-syntax-highlighting zsh-autosuggestions fzf wd zsh-nvm )
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

set -o vi

# ALIASES
alias vim=nvim
if [ -x "$(command -v eza)" ]; then
    alias ls="eza"
    alias la="eza --long --all --group"
fi
alias rebuild="darwin-rebuild switch --flake ~/dotfiles/.config/nix-darwin#pro"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias tmx="tmux-sessionizer"

# OTHER SETUPS
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
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# add personal scripts directory to path
export PATH="$HOME/scripts:$PATH"
