return {
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
}
