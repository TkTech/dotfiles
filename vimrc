set nocompatible
filetype off
set encoding=utf8

" Ale likes to be configured early or some settings will work oddly.
let g:ale_set_balloons=1
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_pattern_options = {
\ '\.py$': {'ale_linters': ['flake8', 'pyls']}
\}
let g:ale_python_pyls_config = {
\   'pyls': {
\     'plugins': {
\       'pycodestyle': {
\         'enabled': v:false
\       }
\     }
\   },
\ }

" ---------------------------------------------------------------------------
"  Vundle settings & setup
" ---------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Required, lets Vundle manage itself.
Plugin 'VundleVim/Vundle.vim'
" Adds quicksilver (Ag) integration
Plugin 'rking/ag.vim'
" Adds git integration (:Gblame, :Glog, etc...)
Plugin 'tpope/vim-fugitive'
" Adds a speedy fuzzy-matcher.
Plugin 'kien/ctrlp.vim'
" Adds support for jumping to method definitions in the current file without
" requiring up-to-date ctags.
Plugin 'tacahiroy/ctrlp-funky'
" Extended language pack for common languages.
Plugin 'sheerun/vim-polyglot'
" LanguageServer client with async support (vim 1.8+).
Plugin 'dense-analysis/ale'
" Adds Jinja2+HTML syntax highlighting.
Plugin 'Glench/Vim-Jinja2-Syntax'
" Adds better Liquid/Jekyll highlighting.
Plugin 'tpope/vim-liquid'
" Decent vim color scheme.
Plugin 'joshdick/onedark.vim'
" Support for .editorconfig files.
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()
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
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" ---------------------------------------------------------------------------
"  Visual/presentation settings
" ---------------------------------------------------------------------------
set t_Co=256
syntax enable
set background=dark
" We ignore errors setting the color scheme because we're probably
" running !PluginInstall in our bootstrap.
silent! colorscheme onedark
" Make a colored column at 80 characters.
set colorcolumn=80
highlight ColorColumn ctermbg=235
" Enable background transparency.
highlight Normal ctermbg=NONE guibg=NONE

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
set ttymouse=xterm
set completeopt=menu,menuone,preview,noselect,noinsert

" ---------------------------------------------------------------------------
"  Settings specific to certain filetypes.
" ---------------------------------------------------------------------------
" Use 2 spaces instead of 4 for HTML files.
autocmd FileType html :setlocal sts=2 ts=2 sw=2
autocmd FileType jinja :setlocal sts=2 ts=2 sw=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

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
" Add some git status information to the statusline if vim-fugitive is
" available.
set statusline+=%{fugitive#statusline()}

" ---------------------------------------------------------------------------
" Misc.
" ---------------------------------------------------------------------------
" Adjust the size of the quickfix window when it opens so it doesn't use
" as much screen estate. By default, the qf window uses 10 rows even when
" only one or two lines are present.
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" ---------------------------------------------------------------------------
"  Ctrl-P settings
" ---------------------------------------------------------------------------
let g:ctrlp_extensions = ['funky']
" Ignore some VCS directorise and temporary/cruft files when using
" ctrl-p.
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|\.hg|\.svn|.*\.egg-info|dist|build|__generated__|node_modules|venv)$',
    \ 'file': '\v\.(exe|so|dll|pyc|csv)$',
    \ }

" If silver searcher is installed, use it instead of ctrl-p's built-in
" searching. Much, much, much faster and does not require caching at all.
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" fu to search symbols in the current buffer.
nnoremap <Leader>fu :CtrlPFunky<Cr>

" ---------------------------------------------------------------------------
"  OS X specific plugin settings.
" ---------------------------------------------------------------------------
if has("mac")
    " Use <leader>d to search for the current word in Dash.app
    nmap <silent> <leader>d <Plug>DashSearch
endif

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
