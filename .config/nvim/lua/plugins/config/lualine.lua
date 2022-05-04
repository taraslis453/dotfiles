local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = "" },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local gstatus = { ahead = 0, behind = 0 }
local function update_gstatus()
	local Job = require("plenary.job")
	Job
		:new({
			command = "git",
			args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
			on_exit = function(job, _)
				local res = job:result()[1]
				if type(res) ~= "string" then
					gstatus = { ahead = 0, behind = 0 }
					return
				end
				local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
				if not ok then
					ahead, behind = 0, 0
				end
				gstatus = { ahead = ahead, behind = behind }
			end,
		})
		:start()
end

if _G.Gstatus_timer == nil then
	_G.Gstatus_timer = vim.loop.new_timer()
else
	_G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local gps = require("nvim-gps")

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		always_divide_middle = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			branch,
			function()
				return gstatus.ahead .. " " .. gstatus.behind .. ""
			end,
		},

		lualine_b = { diagnostics },
		lualine_c = {
			{ gps.get_location, cond = gps.is_available },
		},
		lualine_x = { diff, spaces, "encoding", filetype },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
