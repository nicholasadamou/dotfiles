local config = function(_, dashboard)
    local alpha = require("alpha")

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
                require("lazy").show()
            end,
        })
    end

    alpha.setup(dashboard.opts)

    -- Show stats when Lazy is ready
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
            -- Sections of the footer
            -- Includes the version, plugins, and datetime
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local version = "  󰥱 v"
                .. vim.version().major
                .. "."
                .. vim.version().minor
                .. "."
                .. vim.version().patch
            local plugins = "⚡ loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            local datetime = os.date("        %a, %d %b          %H:%M")
            
            local footer = version .. "\t" .. plugins .. "\n \n" .. datetime .. "\n"
            
            -- Set the footer
            dashboard.section.footer.val = footer

            -- Redraw the dashboard
            pcall(vim.cmd.AlphaRedraw)
        end,
    })
end

local opts = function()
    local dashboard = require("alpha.themes.dashboard")

--         local logo = [[
--            ▄ ▄
--        ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄
--        █ ▄ █▄█ ▄▄▄ █ █▄█ █ █
--     ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █
--   ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
--   █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
-- ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
-- █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
--     █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█
-- ]]

    local logo = [[
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
                                                                               
                                                                               
                                                                               
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "󰙴 " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("e", " " .. " Explore", ":NvimTreeToggle<CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }

    -- set highlight
    for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 10
    
    return dashboard
end

return {
    "goolord/alpha-nvim",
    lazy = false,
    event = "VimEnter",
    dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
    opts = opts,
    config = config,
}