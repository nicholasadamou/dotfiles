-- Clean and elegant distraction-free writing for NeoVim.
-- see: https://github.com/pocco81/true-zen.nvim

local mapvimkey = require("util.keymapper").mapvimkey

return {
	"pocco81/true-zen.nvim",
	lazy = false,
	keys = {
		-- normal mode mappings
		mapvimkey("<leader>zn", "TZNarrow"),
		mapvimkey("<leader>zf", "TZFocus"),
		mapvimkey("<leader>zm", "TZMinimalist"),
		mapvimkey("<leader>za", "TZAtaraxis"),

		-- visual mode mappings
		mapvimkey("<leader>zn", ":'<,'>TZNarrow", "v")
	}
}
