" vim:fdm=marker

" Plugins {{{
call plug#begin()
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
"Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'shaunsingh/nord.nvim'
Plug 'Shatur/neovim-ayu' " or other package manager
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jremmen/vim-ripgrep'
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
:map <C-s> :Rg<Space>
:map <C-y> r<C-v>u2713
:map <C-n> r<C-v>u2717

let NERDTreeMapHelp='<f1>' " cus reverse search
" }}}
" Theme {{{
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme ayu-mirage

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
" set spell
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
" set completeopt-=preview
set completeopt=menu,menuone,preview,noselect,noinsert
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


nnoremap <leader>t :ALEHover<CR>
nnoremap <leader>gd :ALEGoToDefinition<CR>

set omnifunc=ale#completion#OmniFunc
let g:ale_floating_preview = 1
let g:ale_completion_enabled = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_linters = {'rust': ['analyzer', 'rustfmt', 'cargo']}
let g:ale_fixers = {'rust': ['rustfmt']}
