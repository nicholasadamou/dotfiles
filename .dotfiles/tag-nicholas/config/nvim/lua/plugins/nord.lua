return {
	"shaunsingh/nord.nvim",
	name = "theme",
	lazy = false,
	priority = 999,
	config = function()
		vim.g.nord_borders = true

		vim.cmd("colorscheme nord")
	end,
}
