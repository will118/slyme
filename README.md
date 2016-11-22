##Install Homebrew
```
http://brew.sh/
```
##neovim
```
brew tap neovim/neovim
brew install --HEAD neovim
```
##other stuff
```
brew install zsh zsh-syntax-highlighting git coreutils reattach-to-user-namespace
```
##tmux
```
brew install tmux --HEAD
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"
```
##zsh
```
ln -s "$PWD/.zshrc" "$HOME/.zshrc"
ln -s "$PWD/.zprofile" "$HOME/.zprofile"
https://github.com/zsh-users/zsh-history-substring-search
mkdir "$HOME/.zfunctions"
ln -s "$PWD/pure/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
ln -s "$PWD/pure/async.zsh" "$HOME/.zfunctions/async"
```
##vim stuffk
```
ln -s "$PWD/.vimrc" "$HOME/.vimrc"
mkdir -p ~/.vim/colors
mkdir ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
https://github.com/chriskempson/base16-vim
https://github.com/junegunn/vim-plug
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
# basically https://github.com/vbwx/base16-terminal-app/blob/master/profiles/Harmonic16%20Dark.terminal
# a few things changed
Aardvark.terminal
```
##mjolnir
```
mkdir ~/.mjolnir
ln -s "$PWD/init.lua" "$HOME/.mjolnir/init.lua"
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
