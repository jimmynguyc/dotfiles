""" Vundle Entries
" NOTE: comments after Bundle command are not allowed..
set nocompatible               " be iMproved
filetype off                   " required!

set shell=/bin/bash
call plug#begin('~/.vim/plugged')

" My Bundles here:
"
" original repos on github
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1

Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
  set signcolumn=yes
  highlight clear SignColumn
  let g:gitgutter_async=0

Plug 'vim-ruby/vim-ruby'
  let g:ruby_indent_assignment_style = 'variable'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-markdown'
Plug 'kana/vim-textobj-lastpat'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-eunuch'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-solargraph',
    \ 'coc-vetur',
    \ 'coc-phpls',
    \ 'coc-yaml',
    \ 'coc-svelte',
    \ ]

  " prettier command for coc
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
  if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column --path-to-ignore=/Users/jimmy/.ackignore'
  endif
  let NERDTreeQuitOnOpen = 1

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'


call plug#end()

filetype plugin indent on    " required

""" vimrc resumes :-)

set autoindent
set backspace=indent,eol,start
set cindent " set smartindent
set cmdheight=2
set nocursorcolumn
set nocursorline
set errorformat=\"../../%f\"\\,%*[^0-9]%l:\ %m
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-
set mouse=a
set nowrap
set nrformats=
set number
set ruler
set scrolloff=5
set shiftwidth=2
set tabstop=2
set showcmd
set showmatch
set smarttab
"set statusline=%F%m%r%h%w\ [%{&ff}]\ %y\ [CHR=%b/0x%B]\ [POS=%04l,%03c(%03v)]\ [%p%%]\ [LEN=%L]\ %{fugitive#statusline()}
set t_Co=256
set tags=tags;/
set virtualedit=block
set wrap
set title
set clipboard=unnamed
set encoding=UTF-8
set spelllang=en
set relativenumber

autocmd Filetype ruby set shiftwidth=2 tabstop=2 expandtab omnifunc=LanguageClient#complete
autocmd Filetype elixir set shiftwidth=2 tabstop=2 expandtab

syntax on

highlight   CursorColumn  term=NONE    cterm=none ctermbg=232
highlight   CursorLine    term=NONE    cterm=bold ctermbg=8
highlight   ColorColumn   term=NONE    cterm=bold ctermbg=1
highlight   FoldColumn                            ctermbg=8  ctermfg=14
highlight   Folded                                ctermbg=8  ctermfg=14
highlight   Search        term=reverse cterm=bold ctermbg=11 ctermfg=0
highlight   Visual        term=NONE    cterm=bold ctermbg=10 ctermfg=8
"
"" makes Omni Completion less pinky :P
highlight   Pmenu                                 ctermbg=2  ctermfg=0
highlight   PmenuSel                              ctermbg=7  ctermfg=0
highlight   PmenuSbar                             ctermbg=0  ctermfg=7
highlight   PmenuThumb                            ctermbg=7  ctermfg=0

" :help last-position-jump
"
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

""" Key Mappings
" Generic
nnoremap <C-S> :update<CR>
nnoremap <C-L> :noh<CR><C-L>
nnoremap <C-J> :cclose<CR>
nnoremap <Leader>r :source ~/.vimrc<CR>
nnoremap <Leader><Leader>r :e ~/.vimrc<CR>
nnoremap <Leader>sa :wall<CR>
nnoremap <Leader>qa :bufdo bd<CR>
nnoremap <Leader>bd :%bd\|e#\|bd#<CR>
nnoremap <Leader>qq ciw""<Esc>P
nnoremap <Leader>qs ciw''<Esc>P
nnoremap <Leader>qs ciw''<Esc>P
nnoremap <Leader>ff gg=G<CR>
nnoremap <Leader>f :! standardrb --fix %<CR>
nnoremap <Leader>fn :let @*=expand("%")<CR>
nnoremap <Leader>p "0P<CR>
inoremap <C-S> <ESC>:update<CR>a
inoremap jj <Esc>
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>

" Telecope
nnoremap <C-P> :Telescope find_files theme=ivy<CR>
nnoremap <Leader>t :Telescope buffers theme=ivy<CR>

" NERDTree
nnoremap <C-B> :NERDTreeToggle<CR>
nnoremap <C-F> :NERDTreeFind<CR>

" Coc Actions
nnoremap <Leader>g :call CocActionAsync('jumpDefinition')<CR>

" Ack
cnoreabbrev Ack Ack!

""" End Key Mappings

autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

if match($TERM, "screen-256color")!=-1
  set term=xterm-256color
elseif match($TERM, "screen")!=-1
  set term=xterm
endif

" Indentation fix for JS embedded html
autocmd BufRead *.html set filetype=htmlm4

" Auto clear trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Theme
colorscheme onedark

