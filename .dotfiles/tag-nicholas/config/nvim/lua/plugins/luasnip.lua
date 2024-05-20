-- Snippet Engine for Neovim written in Lua.
-- Includes support for Snippets, LSP completion, and additional text editing capabilities.
-- see: https://github.com/L3MON4D3/LuaSnip

return {
    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets", -- Set of preconfigured snippets for different languages
            "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
            "onsails/lspkind.nvim", -- vscode-like pictograms for neovim lsp completion items
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load() -- load snippets from vscode
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = false,
        config = true
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            cmp.setup(
                {
                    window = {
                        documentation = cmp.config.window.bordered(),
                        completion = cmp.config.window.bordered()
                    },

                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end
                    },

                    mapping = cmp.mapping.preset.insert(
                        {
                            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                            ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll *down* documentation
                            ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll *up* documentation
                            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                            ["<C-e>"] = cmp.mapping.abort(), -- close the completion menu
                            ["<CR>"] = cmp.mapping.confirm({select = true}) -- select = true will insert the selected item
                        }
                    ),

                    sources = cmp.config.sources({
                        {name = "nvim_lsp"}, -- lsp
                        {name = "luasnip"}, -- snippets
                        {name = "path" }, -- file system paths
                        {name = "buffer"} -- text within current buffer
                }),

                    formatting = {
                        -- configure lspkind for vs-code like icons
                        -- see: https://github.com/onsails/lspkind.nvim#option-2-nvim-cmp
                        format = lspkind.cmp_format({
                            maxwidth = 50,  -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                                            -- can also be a function to dynamically calculate max width such as 
                                            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        })
                    },
                }
            )
        end
    }
}
