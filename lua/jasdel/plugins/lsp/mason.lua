return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "gopls",
        "lua_ls",
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
        --"prettier", -- ts prettier formatter
        "stylua", -- lua formatter
        --"isort", -- python formatter
        --"black", -- python formatter
        --"pylint",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
}
