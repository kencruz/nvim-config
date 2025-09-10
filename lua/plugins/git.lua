return {
    {
      "lewis6991/gitsigns.nvim",
      commit = "6e3ee68bc9f65b21a21582a3d80e270c7e4f2992",
      lazy = false,
      opts = {
        signs = {
            add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          },
      },
    }, -- the latest requires >= 0.8.0

    -- nvim v0.7.2
    {
        "kdheepak/lazygit.nvim", commit = "10a5f30536dc2d4abe36d410d83149272ea457fa",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    { "f-person/git-blame.nvim", commit = "408d5487d908dfe5d48e5645d8b27ddcc16b11e0" }, -- the latest requires >= 0.8.0
}
