return {
  "willothy/flatten.nvim",
  opts = {
    window = {
      open = "alternate",
      focus = "first",
    },
    hooks = {
      post_open = function(opts)
        vim.api.nvim_set_current_win(opts.winnr)
      end,
    },
  },
  -- Ensures it intercept commands early
  lazy = false,
  priority = 1001,
}
