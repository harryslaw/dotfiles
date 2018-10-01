filetype plugin indent on
syntax on
set nocompatible
set encoding=utf-8
set history=128
set hidden

" plugins
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'w0rp/ale'
Plug 'rainglow/vim'
call plug#end()

" colour
if &term =~ '256color'
    set t_Co=256
    set t_ut=
endif
colorscheme heroku

" indent
set autoindent
set smartindent

" line break
set nowrap

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

" folding
set foldenable
set foldmethod=marker
set foldlevel=10

" buftabline
let g:buftabline_numbers = 1
let g:buftabline_indicators = 'on'
let g:buftabline_seperators = 'on'

" lightline
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'active': {
            \   'left': [
            \            [ 'mode', 'paste' ],
            \            [ 'readonly', 'filename', 'filetype', 'modified']
            \           ],
            \   'right': [
            \             [ 'percent' ],
            \             [ 'lineinfo' ],
            \             [ 'char' ]
            \            ],
            \ },
            \ 'component': {
            \   'readonly': '%r',
            \   'modified': '%m',
            \   'filetype': '%y',
            \   'filename': '%t',
            \   'char': "0x%B"
            \ },
            \ 'inactive': {
            \   'left': [
            \            [ 'readonly', 'filename', 'filetype', 'modified']
            \           ],
            \ },
            \ }

" bindings
map         <F1>    <nop>
nnoremap    j       gj
nnoremap    k       gk
"" highlight everything
noremap     gV      `[v`]
"" format everything
noremap     gG      :call <SID>formatScreen()<CR>
"" clear hightlights
nnoremap    kj      :let @/=""<CR>
nnoremap    <C-N>   :bnext<CR>
nnoremap    <C-P>   :bprev<CR>
nnoremap    <C-D>   :bdelete<CR>
"" syntax checker
nnoremap    <C-F>   :ALEFix clang-format<CR>
"" maintain highlight when shifting
vnoremap    >       >`[v`]
vnoremap    <       <`[v`]
"" quick escape in instert
inoremap    jk      <ESC>

" functions
function! <SID>formatScreen()
    let cur_pos = getpos('.')
    normal gg=G
    call setpos('.', cur_pos)
endfunction

" autocmds
augroup autos
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter * match ErrorMsg '\%>80v.\+'
    autocmd BufEnter * :ALEEnable
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePost $MYVIMRC :source %
augroup END
