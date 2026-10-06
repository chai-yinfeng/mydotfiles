return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    cmd = { 'RenderMarkdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'mini.icons' },
    opts = {
      code = { sign = false, width = 'block', right_pad = 1 },
      heading = { sign = false, icons = {} },
    },
    config = function(_, opts)
      local markdown = require 'render-markdown'
      markdown.setup(opts)
      Snacks.toggle({
        name = 'Render Markdown',
        get = markdown.get,
        set = markdown.set,
      }):map '<leader>um'
    end,
  },
}
