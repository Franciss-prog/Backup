-- ~/.config/nvim/lua/custom/configs/lspconfig.lua

-- Load NvChad's shared on_attach + capabilities (still works great!)

-- Your list of LSP servers (same as before)
local servers = {
  "html",
  "cssls",
  "ts_ls", -- TypeScript / JS / React
  "svelte",
  "pyright", -- Python
  "gopls", -- Go
  "clangd", -- C / C++
  "rust_analyzer", -- Rust
  "lua_ls", -- Lua (Neovim-friendly)
  "intelephense",
  "bash_ls",
}

-- Enable all servers with NvChad's defaults
vim.lsp.enable(servers)

-- Optional: Add custom settings for specific servers (examples)
-- These override/merge with defaults from nvim-lspconfig

-- Lua: Make it recognize 'vim' global + disable telemetry
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.config("bashls", { -- ← Change the name here too
  settings = {
    bashIde = {
      -- Add any custom settings here (most users need none)
      -- Examples:
      highlightParsingErrors = true,
      includeAllWorkspaceSymbols = true,
      shellcheckArguments = "--exclude=SC2034,SC1090",
      explainshellEndpoint = "", -- Disable or set a custom endpoint
      backgroundAnalysisMaxFiles = 0, -- Unlimited background analysis
    },
  },
})
-- Rust: Add some common rust-analyzer settings
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      imports = { granularity = { group = "module" } },
    },
  },
})

-- Python: Extra pyright settings if you want strict type checking
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = { typeCheckingMode = "basic" }, -- or "strict"
    },
  },
})

-- Add more custom configs here as needed (e.g., for intelephense PHP licensing)
