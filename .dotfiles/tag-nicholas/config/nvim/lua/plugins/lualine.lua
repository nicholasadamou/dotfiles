-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
-- see: https://github.com/nvim-lualine/lualine.nvim

local config = function()
	require("lualine").setup({
		options = {
			theme = "nord",
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
