local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ta"] = "@parameter.inner",
        ["<leader>tf"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>tA"] = "@parameter.inner",
        ["<leader>tF"] = "@function.outer",
      },
    },
  },
})
