local M = {}

M.setup = function(opts)
  vim.print("lazygit-confirm loaded")
  M.show_saveall = opts.show_saveall or false
  M.show_saveall_noconfirm = opts.show_saveall_noconfirm or false
end

M.confirm = function()
  local unsaved_table = {}
  local choice = 1
  local saveall = ""
  local run_lazygit = false
  if M.show_saveall == true or M.show_saveall_noconfirm == true then
    saveall = "\nSave &All and Continue"
  end
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value("modified", { buf = buf_id }) then
      table.insert(unsaved_table, string.format("%3d", buf_id) .. ": " .. vim.api.nvim_buf_get_name(buf_id))
    end
  end
  if #unsaved_table ~= 0 then
    choice = vim.fn.confirm(
      "There are unsaved buffers:\n\n" .. table.concat(unsaved_table, "\n") .. "\n\nDo you still want to run lazygit?",
      "&Yes\n&No\nShow &Buffers" .. saveall,
      2
    )
  end
  if choice == 1 then
    run_lazygit = true
  elseif choice == 3 then
    vim.cmd([[FzfLua buffers sort_mru=true sort_lastused=true query='+']]) -- HACK: What happens when files contain `+`?
  elseif choice == 4 then
    local confirm = 2
    if M.show_saveall_noconfirm == false then
      confirm = vim.fn.confirm("Are you sure you want to save all buffers?", "&Yes\n&No", 2)
    end
    if confirm == 1 or M.show_saveall_noconfirm == true then
      vim.cmd("wall")
      vim.print("All buffers have been saved.")
      run_lazygit = true
    end
  end

  if run_lazygit == true then
    Snacks.lazygit()
  end
end

return M
