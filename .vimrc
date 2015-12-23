let mapleader = ','
nnoremap <leader>a :Ag<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>

set background=dark
colorscheme PaperColor

filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

set noshowmode
set timeoutlen=420
set nocompatible
set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
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
set colorcolumn=+1

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if exists('$TMUX')  " Support resizing in tmux
  if !has('nvim')
    set ttymouse=xterm2
  end
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

let g:NERDSpaceDelims=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=25
let NERDTreeIgnore = ['\.pyc$']

let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']
let g:pymode_lint_unmodified = 0
let g:pymode = 1
let g:pymode_folding = 0
let g:pymode_rope=0

autocmd FileType javascript set tabstop=8|set shiftwidth=2|set expandtab
hi SpellCap ctermfg=027 ctermbg=209 guifg=#dfff00 guibg=#ffaf00
