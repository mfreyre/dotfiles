set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'brendonrapp/smyck-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

call plug#end()

" General Settings
syntax enable
set ruler
set showcmd
set showmatch
set nowrap
set nofoldenable
set hidden
set hlsearch
set incsearch
set clipboard=unnamed

" Indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set backspace=indent,eol,start

" Line Numbering
set number
set relativenumber
" use absolute line numbering in insert mode
autocmd InsertEnter,InsertLeave * :set invrelativenumber

" Color Scheme
set t_Co=256
colorscheme smyck
set colorcolumn=81,101
highlight ColorColumn ctermbg=236
highlight SignColumn cterm=NONE ctermbg=NONE

" Mappings - ^ + [q,s] only works when 'stty -ixon'
let mapleader=' '
nnoremap n nzz
nnoremap N Nzz
set pastetoggle=<leader>p
nnoremap <leader>w :w<cr>
nnoremap <leader>q :bd<cr>
nnoremap <c-q> :bp<cr>
nnoremap <c-e> :bn<cr>
inoremap <c-q> <esc>:bp<cr>
inoremap <c-e> <esc>:bn<cr>
vnoremap <c-q> <esc>:bp<cr>
vnoremap <c-e> <esc>:bn<cr>

" TComment
nnoremap <silent> <leader>t :TComment<cr>
vnoremap <silent> <leader>t :TComment<cr>

" FZF
cnoreabbrev fzf FZF
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>g :GFiles<cr>
nnoremap <silent> <leader>c :Commits<cr>
nnoremap <silent> <leader>b :BCommits<cr>

" gf (Etsyweb/phplib files only)
set path=~/development/Etsyweb/phplib
set includeexpr=substitute(v:fname,'_','/','g')
set suffixesadd+=.php

" syntastic
let g:syntastic_quiet_messages = { 'type': 'style' }
let g:syntastic_enable_balloons = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_error_symbol = '✘❯'
let g:syntastic_warning_symbol = '▲❯'
let g:syntastic_style_error_symbol = '✘❯'
let g:syntastic_style_warning_symbol = '▲❯'
highlight SyntasticErrorSign ctermfg=9  ctermbg=NONE
highlight SyntasticWarningSign ctermfg=11 ctermbg=NONE
highlight SyntasticStyleErrorSign ctermfg=9  ctermbg=NONE
highlight SyntasticStyleWarningSign ctermfg=11 ctermbg=NONE

" bufferline
set showtabline=2
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
let g:bufferline_modified = '✱'
let g:bufferline_active_buffer_left = '❮'
let g:bufferline_active_buffer_right =  '❯'

" lightline
set noshowmode
set timeoutlen=1000
set ttimeoutlen=0
set laststatus=2
let g:lightline = {
\   'active': {
\     'left': [ ['mode', 'paste', 'syntasticoff'],
\               ['readonly', 'fugitive', 'modified'] ],
\     'right': [ ['lineinfo'], ['percent'], ['fileformat', 'filetype'] ]
\   },
\   'tabline': {
\     'left': [ ['bufferline'] ],
\     'right': [ ['fileencoding'] ]
\   },
\   'component': {
\     'fileformat': '%{winwidth(0) > 70 ? &fileformat : ""}',
\     'lineinfo': "\ue0a1%3l:%-2v",
\     'readonly': '%{&ft !~? "help" && &readonly ? "\ue0a2" : ""}'
\   },
\   'component_visible_condition': {
\     'fileformat': 'winwidth(0) > 70'
\   },
\   'component_function': {
\     'bufferline': 'LightlineBufferline',
\     'fugitive': 'LightlineFugitive',
\     'syntasticoff': 'LightlineSyntasticDisabled'
\   }
\ }

" displays a buffer line using vim-bufferline in lightline's tabline. line.
fu! LightlineBufferline()
  call bufferline#refresh_status()
  return join([
  \   g:bufferline_status_info.before,
  \   g:bufferline_status_info.current,
  \   g:bufferline_status_info.after
  \ ], '')
endfu

" displays current git branch in lightline using vim-fugitive
fu! LightlineFugitive()
  if exists('*fugitive#head')
    return fugitive#head() !=# '' ? "\ue0a0 ".fugitive#head() : ''
  endif
  return ''
endfu

"displays '$' in lightline when syntastic is disabled
fu! LightlineSyntasticDisabled()
  let b = exists('b:syntastic_mode') ? b:syntastic_mode : ''
  let g = exists('g:syntastic_mode_map.mode') ? g:syntastic_mode_map.mode : ''
  return b == 'passive' || g == 'passive' ? '$' : ''
endfu

" saves cursor position, strips whitespace, then restores cursor position
fu! StripTrailingWhitespace()
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfu
autocmd BufWritePre * :call StripTrailingWhitespace()

" toggles syntastic mode for buffer
fu! SyntasticToggleBufferMode()
  if !exists('b:syntastic_mode') || b:syntastic_mode == 'active'
    let b:syntastic_mode = 'passive'
  else
    let b:syntastic_mode = 'active'
  endif
  echo 'Syntastic: '.b:syntastic_mode.' mode enabled for buffer'
  SyntasticReset
endfu
nnoremap <silent> <leader>s :call SyntasticToggleBufferMode()<cr>

" toggles display of syntastic style errors/warnings for session
fu! SyntasticToggleStyle()
  if exists('g:syntastic_quiet_messages.type')
    let g:syntastic_quiet_messages = {} | echo 'Syntastic: style-check enabled'
  else
    let g:syntastic_quiet_messages = { 'type': 'style' }
    echo 'Syntastic: style-check disabled'
  endif
  SyntasticReset
endfu
nnoremap <silent> <leader>z :call SyntasticToggleStyle()<cr>

