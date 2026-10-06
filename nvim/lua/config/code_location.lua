local M = {}

function M.parse(reference)
  reference = vim.trim(reference)
  reference = reference:match '^%[.-%]%((.*)%)$' or reference
  reference = reference:match '^`(.*)`$' or reference
  -- Markdown prose may escape underscores in otherwise literal file paths.
  reference = reference:gsub('\\_', '_')
  local file, line, column = reference:match '^(.-):(%d+):(%d+)$'
  if not file then
    file, line = reference:match '^(.-):(%d+)%-%d+$'
  end
  if not file then
    file, line = reference:match '^(.-):(%d+)$'
  end
  if not file then
    file, line = reference:match '^(.-)#L(%d+)%-L%d+$'
  end
  if not file then
    file, line = reference:match '^(.-)#L(%d+)$'
  end
  file = file or reference
  if file:match '^%a[%w+.-]*://' then return nil, 'Use a local file path; web URLs are not local code locations' end
  if file:sub(1, 2) == '~/' then file = vim.env.HOME .. file:sub(2) end
  if file == '' or vim.fn.filereadable(file) ~= 1 then return nil, 'File not found (relative paths use Neovim cwd): ' .. file end
  return { file = vim.fn.fnamemodify(file, ':p'), line = math.max(1, tonumber(line) or 1), column = math.max(1, tonumber(column) or 1) }
end

function M.open(reference)
  local location, err = M.parse(reference)
  if not location then
    vim.notify(err, vim.log.levels.ERROR)
    return false
  end
  vim.cmd.edit(vim.fn.fnameescape(location.file))
  local line = math.min(location.line, vim.api.nvim_buf_line_count(0))
  local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ''
  vim.api.nvim_win_set_cursor(0, { line, math.min(location.column - 1, #text) })
  vim.cmd 'normal! zvzz'
  return true
end

function M.prompt()
  vim.ui.input({ prompt = 'Code location (path:line[:column]): ' }, function(reference)
    if reference and reference ~= '' then M.open(reference) end
  end)
end

function M.setup()
  vim.api.nvim_create_user_command('CodeLocation', function(opts)
    local reference = opts.args ~= '' and opts.args or vim.env.NVIM_CODE_LOCATION
    if reference and reference ~= '' then
      M.open(reference)
      vim.env.NVIM_CODE_LOCATION = nil
    else
      M.prompt()
    end
  end, { nargs = '*', complete = 'file', desc = 'Open a local path:line[:column] reference' })
end

return M
