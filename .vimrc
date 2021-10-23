" vim:fdm=marker

" Plugins {{{
call plug#begin()
Plug 'w0rp/ale'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mileszs/ack.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
call plug#end()
" }}}
" Keybinds {{{
let mapleader = ','
:map <C-f> :FZF<CR>
:map <C-g> :Goyo<CR>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
:map <C-s> :Ack!<Space>
:map <C-y> r<C-v>u2713
:map <C-n> r<C-v>u2717

:nnoremap <silent> <leader>f :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

let NERDTreeMapHelp='<f1>' " cus reverse search
" }}}
" Theme {{{
" set Vim-specific sequences for RGB colors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors
" fixes glitch? in colors when using vim with tmux
set background=dark
colorscheme dracula
" }}}
" General {{{
filetype off
filetype plugin indent on
syntax on
set noshowmode
set timeoutlen=420
set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set hlsearch
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamedplus
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 4 spaces
set tabstop=4                                                " actual tabs occupy 4 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set mouse=a
set textwidth=79
set formatoptions-=t                                         " please no wrap!
set colorcolumn=+1
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000                                         " maximum number lines to save for undo on a
set completeopt-=preview
" }}}
" Hacks {{{
" Don't copy the contents of an overwritten selection.
vnoremap p "_dP
" }}}
" Tmux {{{
if exists('$TMUX')  " cursors
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" Plugin settings {{{

" NERDTree
let g:NERDSpaceDelims=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=20
nnoremap <leader>d :NERDTreeToggle<CR>

" lightline
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night_Eighties',
      \ 'inactive': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'helloworld' ] ]
      \ },
      \ }

" goyo
let g:goyo_width = 100
