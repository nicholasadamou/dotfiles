-- Nvim Treesitter configurations and abstraction layer.
-- The goal of nvim-treesitter is both to provide a simple and easy way to use the 
-- interface for tree-sitter in Neovim and to provide some basic functionality such 
-- as highlighting based on it.
-- see: https://github.com/nvim-treesitter/nvim-treesitter

local config = function()
	require("nvim-treesitter.configs").setup({
		build = ":TSUpdate",
		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,
		highlight = {
			enable = true
		},
		indent = {
			enable = true
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	config = config,
}
