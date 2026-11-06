return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestArguments = function(defaultArguments, context)
            return defaultArguments
          end,
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
          isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
        })
      )
    end,
  },
}
-- return {
--   {
--     "nvim-neotest/neotest",
--     dependencies = {
--       "nvim-neotest/neotest-jest",
--     },
--     opts = {
--       adapters = {
--         "neotest-jest",
--       },
--     },
--   },
-- }
