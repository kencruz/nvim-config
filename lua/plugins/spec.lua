return {
{
    -- My plugins here
    { "nvim-lua/plenary.nvim", commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0" }, -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec",
      config = function ()
        -- Setup nvim-cmp.
        local status_ok, npairs = pcall(require, "nvim-autopairs")
        if not status_ok then
          return
        end

        npairs.setup {
          check_ts = true, -- treesitter integration
          disable_filetype = { "TelescopePrompt" },
        }

        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
          return
        end
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
      end,
    }, -- Autopairs, integrates with both cmp and treesitter, requires 0.7
    {
      "numToStr/Comment.nvim",
      commit = "0236521ea582747b58869cb72f70ccfa967d2e89",
      -- lazy = false,
      config = function ()
        -- Shorten function name
        local keymap = vim.keymap.set
        -- Silent keymap option
        local opts = { silent = true }
        keymap("n", "<leader>/", "<cmd>lua require('Comment.api').locked('toggle.linewise.current')()<CR>", opts)
        keymap("x", "<leader>/", "<ESC><CMD>lua require('Comment.api').locked('comment.linewise')(vim.fn.visualmode())<CR>")

        require('Comment').setup()
      end,
      -- keys = {
      --   {"<leader>/", "<cmd>lua require('Comment.api').locked('toggle.linewise.current')()<CR>", { silent = true }},
      --   {"<leader>/", "<ESC><CMD>lua require('Comment.api').locked('comment.linewise')(vim.fn.visualmode())<CR>", "x", { silent = true }},
      -- },
    }, -- the latest requires 0.8
    { "JoosepAlviste/nvim-ts-context-commentstring", commit = "1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee" }, -- the latest requires 0.9.4
    { "kyazdani42/nvim-web-devicons", commit = "140edfcf25093e8b321d13e154cbce89ee868ca0" }, -- the latest requires >= 0.7.0
    { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }, -- really old, 6y/o vimscript
    { "ahmedkhalf/project.nvim", commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
      config = function ()
        local status_ok, project = pcall(require, "project_nvim")
        if not status_ok then
          return
        end
        project.setup({

          -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
          detection_methods = { "pattern" },

          -- patterns used to detect root dir, when **"pattern"** is in detection_methods
          -- patterns = { ".git", "Makefile", "package.json", "Cargo.toml" },
          patterns = { ".git", "Makefile" },
        })

        local tele_status_ok, telescope = pcall(require, "telescope")
        if not tele_status_ok then
          return
        end

        telescope.load_extension('projects')
      end,
    }, -- the latest requires >= 0.5.0
    { "pteroctopus/faster.nvim", commit = "9fe4717d8c8c0a6aa306bd3b4f5fac5707eca334",
      config = function ()
        local faster_status_ok, faster = pcall(require, "faster")
        if not faster_status_ok then
          return
        end

        faster.setup({
          behaviours = {
            bigfile = {
              filesize = 1
            }
          }
        })
      end,
    }, -- the latest requires >= 0.5.0
    { "lukas-reineke/indent-blankline.nvim", main="ibl", commit = "259357fa4097e232730341fa60988087d189193a",
      config = function ()
        local status_ok, indent_blankline = pcall(require, "ibl")
        --[[ local status_ok, indent_blankline = pcall(require, "indent_blankline") ]]
        if not status_ok then
          return
        end

        indent_blankline.setup {
          indent = {
            char = "▏",
          },

          scope = {
            enabled = true,
            char = "▎",
          }
          --[[ char = "▏", ]]
          --[[ show_trailing_blankline_indent = false, ]]
          --[[ show_first_indent_level = true, ]]
          --[[ use_treesitter = true, ]]
          --[[ show_current_context = true, ]]
          --[[ buftype_exclude = { "terminal", "nofile" }, ]]
          --[[ filetype_exclude = { ]]
          --[[   "help", ]]
          --[[   "packer", ]]
          --[[   "NvimTree", ]]
          --[[ }, ]]
        }
      end,
    }, -- fixes high cpu & freeze in deleting lines (tree-sitter related)
    { "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" }, -- the latest requires >= 0.4.0, last update 4 y/o
    { "machakann/vim-sandwich", commit = "c5a2cc438ce6ea2005c556dc833732aa53cae21a" }, -- tags surround plugin, vimscript
    { "iamcco/markdown-preview.nvim", commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee", build = "cd app && npm install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, },
    { "kencruz/vim-illuminate", commit = "a658c7b5ea12eed4fc14f07456c668484c615ddf",
      config = function ()
        local status_ok, illuminate = pcall(require, "illuminate")
        if not status_ok then
          return
        end

        vim.g.Illuminate_ftblacklist = {'alpha', 'NvimTree'}
        vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
        vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})

        illuminate.configure({
          modes_denylist = {'v'},
        })
      end,
    },

    -- DAP
    -- { "mfussenegger/nvim-dap", commit = "9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5" }, -- the latest requires >= 0.9.0
    -- { "rcarriga/nvim-dap-ui", commit = "a62e86b124a94ad1f34a3f936ea146d00aa096d1" },
    -- { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }, -- the latest requires >= 0.5.0
  },
}
