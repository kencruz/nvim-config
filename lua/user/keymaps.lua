-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
-- keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<leader>bh", ":lua require'bufferline'.go_to(1, true)<CR>", opts)
-- keymap("n", "<leader>bl", ":lua require'bufferline'.go_to(-1, true)<CR>", opts)

-- Move buffers
-- keymap("n", "<M-l>", ":BufferLineMoveNext<CR>", opts)
-- keymap("n", "<M-h>", ":BufferLineMovePrev<CR>", opts)
-- keymap("n", "<M-L>", ":lua require'bufferline'.move_to(-1)<CR>", opts)
-- keymap("n", "<M-H>", ":lua require'bufferline'.move_to(1)<CR>", opts)
-- keymap("n", "<leader>bp", ":BufferLineTogglePin<CR>", opts)

-- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)
-- keymap("n", "<leader>bch", ":BufferLineCloseLeft<CR>", opts) -- close buffers to the left
-- keymap("n", "<leader>bcl", ":BufferLineCloseRight<CR>", opts) -- close buffers to the right

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close window
keymap("n", "<leader>w", ":close<CR>")

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Press C-c to escape
keymap("i", "<C-c>", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
-- keymap("n", "<leader>ff", ":lua require'telescope'.extensions['recent-files'].recent_files({})<CR>", opts)
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
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>gg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gf", ":LazyGitCurrentFile<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').locked('toggle.linewise.current')()<CR>", opts)
keymap("x", "<leader>/", "<ESC><CMD>lua require('Comment.api').locked('comment.linewise')(vim.fn.visualmode())<CR>")

-- carriage return fix
keymap("n", "<leader>cr", ":%s/\\r//g<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Alpha menu
keymap("n", "<leader>m", ":Alpha<CR>", opts)
