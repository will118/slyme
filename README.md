![Img](/screenshots/ss.png "Sample screenshot")

Some basic stuff:
  - Homebrew
  - `brew install tmux vim zsh`
  - `chsh -s $(which zsh)`

You should probably clone as `.dots` in your home dir:

Too many things rely on it.

```
git clone git@github.com:will118/slyme.git ~/.dots
cd ~/.dots && git submodule init
```

In iTerm, import the `base16-eighties.dark.itermcolors` file:
`iTerm2 > Preferences > Profiles > Color > Color Presets...`
Then select it.

Run all these scripts (or copy and paste the commands, they're all symlinks).
```
./install_zsh_stuff.sh
./install_vim.sh
./symlink_config_files.sh
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
- neovim
