local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

function OpenFloatingWindow(opts)
  opts = opts or {}

  -- Get current Neovim UI size
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(opts.width or (ui.width * 0.8))
  local height = math.floor(opts.height or (ui.height * 0.8))

  -- Calculate centered position
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  -- Create a buffer
  local buf
  if type(opts.buf) == "number" and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(true, false) -- listed, non-scratch buffer
  end

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

 -- Set terminal mode keymap
  vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<C-\\><C-n>', {noremap = true})

  return {buf = buf, win = win}
end 

-- Example usage:
-- Open a floating window with default size

vim.api.nvim_create_user_command("Floaterminal", function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    local result = OpenFloatingWindow({ buf = state.floating.buf })
    state.floating.buf = result.buf
    state.floating.win = result.win

    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.fn.termopen("powershell")
    end

  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end, {})
