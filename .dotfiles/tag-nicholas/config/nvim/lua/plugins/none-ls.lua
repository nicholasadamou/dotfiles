-- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
-- see: https://github.com/nvimtools/none-ls.nvim

local mapvimkey = require("util.keymapper").mapvimkey

local config = function()
    local null_ls = require("null-ls")
    
    null_ls.setup({
        sources = {
            -- Lua
            null_ls.builtins.formatting.stylua,

            -- JavaScript
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.diagnostics.eslint_d,
        },
    })
end

return {
	"nvimtools/none-ls.nvim",
	config = config,
    keys = {
        -- normal mode mappings
        mapvimkey("<leader>gf", "Format buffer")
    }
}