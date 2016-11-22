##Install Homebrew
```
http://brew.sh/
```
##Install Neovim
```
brew tap neovim/neovim
brew install neovim
brew install --HEAD neovim # or this
```
##Install other stuff
```
brew install tmux zsh zsh-syntax-highlighting git coreutils
```
##dotfiles
```
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/.vimrc" "$HOME/.vimrc"
ln -s "$PWD/.zshrc" "$HOME/.zshrc"
ln -s "$PWD/.zprofile" "$HOME/.zprofile"
https://github.com/zsh-users/zsh-history-substring-search

ln -s "$PWD/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
ln -s "$PWD/async.zsh" "$HOME/.zfunctions/async"
```
##chsh
```
add the homebrew zsh to /etc/shells
chsh
```
##Font
```
https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-Retina.ttf
```
##Terminal.app
```
Aardvark.terminal
```
##mjolnir
```
https://github.com/sdegutis/mjolnir
sudo chown -R $USER /usr/local
luarocks install mjolnir.application
luarocks install mjolnir.hotkey
luarocks install mjolnir._asm.sys.audiodevice
luarocks install mjolnir._asm.ipc
luarocks install luautf8
luarocks install mjolnir.fnutils
luarocks install mjolnir.geometry
luarocks install mjolnir.screen
luarocks install mjolnir.keycodes
luarocks install lua-filesize
# mjolnir module for netspeeds, make install
https://github.com/will118/netspeed
```
##SIMBL stuff
```
https://github.com/w0lfschild/mySIMBL

```
