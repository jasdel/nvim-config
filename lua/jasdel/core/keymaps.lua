vim.g.mapleader = ","

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Split windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize windows with arrow keys
keymap.set("n", "<Left>", ":vertical resize -5<CR>")
keymap.set("n", "<Right>", ":vertical resize +5<CR>")

-- Tab Windows
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- command window specific mapping
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "*",
  callback = function()
    -- nowait = true removes the delay by not waiting for longer q... sequences
    vim.keymap.set("n", "q", "<CMD>quit<CR>", { buffer = true, nowait = true })
  end,
})
-- Move command-line window to <leader>q
vim.keymap.set("n", "<leader>q", "q:", { desc = "Open command-line window" })
-- Disable the original q:
vim.keymap.set("n", "q:", "<nop>")

-- Copy absolute path
vim.keymap.set("n", "<Leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Absolute path copied to clipboard")
end, { desc = "Copy absolute path" })

-- Copy CWD relative path
vim.keymap.set("n", "<Leader>cr", function()
  vim.fn.setreg("+", vim.fn.expand("%:."))
  print("Relative path copied to clipboard")
end, { desc = "Copy relative path" })
