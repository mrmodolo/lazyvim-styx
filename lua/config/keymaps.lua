-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Mapeia <leader>sc para abrir o Chicken Scheme num terminal flutuante
vim.keymap.set("n", "<leader>sc", function()
  require("snacks").terminal({ "csi" }, { cwd = vim.fn.getcwd(), border = "rounded" })
end, { desc = "Chicken Scheme REPL" })
