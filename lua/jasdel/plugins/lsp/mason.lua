return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "gopls",
        "lua_ls",
        "rust_analyzer",
        "helm_ls",
        "protols",

        -- https://github.com/blopker/codebook
        -- $ cargo install codebook-lsp
        -- ~/.codebook.toml
        "codebook",

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#golangci_lint_ls
        -- orig $ go install github.com/nametake/golangci-lint-langserver@latest
        -- fork $ go install github.com/jasdel/golangci-lint-langserver@latest
        -- $ go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
        -- "golangci_lint_ls",

        --"pyright",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- https://github.com/JohnnyMorganz/StyLua
        -- $ cargo install stylua
        "stylua", -- lua formatter

        -- https://github.com/tekumara/typos-lsp
        -- $ brew install typos-lsp
        --"typos-lsp",

        --"prettier", -- ts prettier formatter
        --"isort", -- python formatter
        --"black", -- python formatter
        --"pylint",

        -- Go
        "delve", -- Go debugger

        -- https://github.com/mvdan/gofumpt
        -- $ go install mvdan.cc/gofumpt@latest
        "gofumpt",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
}
