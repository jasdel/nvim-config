"------------------------------------------
" Installing NeoVIM
"------------------------------------------
" * https://github.com/neovim/neovim/wiki/Installing-Neovim
"
" NeoVim 0.5 Setup guides
" * https://medium.com/life-at-moka/step-up-your-game-with-neovim-62ba814166d7
" * https://crispgm.com/page/neovim-is-overpowering.html
call plug#begin("~/.config/nvim/plugged")
  " Color Schemes
  Plug 'lucasprag/simpleblack'

  " ** NeoVIM treesplitter plugins **
  " Install treesplitter language plugins
  " :TSInstall <lang>
  "
  " Toggle treesplitter behavior
  " :TSPlaygroundToggle
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'

  " dependencies
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'

  " Language tools
  Plug 'neovim/nvim-lspconfig'
  Plug 'fatih/vim-go'
  "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'rust-lang/rust.vim'
  Plug 'lepture/vim-jinja'
  Plug 'jasdel/vim-smithy'
  
  Plug 'airblade/vim-gitgutter'

  " Code completion
  Plug 'hrsh7th/nvim-compe'
  "if has('nvim')
  "  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "else
  "  Plug 'Shougo/deoplete.nvim'
  "  Plug 'roxma/nvim-yarp'
  "  Plug 'roxma/vim-hug-neovim-rpc'
  "endif
  "let g:deoplete#enable_at_startup = 1

  " Git utilities
  Plug 'airblade/vim-gitgutter'

  " Start page
  " https://github.com/mhinz/vim-startify/wiki/Plugin-features-in-detail
  Plug 'mhinz/vim-startify'
call plug#end()

" Enable status bar
set laststatus=2
"set wrap linebreak
set shiftwidth=4 tabstop=4

"------------------------------------------
" Key mapping and basic configuration
"------------------------------------------
let mapleader=","

" Add jj as escape trigger
inoremap jj <esc>

" Setup Telescope key bindings
" * https://github.com/nvim-telescope/telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>

" Enable line numbering
set number relativenumber
set cursorline

"------------------------------------------
" Color Scheme configuration
"------------------------------------------
if (has("termguicolors"))
 set termguicolors
endif
"set background=dark
colorscheme simpleblack
" Vim color detection
" https://stackoverflow.com/questions/15375992/
"if $COLORTERM == "screen"
"set t_Co=256
"endif

if $ITERM_PROFILE == "Light"
    hi LineNr ctermfg=black
    hi LineNr guifg=black
    hi CursorLineNr ctermfg=blue
    hi CursorLineNr guifg=blue
else
    hi LineNr ctermfg=grey
    hi LineNr guifg=grey
    hi CursorLineNr ctermfg=yellow
    hi CursorLineNr guifg=yellow
endif

"------------------------------------------
" Setup completion opts for nvim-compe
"------------------------------------------
"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
"let g:compe.source.vsnip = v:true
"let g:compe.source.ultisnips = v:true

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
}
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


"------------------------------------------
" Setup language server (LSP)
"------------------------------------------
lua << EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.rust_analyzer.setup{}
EOF

" Setup key bindings for lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer", "gopls" } -- "tsserver","pyright",  
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

"------------------------------------------
" Source plugins configurations
"------------------------------------------
source ~/.config/nvim/config/vim-go.vim
