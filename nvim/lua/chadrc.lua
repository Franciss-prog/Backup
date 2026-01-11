-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.base46 = {
  theme = "chadwal",
  transparency = true,

  lsp = {
    signature = true, -- show function signature help
    semantic_tokens = true, -- better highlighting
  },

  -- Enable inline diagnostics (error text right under the line)
  vim.diagnostic.config {
    virtual_text = true, -- shows error text next to the line
    signs = true, -- gutter signs (like the E)
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
    order = { "buffers", "tabs" },
  },
}

return M
