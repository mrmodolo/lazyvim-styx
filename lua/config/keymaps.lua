-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- Mapeia <leader>sc para abrir o Chicken Scheme num terminal flutuante
vim.keymap.set("n", "<leader>sc", function()
  Util.terminal({ "csi" }, { cwd = Util.root(), border = "rounded" })
end, { desc = "Chicken Scheme REPL" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "scheme",
  callback = function()
    vim.keymap.set("n", "K", function()
      -- Sua lógica complexa aqui
      local word = vim.fn.expand("<cword>")
      if word and word ~= "" then
        vim.cmd("!chicken-doc " .. word)
      else
        print("Nothing under cursor")
      end
    end, { buffer = true, desc = "Chicken Doc" })
  end,
})
