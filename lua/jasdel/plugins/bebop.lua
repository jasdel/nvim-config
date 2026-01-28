return {
  "ATTron/bebop.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("bebop").setup()
    vim.cmd([[colorscheme bebop]])
  end,
}
