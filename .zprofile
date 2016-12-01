# my werid aliases
alias reddy="redis-server /usr/local/etc/redis.conf"
alias watchtest="clear && fswatch -o test build | xargs -n1 -I{} npm test"
alias mong="mongod --config /usr/local/etc/mongod.conf"
alias rimraf="rm -rf"
alias ag="ag --color-path \"1;34\" --color-line-number \"3;34\""
alias pizza="~/pizza/pizza.sh"
alias jj="pbpaste | jq ."
alias s="ssh"

# 3rd party functions
[[ -s `brew --prefix`/etc/profile.d/z.sh ]] && . `brew --prefix`/etc/profile.d/z.sh

# node stuff
export NODE_REPL_HISTORY_FILE="/Users/will/node_repl.log"
export NVM_DIR="/Users/will/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# makes a folder called $1 and cds to it
mkky () {
  if [ ! -z "$1" ]
  then
      mkdir "$1" && cd "$1"
  fi
}

# mutates the clipboard
px () {
  pbpaste | $@ | pbcopy
}

# goes-to a temp directory
got() {
  cd $(mktemp -d)
}

# opens the clipboard (html) in chrome
pot() {
  TEMP_FILE=$(mktemp)
  pbpaste > $TEMP_FILE
  open -a Google\ Chrome $TEMP_FILE
}

# opens a SSH socks tunnel to $1
proxy() {
  sudo networksetup -setsocksfirewallproxystate wi-fi on && ssh -N -D 8080 $1
  sudo networksetup -setsocksfirewallproxystate wi-fi off
}

# watches $1 and does $2 when something changes
watchy () {
  fswatch -0 $1 | xargs -0 -n 1 -I {} $2 {}
}

# fzf settings
export FZF_DEFAULT_COMMAND='ag -g ""'
