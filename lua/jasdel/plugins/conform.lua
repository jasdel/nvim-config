return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        ['go'] = { 'goimports', 'gofumpt' },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        }
      },
      format_on_save = {
        lsp_format = "first",
      }
    })
  end,
}
