""" Vundle Entries
" NOTE: comments after Bundle command are not allowed..
set nocompatible               " be iMproved
filetype off                   " required!

set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'ctrlpvim/ctrlp.vim'
  map <Leader>t :CtrlPBuffer<CR>
  "let g:ctrlp_working_path_mode = 0 " don’t manage working directory.
  let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v\c\.(git|svn)$|cover_db|vendor|deps|_build|node_modules|tmp',
  \ 'file': '\v\c\.(swf|bak|png|gif|mov|ico|jpg|pdf|jrxml)$',
  \ }
Plugin 'vim-airline/vim-airline'
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
Plugin 'easymotion/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
  set signcolumn=yes
  highlight clear SignColumn
  let g:gitgutter_async=0
Plugin 'vim-ruby/vim-ruby'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-markdown'
Plugin 'kana/vim-textobj-lastpat'
Plugin 'elixir-editors/vim-elixir'
Plugin 'slashmili/alchemist.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-eunuch'
Plugin 'joshdick/onedark.vim'


call vundle#end()            " required
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

autocmd Filetype ruby set shiftwidth=2 tabstop=2 expandtab
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

inoremap <C-S> <ESC>:update<CR>a
nnoremap <C-S> :update<CR>
nnoremap <C-L> :noh<CR><C-L>
inoremap jj <Esc>
nnoremap <Leader><Leader>t :ClearAllCtrlPCaches<CR>

nnoremap <Leader>r :source ~/.vimrc<CR>
nnoremap <Leader><Leader>r :e ~/.vimrc<CR>
" Ctrl P/N on Command Line mode (with filtering)
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>

map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gm :Gcommit --amend<CR>
map <Leader>gll :Git log<CR>
map <Leader>glp :Git log -p<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gdd :Git diff<CR>
map <Leader>gdm :Git diff %<CR>
map <Leader>gdf :Gdiff<CR>
map <Leader>gg :Git

map <Leader>] :wa<bar><UP><CR>

nnoremap <Leader>q" ciw""<Esc>P
nnoremap <Leader>q' ciw''<Esc>P

nmap <F1> <Esc>
imap <F1> <Esc>

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
