local mapvimkey = require("util.keymapper").mapvimkey

return {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    keys = {
        -- normal mode mappings
        mapvimkey("<C-h>", "TmuxNavigateLeft"),
        mapvimkey("<C-j>", "TmuxNavigateDown"),
        mapvimkey("<C-k>", "TmuxNavigateUp"),
        mapvimkey("<C-l>", "TmuxNavigateRight"),
    }
}