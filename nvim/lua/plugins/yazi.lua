return {
  {
    'folke/snacks.nvim',
    keys = {
      {
        '<leader>e',
        function() Snacks.terminal({ 'yazi' }, { cwd = LazyVim.root() }) end,
        desc = 'Yazi (project root)',
      },
    },
  },
}
