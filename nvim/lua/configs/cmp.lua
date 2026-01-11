-- ~/.config/nvim/lua/configs/cmp.lua
-- Clean nvim-cmp config without Codeium

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false }, -- Only confirm if explicitly selected
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- Simple menu labels
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]

      -- Optional: add icons if lspkind is available
      local ok, lspkind = pcall(require, "lspkind")
      if ok then
        return lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
        }(entry, vim_item)
      end
      return vim_item
    end,
  },

  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },

  experimental = {
    ghost_text = true,
  },
}
