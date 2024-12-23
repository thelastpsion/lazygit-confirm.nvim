local M = {}

-- M.setup = function()
-- 	vim.print("lazygit-confirm loaded")
-- end

M.confirm = function()
  local unsaved_table = {}
  local choice = 1
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value("modified", { buf = buf_id }) then
      table.insert(unsaved_table, string.format("%3d", buf_id) .. ": " .. vim.api.nvim_buf_get_name(buf_id))
    end
  end
  if #unsaved_table ~= 0 then
    choice = vim.fn.confirm(
      "There are unsaved buffers:\n\n" .. table.concat(unsaved_table, "\n") .. "\n\nDo you still want to run lazygit?",
      "&Yes\n&No\nShow &Buffers",
      2
    )
  end
  if choice == 1 then
    Snacks.lazygit()
  elseif choice == 3 then
    vim.cmd([[FzfLua buffers sort_mru=true sort_lastused=true query='+']]) -- HACK: What happens when files contain `+`?
  end
end

return M
