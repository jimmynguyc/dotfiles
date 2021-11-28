""" Vundle Entries
" NOTE: comments after Bundle command are not allowed..
set nocompatible               " be iMproved
filetype off                   " required!

set shell=/bin/bash
call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

" My Bundles here:
"
" original repos on github
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'ctrlpvim/ctrlp.vim'
  "let g:ctrlp_working_path_mode = 0 " don’t manage working directory.
  let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v\c\.(git|svn)$|cover_db|vendor|deps|_build|node_modules|tmp',
  \ 'file': '\v\c\.(swf|bak|png|gif|mov|ico|jpg|pdf|jrxml)$',
  \ }
Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  "let g:airline_symbols.branch = '⎇ '
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'

Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
  set signcolumn=yes
  highlight clear SignColumn
  let g:gitgutter_async=0

Plug 'vim-ruby/vim-ruby'
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
    \ ]

  " prettier command for coc
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  let g:NERDTreeIgnore = ['^node_modules$']

Plug 'mileszs/ack.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'amadeus/vim-mjml'


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
set mouse=c
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
nnoremap <Leader>r :source ~/.vimrc<CR>
nnoremap <Leader><Leader>r :e ~/.vimrc<CR>
nnoremap <Leader>sa :wall<CR>
nnoremap <Leader>qa :bufdo bd<CR>
nnoremap <Leader>qq ciw""<Esc>P
nnoremap <Leader>qs ciw''<Esc>P
nnoremap <Leader>qs ciw''<Esc>P
inoremap <C-S> <ESC>:update<CR>a
inoremap jj <Esc>
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>

" CtrlP
nnoremap <Leader>t :CtrlPBuffer<CR>
nnoremap <Leader>tc :ClearAllCtrlPCaches<CR>

" NERDTree
nnoremap <C-B> :NERDTreeToggle<CR>
nnoremap <C-F> :NERDTreeFind<CR>

" Coc Actions
nnoremap <Leader>g :call CocActionAsync('jumpDefinition')<CR>
nnoremap <Leader>f :call CocAction('format')<CR>


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

