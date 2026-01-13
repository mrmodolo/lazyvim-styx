-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.lazyvim_python_lsp = "basedpyright"
-- vim.g.lazyvim_python_ruff = "ruff_lsp"
-- views can only be fully collapsed with the global statusline
-- https://github.com/yetone/avante.nvimhttps://github.com/yetone/avante.nvim
vim.opt.laststatus = 3

vim.g["conjure#client#scheme#stdio#command"] = "csi -quiet -:c"
vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "\n-#;%d-> "
vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = true
vim.g["conjure#mapping#doc_word"] = true

-- vim.g["conjure#client#scheme#stdio#command"] = "/home/modolo/opt/ChezScheme/bin/petite"
-- vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> $?"
