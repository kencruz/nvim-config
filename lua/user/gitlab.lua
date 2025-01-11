require('gitlab').setup({
  statusline = {
    enabled = false
  },
  code_suggestions = {
    -- # For the full list of default languages, see the 'auto_filetypes' array in
    -- # https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
    auto_filetypes = { 'rust', 'javascript', 'typescript' }, -- Default is { 'ruby' }
  }
})
