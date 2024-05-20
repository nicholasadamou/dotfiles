-- Super fast git decorations implemented purely in Lua.
-- see: https://github.com/lewis6991/gitsigns.nvim

return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = function()
    require("gitsigns").setup()
  end
}
