-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--

vim.keymap.set("n", "<C-l>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader><leader>r", ":e ~/.config/nvim<CR>", { silent = true })
vim.keymap.set("n", "<leader>fn", ':let @*=expand("%")<CR>', { silent = true })


vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope').extensions.live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep (Args)' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })

-- Move selected lines up or down in Visual mode
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

-- Move current line up or down in Normal mode
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true})
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- Highlight accross open panes
vim.keymap.set("n", "*", function()
  -- 1. Get the word under the cursor
  local word = vim.fn.expand("<cword>")
  if word == "" then return end

  -- 2. Format the strict pattern
  local pattern = "\\<" .. word .. "\\>"
  local current_search = vim.fn.getreg("/")

  -- 3. If already searching this word, jump to NEXT match only in the active pane
  if current_search == pattern and vim.v.hlsearch == 1 then
    vim.api.nvim_echo({{""}}, false, {}) -- clear message bar
    
    local status, _ = pcall(vim.cmd, "normal! nzz")
    if not status then
      -- Fallback if search hit bottom: Clean literal execution block
      vim.api.nvim_echo({{"Search hit BOTTOM, continuing at TOP", "WarningMsg"}}, true, {})
      vim.cmd("normal! gg")
      vim.fn.search(pattern, "W")
      vim.cmd("normal! zz")
    end
    return
  end

  -- 4. FIRST PRESS: Setup search registers globally
  vim.fn.setreg("/", pattern)
  vim.fn.histadd("search", pattern)
  vim.v.hlsearch = 1

  -- 5. Loop through and scroll ALL visible split panes to their first match
  local current_win = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local win_config = vim.api.nvim_win_get_config(win)
    if win_config.relative == "" then
      vim.api.nvim_win_call(win, function()
        local start_pos = vim.api.nvim_win_get_cursor(win)
        vim.api.nvim_win_set_cursor(win, {1, 0})
        
        local match_line = vim.fn.search(pattern, "W")
        if match_line > 0 then
          vim.cmd("normal! zz")
        else
          vim.api.nvim_win_set_cursor(win, start_pos)
        end
      end)
    end
  end

  -- Retain focus on your original active window split
  vim.api.nvim_set_current_win(current_win)
end, { desc = "Smart cross-split highlight (1st press) and local next match (2nd+ press)" })


-- Shell command output
vim.keymap.set("n", "<leader>!", function()
  vim.ui.input({ prompt = "Shell command: " }, function(input)
    if not input or input == "" then return end

    -- Name of the Emacs-style dedicated output buffer
    local buf_name = "*Shell Command Output*"
    local buf = vim.fn.bufnr(buf_name)

    -- Create the buffer if it does not exist
    if buf == -1 then
      buf = vim.api.nvim_create_buf(false, true) -- scratch buffer
      vim.api.nvim_buf_set_name(buf, buf_name)
    end

    -- Check if the buffer is currently visible in a window
    local win = vim.fn.bufwinid(buf)
    if win == -1 then
      vim.cmd("botright split")
      win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(win, buf)
      vim.api.nvim_win_set_height(win, 10)
    end

    -- Set buffer configurations
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "hide"
    vim.bo[buf].swapfile = false

    -- Clear previous content completely
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running: " .. input, "" })

    -- Helper function to append text line-by-line as it streams in
    local function append_data(_, data)
      if data then
        vim.schedule(function()
          -- Filter out terminal carriage returns if necessary
          for i, line in ipairs(data) do
            data[i] = line:gsub("\r", "")
          end
          
          -- Safely append lines to the end of the buffer
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
          
          -- Automatically scroll the window to track live output
          if vim.api.nvim_win_is_valid(win) then
            local line_count = vim.api.nvim_buf_line_count(buf)
            vim.api.nvim_win_set_cursor(win, { line_count, 0 })
          end
        end)
      end
    end

    -- Execute the command using a pseudo-terminal (pty) to disable system buffering
    vim.fn.jobstart(input, {
      pty = true, -- Crucial: tricks programs into instantly flushing stdout line-by-line
      on_stdout = append_data,
      on_stderr = append_data,
      on_exit = function(_, exit_code)
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "[Process exited with code " .. exit_code .. "]" })
        end)
      end,
    })
  end)
end, { desc = "Emacs live shell-command (M-!)" })
