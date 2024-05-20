-- A small Neovim plugin for previewing definitions using floating windows.
-- see: https://github.com/rmagatti/goto-preview

return {
    'rmagatti/goto-preview',
    config = function()
        require('goto-preview').setup {
            -- Use default configuration options
            -- see: https://github.com/rmagatti/goto-preview#%EF%B8%8F-configuration
        }
    end
}