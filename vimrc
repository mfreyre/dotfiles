set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug '/home/jlai/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'jonlai/smyck-vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'
" filetype-specific plugins
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'

call plug#end()

" general settings
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

" indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set backspace=indent,eol,start

" line numbering
set number
set relativenumber
autocmd InsertEnter,InsertLeave * :set invrelativenumber

" color scheme
set t_Co=256
colorscheme smyck
set colorcolumn=81,101
highlight ColorColumn ctermbg=236
highlight SignColumn cterm=NONE ctermbg=NONE
highlight def link javascriptOpSymbol Operator
highlight def link javascriptOpSymbols Operator

" mappings
let mapleader=' '
nnoremap Q <nop>
nnoremap q: <nop>
nnoremap n nzz
nnoremap N Nzz
nnoremap <leader>p :set invpaste<cr>
nnoremap <leader>q :bd<cr>
nnoremap <c-j> :bp<cr>
nnoremap <c-k> :bn<cr>
inoremap <c-j> <esc>:bp<cr>
inoremap <c-k> <esc>:bn<cr>
vnoremap <c-j> <esc>:bp<cr>
vnoremap <c-k> <esc>:bn<cr>

" easymotion
map <leader> <plug>(easymotion-prefix)

" tcomment
nnoremap <silent> <leader>x :TComment<cr>
vnoremap <silent> <leader>x :TComment<cr>

" fzf
cnoreabbrev fzf FZF
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>d :GFiles<cr>
nnoremap <silent> <leader>c :BCommits<cr>

" gf (Etsyweb/phplib files only)
set path=~/development/Etsyweb/phplib
set includeexpr=substitute(v:fname,'_','/','g')
set suffixesadd+=.php

" ale
let g:ale_lint_delay = 350
let g:ale_set_balloons = 0
let g:ale_set_highlights = 0
let g:ale_sign_error = '✘❯'
let g:ale_sign_warning = '▲❯'
let g:ale_sign_style_error = '✘❯'
let g:ale_sign_style_warning = '▲❯'
highlight ALEErrorSign ctermfg=0 ctermbg=9
highlight ALEWarningSign ctermfg=0 ctermbg=11
highlight ALEStyleErrorSign ctermfg=0 ctermbg=9
highlight ALEStyleWarningSign ctermfg=0 ctermbg=11

" linters/fixers/ignores
let g:ale_linters = {
\     'javascript': ['eslint'],
\     'php': ['phpcs'],
\     'bash': ['shellcheck'],
\     'zsh': ['shellcheck'],
\     'sh': ['shellcheck']
\   }
let g:ale_fixers = {
\     'javascript': ['prettier']
\   }
let g:ale_pattern_options = {
\     '\.min\.js$': { 'ale_linters': [], 'ale_fixers': [] },
\     '\.min\.css$': { 'ale_linters': [], 'ale_fixers': [] }
\   }
let g:ale_sh_shellcheck_exclusions = 'SC2148'
let g:ale_php_phpcs_standard =
\     expand($HOME) . '/development/Etsyweb/tests/standards/stable-ruleset.xml'

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
\     'active': {
\       'left': [
\         ['mode', 'paste', 'alestatus'],
\         ['readonly', 'fugitive', 'modified']
\       ],
\       'right': [ ['lineinfo'], ['percent'], ['fileformat', 'filetype'] ]
\     },
\     'tabline': {
\       'left': [ ['bufferline'] ],
\       'right': [ ['fileencoding'] ]
\     },
\     'component': {
\       'fileformat': '%{winwidth(0) > 70 ? &fileformat : ""}',
\       'lineinfo': "\ue0a1%3l:%-2v",
\       'readonly': '%{&ft !~? "help" && &readonly ? "\ue0a2" : ""}'
\     },
\     'component_visible_condition': {
\       'fileformat': 'winwidth(0) > 70'
\     },
\     'component_function': {
\       'bufferline': 'LightlineBufferline',
\       'fugitive': 'LightlineFugitive',
\       'alestatus': 'LightlineALEStatus'
\     }
\   }

" displays a buffer-list using vim-bufferline in lightline's tabline
fu! LightlineBufferline()
  call bufferline#refresh_status()
  return join([
\          g:bufferline_status_info.before,
\          g:bufferline_status_info.current,
\          g:bufferline_status_info.after
\        ], '')
endfu

" displays current git branch in lightline using vim-fugitive
fu! LightlineFugitive()
  if exists('*fugitive#head')
    return fugitive#head() !=# '' ? "\ue0a0 ".fugitive#head() : ''
  endif
  return ''
endfu

" displays '$' or 'F' in lightline when ale is disabled or fix-enabled
fu! LightlineALEStatus()
  let is_ale_enabled = get(b:, 'ale_enabled', 1) && g:ale_enabled
  return is_ale_enabled ? (get(b:, 'ale_fix_on_save') ? 'Ｆ' : '') : '＄'
endfu
nnoremap <silent> <leader>a :call ale#toggle#Toggle()<cr>

" toggles ale's fix mode per buffer
fu! ALEToggleFixMode()
  let b:ale_fix_on_save = get(b:, 'ale_fix_on_save') ? 0 : 1
endfu
nnoremap <silent> <leader>z :call ALEToggleFixMode()<cr>

" turn off syntax and linting if buffer is large
fu! IsLargeBuffer()
  if line2byte(line("$") + 1) > 1000000
    syntax clear
    let b:ale_enabled = 0
  endif
endfu
autocmd BufWinEnter * :call IsLargeBuffer()

" saves cursor position, strips whitespace, then restores cursor position
fu! StripTrailingWhitespace()
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfu
autocmd BufWritePre * :call StripTrailingWhitespace()
