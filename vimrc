set nocompatible
filetype off
set encoding=utf8

" Automatically install Plug if it's missing.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'projekt0n/github-nvim-theme'
Plug 'neovim/nvim-lspconfig', has('nvim') ? {} : { 'on': [] }
Plug 'nvim-treesitter/nvim-treesitter', has('nvim') ? {'do': ':TSUpdate'} : { 'on': [] }
Plug 'hrsh7th/nvim-compe', has('nvim') ? {} : { 'on': [] }
Plug 'nvim-lua/popup.nvim', has('nvim') ? {} : { 'on': [] }
Plug 'nvim-lua/plenary.nvim', has('nvim') ? {} : { 'on': [] }
Plug 'nvim-telescope/telescope.nvim', has('nvim') ? {} : { 'on': [] }
call plug#end()

filetype plugin indent on

" ---------------------------------------------------------------------------
"  Whitespace settings
" ---------------------------------------------------------------------------
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Display non-printable characters.
set list
" Show newlines as $, and trailing whitespace as ~.
set listchars=tab:>-,trail:~,extends:>,precedes:<

" ---------------------------------------------------------------------------
"  Visual/presentation settings
" ---------------------------------------------------------------------------
if has('termguicolors')
  set termguicolors
endif
syntax enable
set background=dark
" Make a colored column at 80 characters.
set colorcolumn=80
highlight ColorColumn ctermbg=235
" Enable background transparency.
" highlight Normal ctermbg=NONE guibg=NONE

" Remove the vertical divider between panes. We've forced line numbers which
" work just fine as a visual divider.
:set fillchars+=vert:\ 
highlight VertSplit cterm=NONE
" But if you want clean unicode pipes instead, use this:
" set fillchars+=vert:│

" ---------------------------------------------------------------------------
"  misc. settings
" ---------------------------------------------------------------------------
" Show line numbers.
set number
" Line numbers are relative to the current line.
set relativenumber
" Create new window splits below the current split.
set splitbelow
" Create new window splits to the right of the current split.
set splitright
" Don't produce temporary swap files (*.swo, *.swp, etc...).
set noswapfile
" Disable bells and screen flashes
set belloff=all
" Use the system clipboard.
set clipboard=unnamed
" Treat backspace more like traditional editors when in insert mode.
" indent means we can delete past indentation blocks, eol means we can
" delete past the end of the line, start means we can delete past where we
" entered insert mode.
set backspace=indent,eol,start
" Enable mouse support
set mouse=a
if exists(':ttymouse')
    " neovim deprecated this option, as mouse support is the default.
    set ttymouse=xterm2
endif

" ---------------------------------------------------------------------------
"   Settings for the vim statusline
" ---------------------------------------------------------------------------
" Always show the statusline.
set laststatus=2

set statusline=
" Tail of the current path (usually the filename)
set statusline+=%t
" The file encoding (ex: utf-8)
set statusline+=\ -\ [%{strlen(&fenc)?&fenc:'none'}, 
" msdos or unix line endings
set statusline+=%{&ff}] "file format

set completeopt=menuone,noselect

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
