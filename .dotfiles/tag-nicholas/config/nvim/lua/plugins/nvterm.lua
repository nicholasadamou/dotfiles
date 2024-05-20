-- NvChad's Official Terminal Plugin.
-- see: https://github.com/NvChad/nvterm

return {
    "NvChad/nvterm",
    lazy = false,
    config = function ()
        require("nvterm").setup()

        local terminal = require("nvterm.terminal")

        local toggle_modes = {'n', 't'}
        local mappings = {
            { toggle_modes, '<leader>h', function () terminal.toggle('horizontal') end },
            { toggle_modes, '<leader>v', function () terminal.toggle('vertical') end },
            { toggle_modes, '<leader>i', function () terminal.toggle('float') end },
        }

        local opts = { noremap = true, silent = true }
        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
        end
    end,
}