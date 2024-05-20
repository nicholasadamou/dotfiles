local config = function()
    local highlights = require("nord").bufferline.highlights({
        italic = true,
        bold = true,
        fill = "#181c24"
    })

    require("bufferline").setup({
        options = {
            separator_style = "thin",
        },
        highlights = highlights,
    })
end

return {
    -- Disabled in favor of 'romgrk/barbar.nvim'
    -- "akinsho/nvim-bufferline.lua",
    -- lazy = false,
    -- config = config,
}