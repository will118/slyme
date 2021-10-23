# goes-to a temp directory
got() {
  cd $(mktemp -d)
}

# my bins
PATH="$HOME/.bin:$PATH"
