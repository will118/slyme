# my werid aliases
#alias cat="ccat --bg=dark"
alias reddy="redis-server /usr/local/etc/redis.conf"
alias vi="vim"
alias vim="nvim"
alias watchtest="clear && fswatch -o test build | xargs -n1 -I{} npm test"
alias mong="mongod --config /usr/local/etc/mongod.conf"
alias rimraf="rm -rf"
alias ag="ag --color-path \"1;34\" --color-line-number \"3;34\""
alias pizza="~/pizza/pizza.sh"
alias jj="pbpaste | jq ."
alias maan="man"
alias maaan="man"
alias maaaan="man"
alias maaaaan="man"
alias maaaaaan="man"

# 3rd party functions
eval $(thefuck --alias)
[[ -s `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# node stuff
export NODE_REPL_HISTORY_FILE="/Users/will/node_repl.log"
export NVM_DIR="/Users/will/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# ruby
source /usr/local/share/chruby/chruby.sh
chruby ruby-2.2.2

# my functions
mkky () {
  if [ ! -z "$1" ]
  then
      mkdir "$1" && cd "$1"
  fi
}

proxy() {
  sudo networksetup -setsocksfirewallproxystate wi-fi on && ssh -N -D 8080 $1
  sudo networksetup -setsocksfirewallproxystate wi-fi off
}

watchy () {
  fswatch -0 $1 | xargs -0 -n 1 -I {} $2 {}
}

# fzf settings
export FZF_DEFAULT_COMMAND='ag -g ""'
