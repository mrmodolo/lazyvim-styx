-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "TSUpdate",
--   callback = function()
--     require("nvim-treesitter.parsers").jsonc.install_info.path = "/home/modolo/src/tree-sitter-jsonc"
--   end,
-- })

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
