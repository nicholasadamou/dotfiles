-- 📡 Blazing fast minimap / scrollbar for vim, powered by code-minimap written in Rust.
-- see: https://github.com/wfxr/minimap.vim

local mapvimkey = require("util.keymapper").mapvimkey

local config = function()
    vim.g.minimap_auto_start = 1
    vim.g.minimap_auto_start_win_enter = 1

    vim.g.minimap_highlight_range = 1
    vim.g.minimap_highlight_search = 1
end

return {
    "wfxr/minimap.vim",
    lazy = false,
    config = config,
    keys = {
        -- normal mode mappings
        mapvimkey("<leader>mm", ":MinimapToggle"),
    }
}
