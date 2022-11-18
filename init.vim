"------------------------------------------
" Installing NeoVIM
"------------------------------------------
" * https://github.com/neovim/neovim/wiki/Installing-Neovim
"
" NeoVim 0.5 Setup guides
" * https://medium.com/life-at-moka/step-up-your-game-with-neovim-62ba814166d7
" * https://crispgm.com/page/neovim-is-overpowering.html
"
" Install python3 pip and pynvim
"   sudo apt install python3-pip
"   python3 -m pip install --user --upgrade pynvim
"
" Install typescript language server wrapper
"   npm install -g typescript-language-server
"
" Install fzf for terminal fuzzy find
"   git clone https://github.com/junegunn/fzf ~/.fzf
"   ~/.fzf/install
"
" TODO: Install rust-analyser

"------------------------------------------
" General configuration
"------------------------------------------
syntax on
"set ma
set laststatus=2
set shiftwidth=4 tabstop=4
set expandtab
set autoread
set number relativenumber
set scrolloff=7
set cursorline
set encoding=UTF-8

syntax enable

"------------------------------------------
" Key mapping and basic configuration
"------------------------------------------
let mapleader=","
inoremap jj <esc> " Add jj as escape trigger

" Enable line numbering (for nerdtree)
nnoremap <leader>nn :set number<CR>:set relativenumber<CR>

" Read stdin into buffer at startup.
"autocmd StdinReadPre * let s:std

"------------------------------------------
" Plugins
"------------------------------------------
call plug#begin("~/.config/nvim/plugged")
  "---------------------
  " Color Schemes
  "---------------------
  "Plug 'lucasprag/simpleblack'
  "Plug 'rktjmp/lush.nvim'
  "Plug 'metalelf0/jellybeans-nvim'
  "Plug 'NLKNguyen/papercolor-theme'
  "Plug 'catppuccin/nvim', {'as': 'catppuccin'}
  Plug 'jacoborus/tender.vim'

  "---------------------
  " NeoVIM treesplitter plugins
  "---------------------
  " Install treesplitter language plugins
  " :TSInstall <lang>
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  "---------------------
  " NeoVim PopUp window behavior
  "---------------------
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }

  "---------------------
  " Telescope - Fuzzy Find files (ff)
  "---------------------
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'

  "---------------------
  " Buffer Navigation and Styling
  "---------------------
  " buffer status line
  Plug 'nvim-lualine/lualine.nvim'
  " EasyMotion like jump to in file
  Plug 'phaazon/hop.nvim'

  "---------------------
  " Language tools
  "---------------------
  "Plug 'sheerun/vim-polyglot'
  "Plug 'fatih/vim-go'
  "Plug 'crispgm/nvim-go'
  "Plug 'jpmcb/nvim-go'
  Plug 'ray-x/go.nvim'
  Plug 'simrat39/rust-tools.nvim'

  " https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  "Plug 'hrsh7th/cmp-path'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  "Plug 'mfussenegger/nvim-lint'

  " Other languages tools
  "Plug 'lepture/vim-jinja'
  Plug 'jasdel/vim-smithy'

  " Debugging
  " https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
  Plug 'mfussenegger/nvim-dap'
  Plug 'leoluz/nvim-dap-go'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'nvim-telescope/telescope-dap.nvim'

  "---------------------
  " Grammer and spelling
  "---------------------
  "Plug 'rhysd/vim-grammarous'
  " With spell checking:
  "Plug 'lewis6991/spellsitter.nvim'
  "Plug 'f3fora/cmp-spell'
  " Alternative spell checker to consider,
  " - https://github.com/dvdsk/prosesitter.nvim

  "---------------------
  " Git Utilities
  "---------------------
  Plug 'airblade/vim-gitgutter'

  " Git browsing utilities
  " https://github.com/tpope/vim-fugitive
  " :GBrowse - open in browser (Github), optional line selection
  Plug 'tpope/vim-fugitive'
  " Allows opening GBrowse in GitHub, extends Fugitive
  " https://github.com/tpope/vim-rhubarb/
  Plug 'tpope/vim-rhubarb'

  "---------------------
  " Start page
  "---------------------
  " https://github.com/mhinz/vim-startify/wiki/Plugin-features-in-detail
  Plug 'mhinz/vim-startify'

call plug#end()

"------------------------------------------
" Color Scheme configuration
"------------------------------------------
if (has("termguicolors"))
 set termguicolors
endif

colorscheme tender
" Fixup comment color for better read-ability
hi Comment guifg=#aaaaaa ctermfg=242 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" Fixup number line highlight
hi LineNr guifg=grey ctermfg=grey guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

lua require('my-treesitter')

:lua << EOF
require('lualine').setup{
  options = {
    theme = 'auto'
  }
}
EOF

"------------------------------------------
" Setup LSP
"------------------------------------------
lua require('hop').setup()
lua require('my-lsp-config')

au BufWritePost go require('lint').try_lint()
au BufWritePost go require('lint').try_lint()

set completeopt=menu,menuone,noselect
"set completeopt=menuone,noselect

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
"set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
"set shortmess+=c

" Inlay hints for whole file
nnoremap <Leader>T :lua require'lsp_extensions'.inlay_hints()

"------------------------------------------
" Per file settings
"------------------------------------------
"autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

"------------------------------------------
" LSP based Code navigation shortcuts
"------------------------------------------
" TODO Change these to be filetype specific?
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" rust-analyzer does not yet support goto declaration
" re-mapped `gd` to definition
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"
" Support for code actions
"nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Trigger completion with <tab>
" found in :help completion
" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
"imap <Tab> <Plug>(completion_smart_tab)
"imap <S-Tab> <Plug>(completion_smart_s_tab)

"------------------------------------------
" Diagnostic Analysis and Popup
"------------------------------------------
" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
"set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
"set updatetime=100
" Show diagnostic popup on cursor hover
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
"nnoremap <leader>do <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
"nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
"
" Goto previous/next diagnostic warning/error
"nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>


"------------------------------------------
" Spelling options
"------------------------------------------
" Set languages to check spelling on 'cjk' means ignore east asian characters
" in spell check.
set spelllang=en_us,cjk
set spelloptions=camel
set spell

" Enable spelling check via toggle
"nnoremap <silent> <F11> :set spell!<cr>
"inoremap <silent> <F11> <C-O>:set spell!<cr>

"------------------------------------------
" Telescope Configuration for fuzzy find
"------------------------------------------
lua require("my-telescope")
nnoremap <C-_> <cmd>lua require("my-telescope").curr_buf() <cr>
"
" " Setup Telescope key bindings
" " * https://github.com/nvim-telescope/telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>

"------------------------------------------
" Debugging configuration
"------------------------------------------
lua require("my-debugging")

"ts=2 sts=2 sw=2 et
