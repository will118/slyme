mkdir -p ~/.vim/colors
ln -sf "$HOME/.dots/base16-vim/colors/base16-ashes.vim" "$HOME/.vim/colors/base16-ashes.vim"
mv ~/.vimrc ~/.vimrc.old
ln -s "$HOME/.dots/.vimrc" "$HOME/.vimrc"
