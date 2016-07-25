# load pure stuff
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit && promptinit
prompt pure

# better completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# shared history between all zsh instances
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt HIST_IGNORE_SPACE

# general
export EDITOR=nvim
export KEYTIMEOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# zsh history (load before highlighting)
source "$HOME/.dots/zsh-history-substring-search/zsh-history-substring-search.zsh"
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# styling
export LS_COLORS='fi=00:di=00;34:ln=00;36:ex=00;91:';
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias ls='ls -F --color=auto'
alias glog="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# tmux
PS=1"$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
