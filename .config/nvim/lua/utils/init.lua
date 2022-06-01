local M = {}

local _, api = vim.cmd, vim.api

--- create_autocmds: creates autocommands from a table
---@param dict table
function M.create_autocmds(dict)
	for event, opt_tbls in pairs(dict) do
		for _, opt_tbl in pairs(opt_tbls) do
			api.nvim_create_autocmd(event, opt_tbl)
		end
	end
end

return M
