-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "ci", '"_ci', { noremap = true })
vim.keymap.set({ "n", "v" }, "cI", '"_cI', { noremap = true })
vim.keymap.set({ "n", "v" }, "ca", '"_ca', { noremap = true })
vim.keymap.set({ "n", "v" }, "cA", '"_cA', { noremap = true })
