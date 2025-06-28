-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install your plugins here
return lazy.setup({
  spec = {
    -- My plugins here
    { "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" }, -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }, -- Autopairs, integrates with both cmp and treesitter, requires 0.7
    { "numToStr/Comment.nvim", commit = "0236521ea582747b58869cb72f70ccfa967d2e89" }, -- the latest requires 0.8
    { "JoosepAlviste/nvim-ts-context-commentstring", commit = "1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee" }, -- the latest requires 0.9.4
    { "kyazdani42/nvim-web-devicons", commit = "140edfcf25093e8b321d13e154cbce89ee868ca0" }, -- the latest requires >= 0.7.0
    { "nvim-tree/nvim-tree.lua", commit = "e9c5abe073a973f54d3ca10bfe30f253569f4405" }, -- the latest requires >=0.8.0
    { "akinsho/bufferline.nvim", commit = "99337f63f0a3c3ab9519f3d1da7618ca4f91cffe" }, -- the latest requires >=0.8
    { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }, -- really old, 6y/o vimscript
    { "nvim-lualine/lualine.nvim", commit = "566b7036f717f3d676362742630518a47f132fff" }, -- the latest requires >= 0.7
    { "akinsho/toggleterm.nvim", commit = "e3805fed94d487b81e9c21548535cc820f62f840" }, -- the latest requires >= 0.7
    { "ahmedkhalf/project.nvim", commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb" }, -- the latest requires >= 0.5.0
    { "pteroctopus/faster.nvim", commit = "9fe4717d8c8c0a6aa306bd3b4f5fac5707eca334" }, -- the latest requires >= 0.5.0
    { "lukas-reineke/indent-blankline.nvim", main="ibl", commit = "259357fa4097e232730341fa60988087d189193a" }, -- fixes high cpu & freeze in deleting lines (tree-sitter related)
    -- { "lukas-reineke/indent-blankline.nvim", main="ibl", commit = "12e92044d313c54c438bd786d11684c88f6f78cd" }
    { "goolord/alpha-nvim", commit = "4b36c1ca9ea475bdc006896657cf1ccc486aeffa" },
    { "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" }, -- the latest requires >= 0.4.0, last update 4 y/o
    { "machakann/vim-sandwich", commit = "c5a2cc438ce6ea2005c556dc833732aa53cae21a" }, -- tags surround plugin, vimscript
    { "iamcco/markdown-preview.nvim", commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee", build = "cd app && npm install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, },
    {
      'rmagatti/auto-session',
      commit = "322d82fa7cb455bc82a30f4e4907af696afdfb45",
      lazy = false,

      ---enables autocomplete for opts
      ---@module "auto-session"
      ---@type AutoSession.Config
      opts = {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        -- log_level = 'debug',
      }
    },

    -- Colorschemes
    { "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" },
    { "lunarvim/darkplus.nvim", commit = "2584cdeefc078351a79073322eb7f14d7fbb1835" },
    { "ellisonleao/gruvbox.nvim" },
    { "luisiacc/gruvbox-baby", commit = "436f73d6a45777eadedbd2f842f766d093266eb3" },
    { "rainglow/vim", commit = "837fd7292274e0ee2f3b5aee4519c3f74d7dc3d1", name = "rainglow-themes" },

    -- cmp plugins
    { "hrsh7th/nvim-cmp", commit = "5a11682453ac6b13dbf32cd403da4ee9c07ef1c3" }, -- The completion plugin
    { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- buffer completions
    { "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }, -- path completions
    { "saadparwaiz1/cmp_luasnip", commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp", commit = "99c4e3ea26262dbe457d8fd57b1136ede6157531" },
    { "hrsh7th/cmp-nvim-lua", commit = "f12408bdb54c39c23e67cab726264c10db33ada8" },

    -- snippets
    { "L3MON4D3/LuaSnip", commit = "2dbef19461198630b3d7c39f414d09fb07d1fdd2" }, --snippet engine, requires >= 0.7
    { "rafamadriz/friendly-snippets", commit = "69a2c1675b66e002799f5eef803b87a12f593049" }, -- a bunch of snippets to use

    -- LSP
    { "neovim/nvim-lspconfig", commit = "61e5109c8cf24807e4ae29813a3a82b31821dd45" }, -- enable LSP, latest requires >=0.8
    -- { "neovim/nvim-lspconfig", commit = "8917d2c830e04bf944a699b8c41f097621283828" }, -- enable LSP, latest requires >=0.8
    {
      "nvimdev/lspsaga.nvim",
      commit = "778d56ff9b387dacd14ae648ed5604394b486f51",
      dependencies = "nvim-lspconfig",
      opts = {}
    }, -- enhanced LSP features, using this for hover peek definitions, latest requires >=0.8
    { "williamboman/mason.nvim", commit = "7c7318e8bae7e3536ef6b9e86b9e38e74f2e125e" },
    { "williamboman/mason-lspconfig.nvim", commit = "d39a75bbce4b8aad5d627191ea915179c77c100f"},
    { "nvimtools/none-ls.nvim", commit = "90e4a27ccaa25979a6b732b9f06dfa43b54957b7", dependencies = { "nvimtools/none-ls-extras.nvim", commit = "1214d729e3408470a7b7a428415a395e5389c13c" }}, -- for formatters and linters, no longer maintained -> replace with none-ls.nvim

    { "RRethy/vim-illuminate", commit = "fbc16dee336d8cc0d3d2382ea4a53f4a29725abf" },

    -- Languages
    { "rust-lang/rust.vim", commit = "889b9a7515db477f4cb6808bef1769e53493c578" }, -- rust lang support, fixes :RustFmt
    { "simrat39/rust-tools.nvim", commit = "676187908a1ce35ffcd727c654ed68d851299d3e" }, -- rust tools, no longer maintained -> replace with mrcjkb/rustaceanvim
    {
      "pmizio/typescript-tools.nvim",
      commit = "a4109c70e7d6a3a86f971cefea04ab6720582ba9",
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

     -- Telescope
    { "nvim-telescope/telescope.nvim",
      commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
      -- commit = "24778fd72fcf39a0b1a6f7c6f4c4e01fef6359a2",
      dependencies = {
        { "nvim-telescope/telescope-live-grep-args.nvim", commit = "731a046da7dd3adff9de871a42f9b7fb85f60f47" },
        { "nvim-telescope/telescope-frecency.nvim", commit = "f67baca08423a6fd00167801a54db38e0b878063" },
        { "mollerhoj/telescope-recent-files.nvim", commit = "23b29aa701cd07c723282b3094e1a4dfc231f557" }
      },
      opts = function()
        require("telescope").load_extension("live_grep_args")
        require("telescope").load_extension("recent-files")
        require("telescope").load_extension("frecency")
      end
    }, -- latest requires >=0.9.0

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      commit = "f2bd62c6568de54ca1b8fb0a8de04a41442934cb",
    }, -- the latest requires >=0.10.0
    { "nvim-treesitter/playground", commit = "90d2b3e1729363f96ce2c23f16129534df893bbf" }, -- deprecated, built in neovim

    { "nvim-treesitter/nvim-treesitter-context", commit = "198720b4016af04c9590f375d714d5bf8afecc1a"}, -- for sticky function signatures, the latest requires >= v0.11.0

    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      commit = "23b820146956b3b681c19e10d3a8bc0cbd9a1d4c",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -- Git
    { "lewis6991/gitsigns.nvim", commit = "c5ff7628e19a47ec14d3657294cc074ecae27b99" }, -- the latest requires >= 0.8.0

    -- nvim v0.7.2
    {
        "kdheepak/lazygit.nvim", commit = "10a5f30536dc2d4abe36d410d83149272ea457fa",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    { "f-person/git-blame.nvim", commit = "408d5487d908dfe5d48e5645d8b27ddcc16b11e0" }, -- the latest requires >= 0.8.0

    -- DAP
    -- { "mfussenegger/nvim-dap", commit = "9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5" }, -- the latest requires >= 0.9.0
    -- { "rcarriga/nvim-dap-ui", commit = "a62e86b124a94ad1f34a3f936ea146d00aa096d1" },
    -- { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }, -- the latest requires >= 0.5.0
  },
})
