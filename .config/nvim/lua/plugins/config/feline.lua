local gps = require("nvim-gps")
local M = {
	active = {},
	inactive = {},
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

M.active[1] = {
	{
		provider = "git_branch",
		hl = {
			fg = "white",
			style = "bold",
		},
		left_sep = {
			" ",
		},
	},
	{
		provider = function()
			return gstatus.ahead .. " " .. gstatus.behind .. ""
		end,
		left_sep = {
			" ",
		},
	},
	{
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "black",
		},
	},
	{
		provider = "git_diff_changed",
		hl = {
			fg = "orange",
			bg = "black",
		},
	},
	{
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "black",
		},
		right_sep = {
			str = " ",
			hl = {
				fg = "NONE",
				bg = "black",
			},
		},
	},
	{},
}

M.active[2] = {
	{

		provider = function()
			return gps.get_location()
		end,
		enabled = function()
			return gps.is_available()
		end,
	},
}

M.active[3] = {
	{
		icon = "  ",
		provider = "diagnostic_errors",
		hl = "DiagnosticError",
	},
	{
		icon = "  ",
		provider = "diagnostic_warnings",
		hl = "DiagnosticWarn",
	},
	{
		icon = "  ",
		provider = "diagnostic_hints",
		hl = "DiagnosticHint",
	},
	{
		icon = "  ",
		provider = "diagnostic_info",
		hl = "DiagnosticInfo",
	},
	{
		provider = "position",
		right_sep = " ",
		left_sep = "   ",
	},
}

require("feline").setup({
	components = M,
})
