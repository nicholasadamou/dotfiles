-- Markdown preview plugin for Neovim.
-- see: https://github.com/toppair/peek.nvim

return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        
        -- refer to `configuration to change defaults`
        -- see: https://github.com/toppair/peek.nvim#wrench-configuration

        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end
}