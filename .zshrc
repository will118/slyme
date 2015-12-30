ZSH=$HOME/.oh-my-zsh
ZSH_THEME="lambda"

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export EDITOR=vim
[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="my_username"
alias reddy="redis-server /usr/local/etc/redis.conf"
alias cat="ccat --bg=dark"
alias vim="nvim"
alias mong="mongod --config /usr/local/etc/mongod.conf"
alias glog="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
plugins=(git)
source $ZSH/oh-my-zsh.sh
PS=1"$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export NODE_REPL_HISTORY_FILE="/Users/will/node_repl.log"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export NVM_DIR="/Users/will/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

mkky () {
  if [ ! -z "$1" ]
  then
      mkdir "$1" && cd "$1"
  fi
}

watchy () {
  fswatch -0 $1 | xargs -0 -n 1 -I {} $2 {}
}

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -s `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

eval $(thefuck --alias)

source /usr/local/share/chruby/chruby.sh

chruby ruby-2.3

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
