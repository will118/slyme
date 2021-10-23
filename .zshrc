# load pure stuff
fpath+=$HOME/.zsh/pure
autoload -U promptinit && promptinit
prompt pure

# better completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select matcher-list 'm:{a-zA-Z}={A-Za-z}'

# shared history between all zsh instances
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt HIST_IGNORE_SPACE

# general
export EDITOR=vim
export KEYTIMEOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
stty -ixon # disable XON/XOFF flow control

# styling
export LS_COLORS='fi=00:di=00;34:ln=00;36:ex=00;91:';
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh history (load after highlighting)
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


# aliases
alias ls='ls -F --color=auto'

# tmux
PS=1"$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

source ~/.zprofile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
