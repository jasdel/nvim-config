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
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'nvim-lua/completion-nvim'

  Plug 'fatih/vim-go'
  " Rust With NeoVim
  " https://sharksforarms.dev/posts/neovim-rust/
  Plug 'rust-lang/rust.vim'
  Plug 'lepture/vim-jinja'
  Plug 'jasdel/vim-smithy'
  
  Plug 'airblade/vim-gitgutter'

  " Code completion
  "Plug 'hrsh7th/nvim-compe'
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


syntax enable
filetype plugin indent on

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
"set completeopt=menuone,noselect
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

"let g:compe = {}
"let g:compe.enabled = v:true
"let g:compe.autocomplete = v:true
"let g:compe.debug = v:false
"let g:compe.min_length = 1
"let g:compe.preselect = 'enable'
"let g:compe.throttle_time = 80
"let g:compe.source_timeout = 200
"let g:compe.incomplete_delay = 400
"let g:compe.max_abbr_width = 100
"let g:compe.max_kind_width = 100
"let g:compe.max_menu_width = 100
"let g:compe.documentation = v:true
"
"let g:compe.source = {}
"let g:compe.source.path = v:true
"let g:compe.source.buffer = v:true
"let g:compe.source.calc = v:true
"let g:compe.source.nvim_lsp = v:true
"let g:compe.source.nvim_lua = v:true
""let g:compe.source.vsnip = v:true
""let g:compe.source.ultisnips = v:true

"lua << EOF
"local capabilities = vim.lsp.protocol.make_client_capabilities()
"capabilities.textDocument.completion.completionItem.snippetSupport = true
"capabilities.textDocument.completion.completionItem.resolveSupport = {
"  properties = {
"    'documentation',
"    'detail',
"    'additionalTextEdits',
"  }
"}
"
"require'lspconfig'.rust_analyzer.setup {
"  capabilities = capabilities,
"}
"EOF

"inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <CR>      compe#confirm('<CR>')
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


"------------------------------------------
" Setup language server (LSP)
"------------------------------------------
"lua << EOF
"require'lspconfig'.gopls.setup{}
"require'lspconfig'.rust_analyzer.setup{}
"EOF

" Setup key bindings for lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

---- Use an on_attach function to only map the following keys 
---- after the language server attaches to the current buffer
--local on_attach = function(client, bufnr)
--  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--  --Enable completion triggered by <c-x><c-o>
--  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--  -- Mappings.
--  -- local opts = { noremap=true, silent=true }
--
--  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  --buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--  --buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--
--end

-- Installing rust analzer
-- https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
nvim_lsp.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

nvim_lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

EOF

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" rust-analyzer does not yet support goto declaration
" re-mapped `gd` to definition
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Trigger completion with <tab>
" found in :help completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

"------------------------------------------
" Source plugins configurations
"------------------------------------------
source ~/.config/nvim/config/vim-go.vim
