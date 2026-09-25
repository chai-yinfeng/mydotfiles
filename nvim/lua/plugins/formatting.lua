return {
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft or {}, {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        go = { 'goimports', 'gofumpt' },
        rust = { 'rustfmt' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      })
    end,
  },
  {
    'mason-org/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'black', 'isort', 'clang-format' })
    end,
  },
}
