local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3" } -- Have packer manage itself
  -- use { "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" } -- Useful lua functions used by lots of plugins
  -- use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter, requires 0.7
  use { "numToStr/Comment.nvim", commit = "0236521ea582747b58869cb72f70ccfa967d2e89" } -- the latest requires 0.8
  -- use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" } -- the latest requires 0.8
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee" } -- the latest requires 0.9.4
  use { "kyazdani42/nvim-web-devicons", commit = "140edfcf25093e8b321d13e154cbce89ee868ca0" } -- the latest requires >= 0.7.0
  -- use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" } -- the latest requires >= 0.7.0
  use { "nvim-tree/nvim-tree.lua", commit = "e9c5abe073a973f54d3ca10bfe30f253569f4405" } -- the latest requires >=0.8.0
  -- use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" } -- the latest requires >=0.8.0
  use { "akinsho/bufferline.nvim", commit = "99337f63f0a3c3ab9519f3d1da7618ca4f91cffe" } -- the latest requires >=0.8
  -- use { "akinsho/bufferline.nvim", commit = "e48ce1805697e4bb97bc171c081e849a65859244" } -- the latest requires >=0.8
  -- use { "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" } -- the latest requires >=0.8
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" } -- really old, 6y/o vimscript
  use { "nvim-lualine/lualine.nvim", commit = "566b7036f717f3d676362742630518a47f132fff" } -- the latest requires >= 0.7
  -- use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" } -- the latest requires >= 0.7
  use { "akinsho/toggleterm.nvim", commit = "e3805fed94d487b81e9c21548535cc820f62f840" } -- the latest requires >= 0.7
  -- use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" } -- the latest requires >= 0.7
  use { "ahmedkhalf/project.nvim", commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb" } -- the latest requires >= 0.5.0
  -- use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" } -- the latest requires >= 0.5.0
  -- use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" } -- the latest requires >= 0.7, no longer needed in 0.9 see readme
  use { "lukas-reineke/indent-blankline.nvim", main="ibl", commit = "259357fa4097e232730341fa60988087d189193a" } -- fixes high cpu & freeze in deleting lines (tree-sitter related)
  -- use { "lukas-reineke/indent-blankline.nvim", main="ibl", commit = "12e92044d313c54c438bd786d11684c88f6f78cd" }
  use { "goolord/alpha-nvim", commit = "4b36c1ca9ea475bdc006896657cf1ccc486aeffa" }
  -- use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" }
  use { "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" } -- the latest requires >= 0.4.0, last update 4 y/o
  use { "machakann/vim-sandwich", commit = "c5a2cc438ce6ea2005c556dc833732aa53cae21a" } -- tags surround plugin, vimscript
  use({ "iamcco/markdown-preview.nvim", commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  -- use({ "iamcco/markdown-preview.nvim", commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use {
    'rmagatti/auto-session',
    commit = "322d82fa7cb455bc82a30f4e4907af696afdfb45",
    config = function()
      require("auto-session").setup {
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
      }
    end
  }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" }
  use { "lunarvim/darkplus.nvim", commit = "2584cdeefc078351a79073322eb7f14d7fbb1835" }
  use { "ellisonleao/gruvbox.nvim" }
  use { "luisiacc/gruvbox-baby", commit = "436f73d6a45777eadedbd2f842f766d093266eb3" }
  --[[ use { "luisiacc/gruvbox-baby", commit = "4f1df4ed179705179ebb4e57b6ac4dedc4130d7e" } ]]

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "538e37ba87284942c1d76ed38dd497e54e65b891" } -- The completion plugin
  -- use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions
  -- use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" } -- path completions
  -- use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
  use { "saadparwaiz1/cmp_luasnip", commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843" } -- snippet completions
  -- use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "5af77f54de1b16c34b23cba810150689a3a90312" }
  -- use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "f12408bdb54c39c23e67cab726264c10db33ada8" }
  -- use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }
  -- gitlab duo, remove when trial is complete
  -- use {
  --   "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git", commit = "74a845366a7edf6b400ab9a4d2ec83bacadea930"
  -- }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "2dbef19461198630b3d7c39f414d09fb07d1fdd2" } --snippet engine, requires >= 0.7
  -- use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" } --snippet engine, requires >= 0.7
  use { "rafamadriz/friendly-snippets", commit = "69a2c1675b66e002799f5eef803b87a12f593049" } -- a bunch of snippets to use
  -- use { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "8917d2c830e04bf944a699b8c41f097621283828" } -- enable LSP, latest requires >=0.8
  use {
    "nvimdev/lspsaga.nvim",
    commit = "01dc5ea5916abbe3158d2661e21d90dcc04d7c47",
    after = "nvim-lspconfig",
    config = function()
        require('lspsaga').setup({})
    end,
  } -- enhanced LSP features, using this for hover peek definitions, latest requires >=0.8
  -- use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP, latest requires >=0.8
  --[[ use { "williamboman/nvim-lsp-installer", commit = "17e0bfa5f2c8854d1636fcd036dc8284db136baa" } -- simple to use language server installer, latest requires >=0.7, no longer maintained -> replace with mason.nvim ]]
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer, latest requires >=0.7, no longer maintained -> replace with mason.nvim
  use { "williamboman/mason.nvim", commit = "e110bc3be1a7309617cecd77bfe4bf86ba1b8134" }
  use { "williamboman/mason-lspconfig.nvim", commit = "3ba1b92b771f33256b4969d696b82c8ae7075364" }
  use { "nvimtools/none-ls.nvim", commit = "e64f03f3f77bd6854c3b3c5cfffcc806a0c0f66a" } -- for formatters and linters, no longer maintained -> replace with none-ls.nvim
  -- use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters, no longer maintained -> replace with none-ls.nvim
  use { "RRethy/vim-illuminate", commit = "3bd2ab64b5d63b29e05691e624927e5ebbf0fb86" }
  -- use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }

  -- Languages
  use { "rust-lang/rust.vim", commit = "889b9a7515db477f4cb6808bef1769e53493c578" } -- rust lang support, fixes :RustFmt
  use { "simrat39/rust-tools.nvim", commit = "676187908a1ce35ffcd727c654ed68d851299d3e" } -- rust tools, no longer maintained -> replace with mrcjkb/rustaceanvim
  -- use { "simrat39/rust-tools.nvim", commit = "b297167d9e01accc9b9afe872ce91e791df2dde0" } -- rust tools, no longer maintained -> replace with mrcjkb/rustaceanvim
  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
        settings = {
          tsserver_file_preferences = {
          importModuleSpecifierPreference = "relative",
          quotePreference = "single",
          }
        }
      }
    end,
  }

   -- Telescope
  use { "nvim-telescope/telescope.nvim",
    commit = "24778fd72fcf39a0b1a6f7c6f4c4e01fef6359a2",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim", commit = "731a046da7dd3adff9de871a42f9b7fb85f60f47" },
      { "nvim-telescope/telescope-frecency.nvim", commit = "f67baca08423a6fd00167801a54db38e0b878063" },
      { "mollerhoj/telescope-recent-files.nvim", commit = "23b29aa701cd07c723282b3094e1a4dfc231f557" }
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("recent-files")
      require("telescope").load_extension("frecency")
    end
  } -- latest requires >=0.9.0

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "223f8dd2e475ab790d9fede23681cd3c016fab79",
    -- commit = "5cc562748729b6dc9563ea5a3d676ff102ab38b1", old 
  } -- the latest requires >=0.9.2
  -- use {
  --   "nvim-treesitter/nvim-treesitter",
  --   commit = "518e27589c0463af15463c9d675c65e464efc2fe",
  -- } -- the latest requires >=0.9.2
  use { "nvim-treesitter/playground", commit = "90d2b3e1729363f96ce2c23f16129534df893bbf" } -- deprecated, built in neovim

  use { "nvim-treesitter/nvim-treesitter-context", commit = "85cf977181fb8e816e47ac05df7f756e9cb72caf"} -- for sticky function signatures, the latest requires >= v0.9.0
  -- use { "nvim-treesitter/nvim-treesitter-context", commit = "d28654b012d4c56beafec630ef7143275dff76f8"} -- for sticky function signatures, the latest requires >= v0.9.0

  use{
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "23b820146956b3b681c19e10d3a8bc0cbd9a1d4c",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "c5ff7628e19a47ec14d3657294cc074ecae27b99" } -- the latest requires >= 0.8.0
  -- use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" } -- the latest requires >= 0.8.0

  -- nvim v0.7.2
  use({
      "kdheepak/lazygit.nvim", commit = "10a5f30536dc2d4abe36d410d83149272ea457fa",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })
  use { "f-person/git-blame.nvim", commit = "408d5487d908dfe5d48e5645d8b27ddcc16b11e0" } -- the latest requires >= 0.8.0

  -- DAP
  use { "mfussenegger/nvim-dap", commit = "9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5" } -- the latest requires >= 0.9.0
  -- use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" } -- the latest requires >= 0.9.0
  use { "rcarriga/nvim-dap-ui", commit = "a62e86b124a94ad1f34a3f936ea146d00aa096d1" }
  -- use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" } -- the latest requires >= 0.5.0

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
