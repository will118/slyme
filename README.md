![Img](/screenshots/ss.png "Sample screenshot")

It's a bunch of zsh, vim, and tmux config files.

Also mjolnir and nerdtool stuff.

Some basic stuff:
  - iTerm2 ("Test Release" for borderless window, I haven't noticed any bugs).
  - Homebrew.
  - `brew install tmux vim zsh` (you might have to add /usr/local/bin/zsh to /etc/shells)
  - `chsh -s $(which zsh)`

You will probably want to delete the ruby/node specific stuff from my zshrc.

You should probably clone as `.dots` in your home dir:

Too many things rely on it.

```
git clone --recursive git@github.com:will118/slyme.git ~/.dots
```

In iTerm, import the `base16-eighties.dark.itermcolors` file:

`iTerm2 > Preferences > Profiles > Color > Color Presets...`

Then select it.

Also the font I use `FiraCode` is included, I used the Retina variant but I don't even know if they're different.

Set it in iTerm profile "Text" tab etc… Mine is 13pt.

Run all these scripts (or copy and paste the commands, they're all symlinks).
```
./install_zsh_stuff.sh
./install_vim_stuff.sh
./symlink_config_files.sh
```

also

```
brew install zsh-syntax-highlighting
```


Install vim-plug "A minimalist Vim plugin manager."
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then in vim do `:PlugInstall`

The other stuff is `mjolnir` which I installed as a .app.
You need luarocks, and use it to install all the stuff in the `init.lua`.

Then nerdtool for the bar at the top (auto-hide menu bar in el capitan).

All my nerdtool exports are for 1440, so you may have to relocate them.

My nerdtool fork has some hack to make nerdtool switch (~90%) of the time, when
you plug in an external monitor.

I'm working on a basic swift app to solve all the monitor issues I've had with nerdtool.

NeekTool… Coming soon…

## Dependencies

- nerdtool (top bar)
- mjolnir
  - window snapping/management
  - nerdtool (focused window widget)
  - nerdtool (volume state widget)
- shell
  - nerdtool (date n time widget)
  - nerdtool (net speeds widget)
  - nerdtool (cpu usage widget)
  - nerdtool (battery widget)
- osx-cpu-temp
  - nerdtool (cpu temp widget)
- iterm2 beta
  - borderless window option
- zsh
- tmux
- vim/neovim
