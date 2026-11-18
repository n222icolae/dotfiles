return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "yamllint" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- extend LazyVim's defaults instead of replacing them;
      -- per-repo rules go in a `.yamllint` file, picked up by yamllint itself
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.yaml = vim.list_extend(opts.linters_by_ft.yaml or {}, { "yamllint" })
    end,
  },
}
