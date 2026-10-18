return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'mason-org/mason.nvim' },
  },
  {
    'mason-org/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'tree-sitter-cli' })
    end,
  },
}
