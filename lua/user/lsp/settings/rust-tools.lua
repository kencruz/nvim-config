local rt = require("rust-tools")
local km = require("user.lsp.lsp-keymaps")

rt.setup({
  server = {
    on_attach = function(_, bufnr)

      km.lsp_keymaps(bufnr) -- use lsp keymaps
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false})]] -- format on save

      -- Hover actions
      -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
