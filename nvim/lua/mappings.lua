require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-a>", "ggVG", { desc = "select all text" })
map("v", "<C-c>", '"+y', { desc = "copy selection to clipboard" })
map("n", "<C-d>", "yyp", { desc = "duplicate line below" })
map("n", "z", "u", { desc = "undo" })
map("n", "<CR>", "i", { desc = "insert mode with Enter" })

local nomap = vim.keymap.del

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>q", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })

-- Close current buffer with Ctrl+W (like VS Code tab close)
map("n", "<leader>w", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close current buffer" })

-- Optional: also make it work in insert mode (very handy!)
map("i", "<C-w>", "<ESC>:lua require('nvchad.tabufline').close_buffer()<CR>", { desc = "Close buffer from insert" })

-- → Left window: new empty buffer
map("n", "<leader>sv", function()
  vim.cmd "vsplit" -- create new window on the right
  vim.cmd "enew" -- make the OLD (left) window empty
  vim.cmd "wincmd l" -- move cursor to the new (right) window
end, { desc = "Vertical split: current file in new right window" })

-- Horizontal split below
-- → Bottom window: your current file (cursor moves here)
-- → Top window: new empty buffer
map("n", "<leader>sh", function()
  vim.cmd "split" -- create new window below
  vim.cmd "enew" -- make the OLD (top) window empty
  vim.cmd "wincmd j" -- move cursor to the new (bottom) window
end, { desc = "Horizontal split: current file in new bottom window" })
