
local status_ok, alpha = pcall(require, "tokyonight")
             if not status_ok then
	        return
            end
vim.cmd("colorscheme tokyonight-night")
