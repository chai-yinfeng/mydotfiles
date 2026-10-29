return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local system = vim.uv.os_uname()
      if system.sysname == 'Linux' and system.machine == 'aarch64' then
        -- Mason's clangd release does not provide a Linux arm64 binary.
        local clangd = opts.servers.clangd
        clangd.mason = false
        if vim.fn.executable '/usr/bin/clangd' == 1 then clangd.cmd[1] = '/usr/bin/clangd' end
      end
    end,
  },
}
