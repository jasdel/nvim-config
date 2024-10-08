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
call plug#begin("~/.config/nvim/plugged")
  "---------------------
  " Color Schemes
  "---------------------
  "Plug 'lucasprag/simpleblack'
  "Plug 'rktjmp/lush.nvim'
  "Plug 'metalelf0/jellybeans-nvim'
  "Plug 'NLKNguyen/papercolor-theme'
  Plug 'jacoborus/tender.vim'

  "---------------------
  " ** NeoVIM treesplitter plugins **
  "---------------------
  " Install treesplitter language plugins
  " :TSInstall <lang>
  "
  " Toggle treesplitter behavior
  " :TSPlaygroundToggle
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  "Plug 'nvim-treesitter/playground'
  " Spell Checking:
  "Plug 'lewis6991/spellsitter.nvim'
  "Plug 'f3fora/cmp-spell'
  " Alternative spell checker to consider,
  " - https://github.com/dvdsk/prosesitter.nvim

  "---------------------
  " Telescope - Find files (ff)
  "---------------------
  " dependencies
  " Plug 'nvim-lua/popup.nvim'
  " Plug 'nvim-lua/plenary.nvim'
  " " telescope
  " Plug 'nvim-telescope/telescope.nvim'

  "---------------------
  " Language tools
  "---------------------
  " https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  Plug 'neovim/nvim-lspconfig'    " Collection of configurations for built-in LSP client
  Plug 'hrsh7th/nvim-cmp'         " Autocompletion plugin
  Plug 'hrsh7th/cmp-nvim-lsp'     " LSP source for nvim-cmp
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
  Plug 'L3MON4D3/LuaSnip'         " Snippets plugin

  " https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
  "Plug 'nvim-lua/plenary.nvim'
  "Plug 'mfussenegger/nvim-dap'
  "Plug 'rcarriga/nvim-dap-ui'
  "Plug 'mfussenegger/nvim-dap'
  "Plug 'leoluz/nvim-dap-go'
  
  " Go
  Plug 'fatih/vim-go'
  
  " Rust With NeoVim
  " https://sharksforarms.dev/posts/neovim-rust/
  "Plug 'rust-lang/rust.vim'
  Plug 'simrat39/rust-tools.nvim'

  " Other languages tools
  Plug 'lepture/vim-jinja'
  Plug 'jasdel/vim-smithy'

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

  " Start page
  " https://github.com/mhinz/vim-startify/wiki/Plugin-features-in-detail
  Plug 'mhinz/vim-startify'

  ""---------------------
  "" Fuzz search and other utilities - Ctrl + P
  ""---------------------
  "" https://github.com/junegunn/fzf.vim
  "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  "Plug 'junegunn/fzf.vim'
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

"" Setup Telescope key bindings
"" * https://github.com/nvim-telescope/telescope.nvim
"nnoremap <leader>ff <cmd>Telescope find_files<cr>

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
"colorscheme simpleblack
"colorscheme jellybeans-nvim
colorscheme tender
hi Comment guifg=#aaaaaa ctermfg=242 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

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
"set completeopt=menuone,noinsert,noselect
"set completeopt=menuone,noselect

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

"------------------------------------------
" Setup language server (LSP)
"------------------------------------------
" Setup key bindings for lspconfig

lua << EOF
--------------------------------
-- TreeSitter
--------------------------------
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {"go", "typescript", "rust", "java", "json", "vim", "lua"},
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {"go"},
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Spell checking configuration
-- https://github.com/lewis6991/spellsitter.nvim
--require('spellsitter').setup{
--  -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
--  enable = true,
--
--  -- -- Highlight to use for bad spellings
--  -- hl = 'SpellBad',
--
--  -- -- Spellchecker to use. values:
--  -- -- * vimfn: built-in spell checker using vim.fn.spellbadword()
--  -- -- * ffi: built-in spell checker using the FFI to access the
--  -- --   internal spell_check() function
--  -- spellchecker = 'vimfn',
--}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

local rustToolsOpts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        RustHoverActions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attaches to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(rustToolsOpts)

-- TODO custom on_attach for keymap bindings
-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'rust_analyzer', 'ts_ls' }
--local servers = { 'gopls', 'ts_ls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Installing rust analzer
-- https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
-- lspconfig.rust_analyzer.setup{}

-- Installing Go LSP
lspconfig.gopls.setup{}

-- Installing Typescript LSP
-- https://github.com/neovim/nvim-lspconfig/blob/36d9109dc402eb4a37e55b0814cd8d4714f9a3a4/lua/lspconfig/tsserver.lua#L35-L40
-- https://github.com/microsoft/TypeScript/issues/39459#issuecomment-696179304
-- https://github.com/neovim/nvim-lspconfig/issues/250
-- https://github.com/theia-ide/typescript-language-server
-- lspconfig.tsserver.setup{}

-- Debugging
--require("dapui").setup()
--
--local dap = require('dap')
---- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
--dap.adapters.lldb = {
--  type = 'executable',
--  command = '/usr/bin/lldb-vscode-11', -- adjust as needed
--  name = "lldb"
--}
--
---- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Go
--dap.adapters.go = function(callback, config)
--  local stdout = vim.loop.new_pipe(false)
--  local handle
--  local pid_or_err
--  local port = 38697
--  local opts = {
--    stdio = {nil, stdout},
--    args = {"dap", "-l", "127.0.0.1:" .. port},
--    detached = true
--  }
--  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
--    stdout:close()
--    handle:close()
--    if code ~= 0 then
--      print('dlv exited with code', code)
--    end
--  end)
--  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
--  stdout:read_start(function(err, chunk)
--    assert(not err, err)
--    if chunk then
--      vim.schedule(function()
--        require('dap.repl').append(chunk)
--      end)
--    end
--  end)
--  -- Wait for delve to start
--  vim.defer_fn(
--    function()
--      callback({type = "server", host = "127.0.0.1", port = port})
--    end,
--    100)
--end
---- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
--dap.configurations.go = {
--  {
--    type = "go",
--    name = "Debug",
--    request = "launch",
--    program = "${file}"
--  },
--  {
--    type = "go",
--    name = "Debug test", -- configuration for debugging test files
--    request = "launch",
--    mode = "test",
--    program = "${file}"
--  },
--  -- works with go.mod packages and sub packages 
--  {
--    type = "go",
--    name = "Debug test (go.mod)",
--    request = "launch",
--    mode = "test",
--    program = "./${relativeFileDirname}"
--  } 
--}
--
---- Open and close DAP UI automatically
--local dapui = require("dapui")
--dap.listeners.after.event_initialized["dapui_config"] = function()
--  dapui.open()
--end
--dap.listeners.before.event_terminated["dapui_config"] = function()
--  dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"] = function()
--  dapui.close()
--end

EOF

" Inlay hints for whole file
"nnoremap <Leader>T :lua require'lsp_extensions'.inlay_hints()

"------------------------------------------
" Per file settings
"------------------------------------------
autocmd BufWritePre *.rs :RustFmt

"------------------------------------------
" LSP based Code navigation shortcuts
"------------------------------------------
" TODO Change these to be filetype specific?
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

" Support for code actions
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

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
nnoremap <leader>do <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

"------------------------------------------
" Source plugins configurations
"------------------------------------------
source ~/.config/nvim/config/vim-go.vim

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
nnoremap <leader>nn :set number<CR>:set relativenumber<CR>

"------------------------------------------
" Debugging configuration
"------------------------------------------
"lua require('dap-go').setup()

"ts=2 sts=2 sw=2 et
