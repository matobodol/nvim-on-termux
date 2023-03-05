#!/bin/bash

# Update dan upgrade paket
pkg update -y && pkg upgrade -y

# Install paket yang dibutuhkan
pkg install clang ctags curl git neovim -y

# Buat folder .config/nvim
mkdir -p ~/.config/nvim

# Install Plug-vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Buat file .config/nvim/init.vim
touch ~/.config/nvim/init.vim

# Buat file .bashrc
touch ~/.bashrc
cat > ~/.bashrc <<EOF
export PATH="/usr/bin/ctags:$PATH"

alias nv="nvim ~/.config/nvim/init.vim"
alias cpp="cd ~/storage/shared/Project/"
EOF

# Tambahkan konfigurasi ke init.vim
cat > ~/.config/nvim/init.vim <<EOF
call plug#begin('~/.local/share/nvim/plugged')

Plug 'luochen1990/rainbow'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'tomasr/molokai'

call plug#end()

" tabline barbar.vim                                                                                                                 let bufferline = {
   \ 'auto_hide': v:true,                                                                                                               \ 'tabpages': v:true,
   \ 'icons': v:true,
   \ 'icon_preset': 'devicon',
   \ }


let g:rainbow_active = 1

" Konfigurasi Tagbar
nnoremap <silent> <C-m> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
let g:tagbar_show_linenumbers = 1

" Aktifkan NERDTree
map <C-n> :NERDTreeToggle<CR>
"show hidden files
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeWinSize = 17
let g:NERDTreeIgnore = ['\.pyc$', '\.swp$', '__pycache__']
" Aktifkan NERDTree secara default
autocmd VimEnter * NERDTree

" Aktifkan airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_filetype = 1

set laststatus=2
"let g:airline_theme='gruvvbox'
let g:airline_thene='molokai'

" set colorscheme
syntax enable
set termguicolors
colorscheme onedark
" colorscheme molokai
" colorscheme gruvbox

set number
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set hlsearch
set incsearch
set autoindent
set nowrap
set mouse=a
set cursorline
set listchars=tab:»·,trail:·,extends:>,precedes:<
EOF

nvim +"source %" +"PlugClean" +qall
nvim +"source %" +"PlugInstall" +qall

echo "Konfigurasi telah selesai diatur"
