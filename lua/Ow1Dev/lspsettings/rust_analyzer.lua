return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      diagnostics = {
        enable = false,
      },
      files = {
        excludeDirs = { ".direnv", ".git" },
        watcherExclude = { ".direnv", ".git" },
      },
    },
  },
}
