-- Keep C/C++ formatting manual, matching the previous editor behavior.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function(event) vim.b[event.buf].autoformat = false end,
})
