-- This plugin adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg.
-- see: https://github.com/lukas-reineke/headlines.nvim


local config = function()
    require("headlines").setup({
        markdown = {
            headline_highlights = {
                "Headline1",
                "Headline2",
                "Headline3",
                "Headline4",
                "Headline5",
                "Headline6",
            },
            codeblock_highlight = "CodeBlock",
            dash_highlight = "Dash",
            quote_highlight = "Quote",
        },
    })
end

return {
    "lukas-reineke/headlines.nvim",
    config = config,
}