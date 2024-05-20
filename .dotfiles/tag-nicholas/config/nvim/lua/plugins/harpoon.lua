-- Getting you where you want with the fewest keystrokes.
-- see: https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-telescope/telescope.nvim'
    },
    config = function()
        local harpoon = require('harpoon')

        -- This is required due to autocmds setup.
        -- see: https://github.com/ThePrimeagen/harpoon/tree/harpoon2#harpoonsetup-is-required
        harpoon.setup()

        -- Telescope integration
        -- see: https://github.com/ThePrimeagen/harpoon/tree/harpoon2#telescope
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon window" })

        -- Additional configuration
        -- see: https://github.com/ThePrimeagen/harpoon/tree/harpoon2#basic-setup
    end
}