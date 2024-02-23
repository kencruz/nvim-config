local colorscheme = "gruvbox-baby"
local colors = require("gruvbox-baby.colors").config()

vim.g.gruvbox_baby_highlights = {
  TabLine = { bg = colors.dark, fg = colors.medium_gray },
  -- gitcommitDiscarded = { fg = colors.error_red },
  -- gitcommitUntracked = { fg = colors.comment },
  -- gitcommitSelected = { fg = colors.soft_green },
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
