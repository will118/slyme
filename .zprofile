# my werid aliases
alias toil="toilet --metal --font mono12 -w 250"
alias s="ssh"

# node stuff
export NODE_REPL_HISTORY_FILE="/Users/will/node_repl.log"
export NVM_DIR="/Users/will/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# goes-to a temp directory
got() {
  cd $(mktemp -d)
}

# fzf settings
export FZF_DEFAULT_COMMAND='ag -g ""'

# my bins
PATH="$HOME/.bin:$PATH"
