-- A super powerful autopair plugin for Neovim that supports multiple characters.
-- E.g., when you type a single quote, it will automatically insert a closing single quote.
-- see: https://github.com/windwp/nvim-autopairs

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {}, -- this is equalent to setup({}) function
}
