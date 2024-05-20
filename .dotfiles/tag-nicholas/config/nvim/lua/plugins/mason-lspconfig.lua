-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
-- see: https://github.com/williamboman/mason-lspconfig.nvim

local opts = {
	-- see: https://github.com/williamboman/mason-lspconfig.nvim#default-configuration

	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    -- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {
		"efm",
		"bashls",
		"tsserver",
		"tailwindcss",
		"pyright",
		"lua_ls",
		"emmet_ls",
		"jsonls",
		"clangd",
	},

	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	opts = opts,
	dependencies = "williamboman/mason.nvim",
}
