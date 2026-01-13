-- TODO: Verify if this is still needed once scheme support is added to nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    -- Ensure scheme is installed alongside whatever else you have
    if type(opts.ensure_installed) == "table" then
      table.insert(opts.ensure_installed, "scheme")
    end
  end,
}
