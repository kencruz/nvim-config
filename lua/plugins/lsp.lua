return {
    -- LSP
    { "neovim/nvim-lspconfig", commit = "61e5109c8cf24807e4ae29813a3a82b31821dd45" }, -- enable LSP, latest requires >=0.8

    -- enhanced LSP features, using this for hover peek definitions, latest requires >=0.8
    {
      "kencruz/lspsaga.nvim",
      commit = "4b581979d6b82fdc215f2a918ec69b8f006777d9",
      dependencies = "nvim-lspconfig",
      opts = {}
    },

    { "williamboman/mason.nvim", commit = "7c7318e8bae7e3536ef6b9e86b9e38e74f2e125e" },
    { "williamboman/mason-lspconfig.nvim", commit = "d39a75bbce4b8aad5d627191ea915179c77c100f"},
    { "nvimtools/none-ls.nvim", commit = "90e4a27ccaa25979a6b732b9f06dfa43b54957b7", dependencies = { "nvimtools/none-ls-extras.nvim", commit = "1214d729e3408470a7b7a428415a395e5389c13c" }}, -- for formatters and linters, no longer maintained -> replace with none-ls.nvim


    -- Languages
    { "rust-lang/rust.vim", commit = "889b9a7515db477f4cb6808bef1769e53493c578" }, -- rust lang support, fixes :RustFmt
    { "simrat39/rust-tools.nvim", commit = "676187908a1ce35ffcd727c654ed68d851299d3e" }, -- rust tools, no longer maintained -> replace with mrcjkb/rustaceanvim
    -- {"mrcjkb/rustaceanvim", commit = "d63a53a085ae288f1567c7e502d7b5b957fd45ab" },
    {
      "pmizio/typescript-tools.nvim",
      commit = "bf11d98ad5736e1cbc1082ca9a03196d45c701f1",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {
        settings = {
          tsserver_file_preferences = {
          importModuleSpecifierPreference = "relative",
          quotePreference = "single",
          }
        }
      }
    },
}
