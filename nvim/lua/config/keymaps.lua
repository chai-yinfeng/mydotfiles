local location = require 'config.code_location'

vim.keymap.set('n', '<leader>fL', location.prompt, { desc = 'Open Code Location' })
