-- 🔥 No-nonsense floating terminal plugin for neovim 🔥
-- see: https://github.com/numToStr/FTerm.nvim

local mapvimkey = require("util.keymapper").mapvimkey

local config = function()
    require("FTerm").setup({
        blend = 5,
        dimensions = {
            height = 0.90,
            width = 0.90,
            x = 0.5,
            y = 0.5
        }
    })
end

local opts = {
    noremap = true,
    silent = true,
}

return {
    "numToStr/FTerm.nvim",
    config = config,
    opts = opts,
    keys = {
        -- normal mode mappings
        mapvimkey("<leader>t", "lua require('FTerm').toggle()"),
    }
}