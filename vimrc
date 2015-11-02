""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'itchyny/lightline.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - removes unused plugins; append `!` to auto-approve
" see :h vundle for more details or wiki for FAQ

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set ruler
set showcmd
set showmatch
set nowrap
set nofoldenable

set hlsearch
set incsearch
nmap <space> zz
nmap n nzz
nmap N Nzz

set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme smyck
set colorcolumn=81
highlight ColorColumn ctermbg=235

" unhighlight sign column
highlight SignColumn cterm=NONE ctermbg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
set laststatus=2
set timeoutlen=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line Numbering
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber
autocmd InsertEnter * :set invrelativenumber
autocmd InsertLeave * :set invrelativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hard Mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
vnoremap <up> <NOP>
vnoremap <down> <NOP>
vnoremap <left> <NOP>
vnoremap <right> <NOP>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" strip all trailing whitespace on save (Credit to Aleks Kamko/Facebook)
if !exists("g:fb_kill_whitespace") | let g:fb_kill_whitespace = 1 | endif
if g:fb_kill_whitespace
  fu! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfu
  au FileType c,cabal,cpp,haskell,javascript,php,python,ruby,readme,tex,text
    \ au BufWritePre <buffer>
    \ :call <SID>StripTrailingWhitespaces()
endif

