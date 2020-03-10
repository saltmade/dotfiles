#!/usr/local/bin/zsh
" File: init.vim
" Author: Jeff Heaton <jeff@jgheaton.com>
" Last Modified Date: 2018.12.30

" TODO Move git gutter inside line numbers
" TODO Allow current line number to be right aligned in relative ln (nu, rnu)
" TODO Change gutter padding
" TODO Whitespace characters ala VSCODE (Yggdroot/indentLine)
" TODO bracket pairs with scope lines ala https://github.com/CoenraadS/Bracket-Pair-Colorizer-2
" TODO figure out how to enable autocomplete only in certain buffers
" TODO leading spaces, see Yggdroot/indentLine
" TODO get neoterm to open a new vsplit and run command
" TODO figure out how to install python packages for neovim-remote, jedi,
" TODO Add pymode for IDE-like editing
" anki-vim

" ============================================================================ "
" ===                           PLUGINS (DEIN)                             === "
" ============================================================================ "
set runtimepath+=$XDG_DATA_HOME/dein/repos/github.com/Shougo/dein.vim " path to dein.vim

if dein#load_state($XDG_DATA_HOME . '/dein')
  call dein#begin($XDG_DATA_HOME . '/dein') " plugins' root path

  " Let dein manage dein
  call dein#add($XDG_DATA_HOME . '/dein/repos/github.com/Shougo/dein.vim')

  " UI
  call dein#add('jefheaton/citylights.vim') " pretty colors
  call dein#add('scrooloose/nerdtree') " the classic file tree
  call dein#add('ryanoasis/vim-devicons') " icons in your filetrees and searches
  call dein#add('qpkorr/vim-bufkill') " kill the buffer, not the window

  " syntax highlighting
  call dein#add('sheerun/vim-polyglot')
  call dein#add('chrisbra/Colorizer')

  " IDE-like features
  " call dein#add('Shougo/denite.nvim') dark powered fuzzy finding
  call dein#add('janko-m/vim-test') " test runner for vim
  call dein#add('907th/vim-auto-save')  " like it says on the tin
  call dein#add('neoclide/coc.nvim', {'merge':0, 'rev': 'release'})

  " Term features
  call dein#add('kassio/neoterm') " send commands to term window

  " Text and outline features
  call dein#add('godlygeek/tabular') " easy alignment
  call dein#add('vim-pandoc/vim-pandoc') " pandoc mode and conversion
  call dein#add('vim-pandoc/vim-pandoc-syntax')

  call dein#end()
  call dein#save_state()
endif

" Install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


"" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "
filetype plugin indent on "tells vim to detect filetype and set options
syntax enable

" Include all subdirectories of pwd in search, e.g. :find, :b
" if you want fuzzy, use a *, e.g. *.html or component* and use TAB
set path+=**

" Use the system clipboard by default
set clipboard^=unnamed
" Prevent x deletions from clobbering to clipboard, in exchange for no xp[aste]
noremap x "_x

" automatically enter insert mode when you switch to a terminal
" only not-annoying bc of movement remappings below that autoexit
" autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif

" Display all matching files when tab completing
" You'll likely also want to add a script to include gitignore in your
" wildignore
" set wildmenu
command! MakeTags !ctags -R .

set nobackup " don't make a backup file
set nowritebackup " don't make a backup file while writing the file to disk
set history=50
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set foldcolumn=0

" set terminal colorscheme
set termguicolors " use true colors
set background=dark
colorscheme citylights

" use relative line numbers in normal, relativenumber in insert
set nonu
set number relativenumber
set numberwidth=5
set ruler  " show cursor position at all times
set showcmd " show commands as you run them
set incsearch  " highlight search results as you go

" Specify line numbering type by Mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" soft tabs, two spaces
" if needed, :set et && :retab
set backspace=2   " Backspace deletes like most programs in insert mode
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set shiftround
set smarttab

" Display extra whitespace
set list listchars=tab:\|·,trail:·,nbsp:·

" Add numbered lists to the formatting mix
set formatoptions+=n

" Set list formatting regex to allow for common characters
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*

" Set comment lines to give lists and task character sequences proper indentation
set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:[+],fb:[x],fb:[-]

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
" set colorcolumn=+1

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Allows you to use Tab for vim cmds
set wildmenu

" === Markdown === "
let g:markdown_folding=1

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "
" COC and denite thanks to https://www.freecodecamp.org/news/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2/

" === Fuzzy Finding === "
try
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'prompt': 'λ:',
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :dein#install()'
endtry

" === Symbol Column === "
" When to show git gutter
let g:signify_vcs_list = ['git']
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
let g:signify_line_highlight = 1
let g:signify_sign_add = '▐'
let g:signify_sign_change = '▐'
let g:signify_sign_delete = '▐'

" === Autocomplete === "
" Note that the trailing , still needs to be entered
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" === Autosave === "
" Enable autosave plugin
let g:auto_save = 1

" Only save in Normal mode periodically
let g:auto_save_in_insert_mode = 0

" Silently autosave
let g:auto_save_silent = 1

" And now turn Vim swapfile off
" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noswapfile

" === FileTree === "
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
" hide the help UI
let NERDTreeMinimalUI = 1


"" ============================================================================ "
" ===                           COC SUGGESTED                              === "
" ============================================================================ "
" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" ============================================================================ "
" ===                           REMAPPINGS                                 === "
" ============================================================================ "
cnoremap hv vert help<SPACE>

" === Leader === "
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" === Prevent Bad Behavior === "
" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" === File shorcuts === "
"   <leader>f - Browse list of files in current directory
nmap <leader>ff :Denite file/rec -split=floating -winrow=1<CR>

" === File Tree shorcuts === "
nnoremap <silent> <Leader>nt :NERDTree<CR>
nnoremap <silent> <Leader>nv :NERDTreeVCS<CR>
nnoremap <silent> <Leader>nf :NERDTreeFocus<CR>
nnoremap <silent> <Leader>nbo :NERDTreeFocus<CR> :OpenBookmark 

" === Buffer shorcuts === "
"   ;         - Browse currently open buffers, allowing it because it's
"   important and because I use vim sneak
nmap <Leader>; :Denite buffer -start-filter=true -split=floating -winrow=1<CR>

" === Movement shorcuts === "
" from vimcasts http://vimcasts.org/episodes/neovim-terminal-mappings/
" get to normal mode and move
if has('nvim')
  "  use esc to exit nvim terminal instead of c-\ c-n
  tnoremap <Esc> <C-\><C-n>
  " pass escape character inside term
  " use alt-[ as it's similar to ctrl-[
  " vim suggests using ctrl-[ instead of esc since its easier
  tnoremap <A-[> <Esc>
  " Terminal mode:
  tnoremap <C-h> <c-\><c-n><c-w>h
  tnoremap <C-j> <c-\><c-n><c-w>j
  tnoremap <C-k> <c-\><c-n><c-w>k
  tnoremap <C-l> <c-\><c-n><c-w>l
  " Insert mode:
  inoremap <C-h> <Esc><c-w>h
  inoremap <C-j> <Esc><c-w>j
  inoremap <C-k> <Esc><c-w>k
  inoremap <C-l> <Esc><c-w>l
  " Visual mode:
  vnoremap <C-h> <Esc><c-w>h
  vnoremap <C-j> <Esc><c-w>j
  vnoremap <C-k> <Esc><c-w>k
  vnoremap <C-l> <Esc><c-w>l
  " Normal mode:
  nnoremap <C-h> <c-w>h
  nnoremap <C-j> <c-w>j
  nnoremap <C-k> <c-w>k
  nnoremap <C-l> <c-w>l
endif

" === Fuzzy Finding shorcuts === "
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nnoremap <leader>gg :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>gc :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" === Test shorcuts === "
" vim-test mappings
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" ============================================================================ "
" ===                           VIM MAGIC                                  === "
" ============================================================================ "
"
" use nvr to not nvim-ception in :term
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
" tell vim to exit buffer correctly using nvr
autocmd FileType gitcommit set bufhidden=delete

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

