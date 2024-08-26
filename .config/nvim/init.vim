#!/usr/local/bin/zsh
" File: init.vim
" Author: Jeff Heaton <aloha@salt.ac>
" Last Modified Date: 2020.03.22


filetype plugin indent on
let g:html_indent_inctags = "p"
let g:markdown_folding = 1
let mapleader = " "
" show line numbers in netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
set autoindent
set autowrite
set backspace=indent,eol,start
set cursorline
set diffopt+=vertical
set directory=/tmp//
set encoding=utf-8
set expandtab
" gq works in markdown, from vim-pandoc
set formatlistpat=\\C^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+
set history=50
set ignorecase
set list
" set listchars=precedes:«,extends:»,space:·,tab:▸\
set nojoinspaces
set nomodeline
set number
set numberwidth=5
set rtp+=/usr/local/opt/fzf
set scrolloff=3
set shell=/usr/local/bin/zsh
set shiftround
set shiftwidth=2
set smartcase
set smartindent
set spellfile=$XDG_CONFIG_HOME/nvim/.vim-spell-en.utf-8.add
set splitright
set tabstop=2
set termguicolors
" allow other characters to jump to the next line
set whichwrap+=<,>,h,l
set wildmode=list:longest,full

packadd bullets.vim
packadd Colorizer
packadd diffview.nvim
packadd emmet-vim
" packadd fzf.vim
packadd goyo.vim
packadd indent-blankline.nvim
packadd limelight.vim
packadd lualine.nvim
packadd nvim-lspconfig
packadd nvim-tree.lua
packadd nvim-treesitter
packadd nvim-treesitter-context
packadd nvim-web-devicons
packadd plenary.nvim
packadd telescope.nvim
packadd trouble.nvim
packadd vim-commentary
packadd vim-fugitive
packadd vim-gh-line
packadd vim-HiLinkTrace
packadd vim-signify
packadd vim-table-mode
packadd which-key.nvim

colorscheme citylights

"
" Normal Mode
"

nnoremap <Leader><Leader> <C-^>
nnoremap x "_x
nnoremap <silent> <Leader>/<Esc> :let @/=""<CR>:<Esc>
" switch to previous buffer
nnoremap <Leader><Leader> <c-^>
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ':'

nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

" prefix: buffer
nnoremap <leader>bl <cmd>Telescope buffers<cr>
nnoremap <leader>bn :ene<CR>
nnoremap <leader>bf :Ex<CR>
nnoremap <leader>bt :term<CR>
" delete all other buffers, ie. 'buffer only'
nnoremap <leader>bo :%bd\|e#\|bd#<CR>

" prefix: go
" Reserved. See LSP below.

" prefix: file
nnoremap <leader>fa <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>NvimTreeToggle<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>

" prefix: git
" gb, gh, and go used by vim-gh-line
" TODO: figure out a better prefix for this
nnoremap <leader>gdo <cmd>DiffviewOpen staging<cr>
nnoremap <leader>gdc <cmd>DiffviewClose<cr>

" prefix: refactor
" Reserved. See LSP below

" prefix: search
nnoremap <leader>sc <cmd>Telescope grep_string<cr>
nnoremap <leader>ss <cmd>Telescope live_grep<cr>
nnoremap <leader>sf <cmd>Telescope current_buffer_fuzzy_find<cr>

" prefix: tab
nnoremap <leader>tc <cmd>tabclose<cr>
nnoremap <leader>tN <cmd>tabnew<cr>

" prefix: quickfix
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

"
" Insert Mode
"

inoremap <tab> <C-r>=InsertTabWrapper()<CR>
inoremap <s-tab> <C-n>

"
" Terminal Mode
"

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
" paste and don't replace what's in the register
vnoremap <leader>p "_dP

vnoremap y "+y

if (&t_Co > 2)
  syntax on
endif

augroup vimrcEx
  autocmd!

  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{eslint,tslint,prettier}rc set filetype=json
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter *
        \ if &number |
        \   set relativenumber |
        \ endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave *
        \ if &number |
        \   set norelativenumber |
        \ endif
augroup END

" Use jq to prettyprint json
if executable('jq')
  cnoreabbrev JQ %!jq .
endif

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --no-heading
endif

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction

augroup filetype_markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal complete+=kspell
  autocmd BufRead,BufNewFile *.md setlocal tw=80
  " TODO Add thesaurus plugin
augroup END

augroup filetype_python
  autocmd!
  autocmd BufRead,BufNewFile *.py setlocal colorcolumn=100
  " autocmd BufRead,BufNewFile *.py setlocal foldmethod=indent
augroup END

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" augroup WhiteSpaceHighlight
"   autocmd!
"   highlight WhiteSpaceBol guifg=#41505E
"   highlight WhiteSpaceMol guifg=#1D252C
"   autocmd VimEnter,Winenter * match WhiteSpaceBol /\s/ | 2match WhiteSpaceMol /\S\zs\s\ze\S/
" augroup END

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

" autosave, silencing errors on unnamed buffers
autocmd CursorHoldI,CursorHold * silent! update

lua << EOF
require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'filename',
        path = 4,
      }
    }
  }
}
require("nvim-tree").setup({
  update_focused_file = { enable = true },
})
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "gitcommit",
    "lua",
    "luadoc",
    "markdown",
    "python",
    "typescript",
    "vim",
    "vimdoc",
  },
  highlight = { enable = true },
  indent = { enable = true },
})
require("trouble").setup()
require("treesitter-context").setup()
local lspconfig = require("lspconfig")
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end
-- require("ibl").setup({})

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        black = {
          enabled = true
        },
        flake8 = {
          enabled = true
        },
        pycodestyle = {
          enabled = false
        },
        pyflakes = {
          enabled = false
        }
      }
    }
  }
})

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_enable_code_actions = true,
            enable_formatting = true,
            formatter = "prettier",
        })
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
    end,
})

local actions = require "telescope.actions"
require("telescope").setup {
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  }
}

-- Diagnostic settings
vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  underline = true,
}

local wk = require("which-key")
vim.o.timeout = true
vim.o.timeoutlen = 300
wk.register({
    { "", group = "file" },
})

EOF

" Setting whitespace highlight characters
" TODO: Move to citylights.vim
highlight IndentBlanklineChar guifg=#212B32 gui=nocombine
highlight IndentBlanklineSpaceChar guifg=#212B32 gui=nocombine
highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine
highlight IndentBlanklineContextSpaceChar guifg=#00FF00 gui=nocombine
highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline

" LSP config
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <C-e> <cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>
nnoremap <leader>rr <cmd>lua vim.lsp.buf.rename()<cr>

" auto-format
" autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.format()

