# my werid aliases
alias ag="ag --color-path \"1;34\" --color-line-number \"3;34\""
alias s="ssh"

# makes a folder called $1 and cds to it
mkky () {
  if [ ! -z "$1" ]
  then
      mkdir "$1" && cd "$1"
  fi
}

# goes-to a temp directory
got() {
  cd $(mktemp -d)
}

# fzf settings
export FZF_DEFAULT_COMMAND='ag -g ""'
