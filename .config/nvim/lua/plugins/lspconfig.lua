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
    -- See: https://docs.rubocop.org/rubocop/usage/lsp.html
    cmd = { os.getenv("HOME") .. "/.gem/ruby/" .. os.getenv("RUBY_VERSION") .. "/bin/rubocop", "--lsp" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
  },

  solargraph = {
    cmd = { os.getenv("HOME") .. "/.gem/ruby/" .. os.getenv("RUBY_VERSION") .. "/bin/solargraph", "stdio" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
    init_options = {
      formatting = false,
    },
    settings = {
      solargraph = {
        autoformat = false,
        formatting = false,
        completion = true,
        diagnostic = false,
        folding = true,
        references = true,
        rename = true,
        symbols = true,
      },
    },
  },
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
