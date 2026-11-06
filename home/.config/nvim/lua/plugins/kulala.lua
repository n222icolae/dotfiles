return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  opts = {
    kulala_keymaps = {
      -- these default to <C-h> / <C-l>, which conflicts with
      -- LazyVim's window navigation (Go to Left/Right Window)
      ["Previous tab"] = false,
      ["Next tab"] = false,
    },
  },
}
