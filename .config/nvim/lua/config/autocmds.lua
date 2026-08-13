-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("RecordingEnter", {
  group = augroup("macro-notify", { clear = true }),
  callback = function()
    vim.notify("Recording macro to register @" .. vim.fn.reg_recording(), vim.log.levels.INFO)
  end,
})

autocmd("RecordingLeave", {
  group = augroup("macro-notify", { clear = false }),
  callback = function()
    vim.notify("Macro recording stopped", vim.log.levels.INFO)
  end,
})
