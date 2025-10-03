local lspconfig = require("lspconfig")
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  rubocop = {
    cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
  },

  ruby_lsp = {
    cmd = { 'bundle', 'exec', 'ruby-lsp' },
    init_options = {
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false,
        },
      },
    }
  },

  solargraph = false,
}

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = servers,
    },
  },
}
