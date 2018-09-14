filetype plugin indent on
syntax on
set nocompatible
set encoding=utf-8
set history=56
set hidden
set scrolloff=3

" plugins
call plug#begin('~/.vim/plugged')

Plug 'ap/vim-buftabline'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

call plug#end()

" indent
set autoindent

" line break
set wrap
set linebreak
set breakindent
let &showbreak = '+++ '

" backspace
set backspace=indent,eol,start

" tabs
set expandtab
set softtabstop=0
set shiftwidth=2
set tabstop=2
set shiftround

" search
set incsearch

" ui
set noruler
set number
set shortmess=atI
set showcmd
set lazyredraw

" theme
if &term =~ '256color'
  set t_Co=256
  set t_ut=
endif
set laststatus=2
colorscheme nord
let g:lightline = {
	\ 'colorscheme': 'nord'
	\ }

" bindings
nnoremap j gj
nnoremap k gk
nnoremap <C-N> :bnext<CR>
nnoremap <C-B> :bprev<CR>
nnoremap <C-D> :bdelete<CR>

autocmd FileType c map ;m :w<Enter>:! sudo make clean install<Enter><Enter>
autocmd FileType markdown map ;p :w<Enter>:!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>

" autocmds
augroup autos
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd BufWritePost $MYVIMRC :so $MYVIMRC
augroup END
