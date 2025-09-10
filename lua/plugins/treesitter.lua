return {
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      commit = "42fc28ba918343ebfd5565147a42a26580579482",
      config = function()
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
          return
        end

        configs.setup({
          ensure_installed = "all", -- one of "all" or a list of languages
          ignore_install = { "ipkg" }, -- List of parsers to ignore installing
          highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "css" }, -- list of language that will be disabled
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            }
          },
          autopairs = {
            enable = true,
          },
          -- indent is buggy in nvim-treesitter
          -- indent = { enable = true, disable = { "python", "css" } },
        })
      end,
    }, -- the latest requires >=0.10.0

    { "nvim-treesitter/nvim-treesitter-context", commit = "6853ecb2cd8b062365da1cdd1a2e6f934ad55ed6"}, -- for sticky function signatures, the latest requires >= v0.11.0

}
