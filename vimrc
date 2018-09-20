filetype plugin indent on
syntax on
set nocompatible
set nobackup
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
Plug 'itchyny/lightline.vim'

call plug#end()

" indent
set autoindent
set smartindent

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
set shiftwidth=4
set tabstop=4
set shiftround

" search
set hlsearch
set incsearch

" ui
set title
set noruler
set number
set shortmess=atI
set showcmd
set wildmenu
set lazyredraw

" folding
set foldenable
set foldmethod=marker
set foldlevel=10

" theme
if &term =~ '256color'
    set t_Co=256
    set t_ut=
endif
set statusline=[\ %w%r%{getcwd()}/%t%m%y%=[line=%l/%L][col=%c][%p%%]\ ]
set laststatus=2

" bindings
nnoremap j gj
nnoremap k gk
noremap gV `[kv`]
noremap gG :normal gg=G<CR>
nnoremap jk <ESC>
nnoremap kj    :let @/=""<CR>
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap <C-D> :bdelete<CR>
vnoremap >     >`[v`]
vnoremap <     <`[v`]

autocmd FileType c map ;m :w<Enter>:! sudo make install clean<Enter><Enter>
autocmd FileType markdown map ;p :w<Enter>:!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>

" autocmds
augroup autos
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter * match ErrorMsg '\%>80v.\+'
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePost $MYVIMRC :so $MYVIMRC
augroup END
