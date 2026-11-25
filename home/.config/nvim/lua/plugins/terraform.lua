-- OpenTofu instead of Terraform: the LazyVim terraform extra shells out to `terraform`
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          on_attach = function(_, _) end,
          -- terraform-ls requires an absolute path; resolve tofu (installed via mise) at attach time
          before_init = function(params)
            local tofu = vim.fn.exepath("tofu")
            if tofu ~= "" then
              params.initializationOptions = vim.tbl_deep_extend("force", params.initializationOptions or {}, {
                terraform = { path = tofu },
              })
            end
          end,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        terraform_fmt = { command = "tofu" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        -- the stock linter is a factory function, so wrap it instead of merging a table
        terraform_validate = function()
          local linter = require("lint.linters.terraform_validate")()
          linter.cmd = "tofu"
          return linter
        end,
      },
    },
  },
}
