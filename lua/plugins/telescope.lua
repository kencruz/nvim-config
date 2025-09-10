return {
     -- Telescope
    { "nvim-telescope/telescope.nvim",
      commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
      dependencies = {
        { "nvim-telescope/telescope-live-grep-args.nvim", commit = "731a046da7dd3adff9de871a42f9b7fb85f60f47" },
        { "nvim-telescope/telescope-frecency.nvim", commit = "f67baca08423a6fd00167801a54db38e0b878063" },
        { "mollerhoj/telescope-recent-files.nvim", commit = "23b29aa701cd07c723282b3094e1a4dfc231f557" }
      },
      config = function()
        local status_ok, telescope = pcall(require, "telescope")
        if not status_ok then
          return
        end

        local actions = require "telescope.actions"

        -- custom file sorter START
        local sorters = require('telescope.sorters')
        local fzy_sorter = sorters.get_fzy_sorter()
        local filter = vim.tbl_filter

        -- Copied from:
        -- https://github.com/nvim-telescope/telescope.nvim/blob/dc192faceb2db64231ead71539761e055df66d73/lua/telescope/builtin/__internal.lua#L17-L29
        local function apply_cwd_only_aliases(opts)
          local has_cwd_only = opts.cwd_only ~= nil
          local has_only_cwd = opts.only_cwd ~= nil

          if has_only_cwd and not has_cwd_only then
            -- Internally, use cwd_only
            opts.cwd_only = opts.only_cwd
            opts.only_cwd = nil
          end

          return opts
        end
        -- Copied from:
        -- https://github.com/nvim-telescope/telescope.nvim/blob/dc192faceb2db64231ead71539761e055df66d73/lua/telescope/builtin/__internal.lua#L872-L923
        local get_buffers = function(opts)
          opts = opts or {}
          opts = apply_cwd_only_aliases(opts)
          local bufnrs = filter(function(b)
            if 1 ~= vim.fn.buflisted(b) then
              return false
            end
            -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
            if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
              return false
            end
            if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
              return false
            end
            if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
              return false
            end
            if not opts.cwd_only and opts.cwd and not string.find(vim.api.nvim_buf_get_name(b), opts.cwd, 1, true) then
              return false
            end
            return true
          end, vim.api.nvim_list_bufs())
          if not next(bufnrs) then
            return
          end
          if opts.sort_mru then
            table.sort(bufnrs, function(a, b)
              return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
            end)
          end

          local buffers = {}
          for _, bufnr in ipairs(bufnrs) do
            local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

            local element = {
              bufnr = bufnr,
              flag = flag,
              info = vim.fn.getbufinfo(bufnr)[1],
            }

            if opts.sort_lastused and (flag == "#" or flag == "%") then
              local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
              table.insert(buffers, idx, element)
            else
              table.insert(buffers, element)
            end
          end
          return buffers
        end

        local is_file_open = function(line)
          local buffers = get_buffers()
          if not buffers then
            return false
          end
          -- TODO: This may not be performant if there are many open buffers.
          -- We could implement a map / lookup table instead.
          for _, buffer in ipairs(buffers) do
            local buffer_name = buffer.info.name
            if vim.endswith(buffer_name, line) then
              return true
            end
          end
          return false
        end

        -- Copied from:
        -- https://github.com/nvim-telescope/telescope.nvim/blob/dc192faceb2db64231ead71539761e055df66d73/lua/telescope/sorters.lua#L437-L466
        -- Sorter using the fzy algorithm
        local file_sorter = function(opts)
          opts = opts or {}
          local fzy = opts.fzy_mod or require "telescope.algos.fzy"
          local OFFSET = -fzy.get_score_floor()

          return sorters.Sorter:new {
            discard = fzy_sorter.discard,

            scoring_function = function(_, prompt, line)
              -- Check for actual matches before running the scoring alogrithm.
              if not fzy.has_match(prompt, line) then
                return -1
              end

              local fzy_score = fzy.score(prompt, line)

              -- The fzy score is -inf for empty queries and overlong strings.  Since
              -- this function converts all scores into the range (0, 1), we can
              -- convert these to 1 as a suitable "worst score" value.
              if fzy_score == fzy.get_score_min() then
                return 1
              end

              -- CUSTOM CODE ADDED HERE 👇
              -- Double score if file is open.
              -- TODO: Score boost could take into account sort order of buffers.
              -- Like which one was last used.
              if is_file_open(line) then
                fzy_score = fzy_score * 2
              end
              -- END CUSTOM CODE

              -- Poor non-empty matches can also have negative values. Offset the score
              -- so that all values are positive, then invert to match the
              -- telescope.Sorter "smaller is better" convention. Note that for exact
              -- matches, fzy returns +inf, which when inverted becomes 0.
              return 1 / (fzy_score + OFFSET)
            end,

            highlighter = fzy_sorter.highlighter
          }
        end
        -- custom file sorter END

        -- Shorten function name
        local keymap = vim.keymap.set
        -- Silent keymap option
        local opts = { silent = true }
        -- Keymaps
        keymap("n", "<leader>fF", ":Telescope frecency<CR>", opts)
        keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
        keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
        keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
        keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
        keymap("n", "<leader>fb", ":lua require'telescope.builtin'.buffers{ sort_mru = true }<CR>", opts)
        keymap("n", "<leader>fr", ":lua require'telescope.builtin'.registers{}<CR>", opts)
        keymap("n", "<leader>fq", ":lua require'telescope.builtin'.command_history{}<CR>", opts)
        keymap("n", "<leader>fs", ":lua require'telescope.builtin'.search_history{}<CR>", opts)
        keymap("n", "<leader>fm", ":lua require'telescope.builtin'.marks{}<CR>", opts)
        keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)
        keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)

        telescope.setup {
          defaults = {

            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "truncate" },
            file_ignore_patterns = { ".git/", "node_modules", "package-lock.json" },
            file_sorter = file_sorter,

            mappings = {
              i = {
                ["<Down>"] = actions.cycle_history_next,
                ["<Up>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-b>"] = actions.preview_scrolling_right,
              },
            },
          },
        }

        require("telescope").load_extension("live_grep_args")
        require("telescope").load_extension("recent-files")
        require("telescope").load_extension("frecency")
      end
    }, -- latest requires >=0.9.0
}
