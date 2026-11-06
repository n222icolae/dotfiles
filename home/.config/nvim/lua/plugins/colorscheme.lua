return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    config = function()
      require("kanagawa").setup()
      -- vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-nvim-theme",
    priority = 1000,
    config = function()
      require("github-theme").setup({
        groups = {
          all = {
            CursorLine = { bg = "#222222" },
            --     FloatBorder = { fg = "#6e7681", bg = "NONE" }, -- matches k9s border.fgColor
            --     WinSeparator = { fg = "#6e7681", bg = "NONE" },
            --     NormalFloat = { bg = "#161b22" }, -- matches background_secondary
          },
        },
        palettes = {
          github_dark_default = {
            border = {
              default = "#6e7681",
              focus = "#58a6ff",
            },
          },
        },
      })
      vim.cmd("colorscheme github_dark_default")
    end,
  },
}
