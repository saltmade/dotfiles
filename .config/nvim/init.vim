" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" pretty colors
Plug 'colepeters/spacemacs-theme.vim'
" numbers in gutter
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mattn/emmet-vim'
Plug 'janko-m/vim-test'  " run specs in vim
Plug 'w0rp/ale' " Asynchronous Linting Engine
Plug 'tpope/vim-unimpaired' " adds complementary shortcuts, I added for the newlines in normal mode

" YouCompleteMe
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" fancy start screen
Plug 'mhinz/vim-startify'

" fancy writing environment
Plug 'junegunn/goyo.vim'

" fancy focus
Plug 'junegunn/limelight.vim'

" Initialize plugin system
call plug#end()


""""""""""""
" remappings
"""

" Leader
let mapleader = " "

" use esc to exit nvim terminal instead of c-\ c-n
:tnoremap <Esc> <C-\><C-n>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

let g:markdown_folding=1

" set terminal colorscheme
if (has("termguicolors"))
  set termguicolors
endif
set background=dark
colorscheme spacemacs-theme

" use relative line numbers in normal, relativenumber in insert
set number relativenumber
set numberwidth=5
set ruler  " show cursor position at all times
set showcmd " show commands as you run them
set incsearch  " highlight search results as you go

" don't create swap files as temporary backups
set noswapfile

" soft tabs, two spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Make it obvious where 80 characters is
" set textwidth=80
" set colorcolumn=+1

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
