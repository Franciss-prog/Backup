return {
  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "Saghen/blink.cmp",
    enabled = false, -- This disables it completely
  },

  -- LSP config (using new vim.lsp.config style)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Treesitter with your languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "svelte",
        "python",
        "rust",
        "go",
        "c",
        "cpp",
        "json",
        "yaml",
        "dockerfile",
        "bash",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- nvim-cmp + sources (enabled and ready for Codeium)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require "configs.cmp"
    end,
  },

  -- Tailwind CSS tools + colorizer for cmp
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      document_color = {
        enabled = true,
        kind = "inline",
        inline_symbol = "󰝤 ",
        debounce = 200,
      },
      conceal = { enabled = false },
      extension = { queries = { "svelte" } },
    },
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = true,
  },

  -- TypeScript tools (inlays, better organization, etc.)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
      settings = {
        tsserver_plugins = {}, -- empty unless you add extras
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  -- Friendly snippets (VSCode style)
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Nvim Tree on the right + show dotfiles
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { side = "right" },
      filters = { dotfiles = false }, -- changed to false to SHOW dotfiles like .env
      actions = {
        open_file = {
          quit_on_open = true,
          resize_window = true,
        },
      },
    },
  },

  -- Auto-save (silent)
  {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require("auto-save").setup {
        debounce_delay = 135,
        execution_message = {
          message = function()
            return ""
          end,
        },
      }
    end,
  },

  -- Telescope with custom copy-to-clipboard mapping
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"

      return {
        defaults = {
          mappings = {
            i = {
              ["<C-c>"] = function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                if entry and entry.value then
                  vim.fn.setreg("+", entry.value)
                  print("Copied to clipboard: " .. entry.value)
                else
                  print "No entry selected"
                end
                actions.close(prompt_bufnr)
              end,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
          },
        },
      }
    end,
  },
}
