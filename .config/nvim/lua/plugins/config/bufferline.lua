local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end
local groups = require("bufferline.groups")

bufferline.setup({
	options = {
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		indicator_icon = "▎",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "Directory",
				text_align = "center",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "Directory",
				text_align = "center",
				padding = 1,
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		groups = {
			groups.builtin.ungrouped,
			items = {
				{
					name = "d",
					matcher = function(buf)
						return buf.path:match("domain")
					end,
					priority = 1,
				},
				{
					name = "c",
					matcher = function(buf)
						return buf.path:match("controller")
					end,
					priority = 2,
				},
				{
					name = "r",
					matcher = function(buf)
						return buf.path:match("repository")
					end,
					priority = 3,
				},
				{
					name = "a",
					matcher = function(buf)
						if not buf.filename:match("api") then
							return buf.path:match("api")
						end
					end,
					priority = 4,
				},
				{
					name = "s",
					matcher = function(buf)
						return buf.path:match("service")
					end,
					priority = 5,
				},
				{
					name = "shared",
					matcher = function(buf)
						return buf.path:match("shared")
					end,
				},
				{
					name = "entities",
					matcher = function(buf)
						return buf.path:match("entities")
					end,
				},
				{
					name = "features",
					matcher = function(buf)
						return buf.path:match("features")
					end,
				},
				{
					name = "widgets",
					matcher = function(buf)
						return buf.path:match("widgets")
					end,
				},
				{
					name = "pages",
					matcher = function(buf)
						return buf.path:match("pages")
					end,
				},
				{
					name = "app",
					matcher = function(buf)
						return buf.path:match("app")
					end,
				},
			},
		},
	},
	highlights = {
		error = {
			guifg = { attribute = "fg", highlight = "DiagnosticError" },
			gui = "none",
		},
		error_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticError" },
			gui = "bold,italic",
		},
		error_diagnostic_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticError" },
			gui = "bold,italic",
		},
		error_diagnostic = {
			guifg = { attribute = "fg", highlight = "DiagnosticError" },
			gui = "none",
		},
		error_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticError" },
			gui = "none",
		},
		error_diagnostic_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticError" },
			gui = "none",
		},

		warning = {
			guifg = { attribute = "fg", highlight = "DiagnosticWarn" },
			gui = "none",
		},
		warning_diagnostic = {
			guifg = { attribute = "fg", highlight = "DiagnosticWarn" },
			gui = "none",
		},
		warning_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticWarn" },
			gui = "bold,italic",
		},
		warning_diagnostic_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticWarn" },
			gui = "bold,italic",
		},
		warning_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticWarn" },
			gui = "none",
		},
		warning_diagnostic_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticWarn" },
			gui = "none",
		},

		info = {
			guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
			gui = "none",
		},
		info_diagnostic = {
			guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
			gui = "none",
		},
		info_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
			gui = "bold,italic",
		},
		info_diagnostic_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
			gui = "bold,italic",
		},
		info_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
			gui = "none",
		},
		info_diagnostic_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
			gui = "none",
		},

		hint = {
			guifg = { attribute = "fg", highlight = "DiagnosticHint" },
			gui = "none",
		},
		hint_diagnostic = {
			guifg = { attribute = "fg", highlight = "DiagnosticHint" },
			gui = "none",
		},
		hint_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticHint" },
			gui = "bold,italic",
		},
		hint_diagnostic_selected = {
			guifg = { attribute = "fg", highlight = "DiagnosticHint" },
			gui = "bold,italic",
		},
		hint_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticHint" },
			gui = "none",
		},
		hint_diagnostic_visible = {
			guifg = { attribute = "fg", highlight = "DiagnosticHint" },
			gui = "none",
		},
	},
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<A-,>", ":BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-.>", ":BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<A->>", ":BufferLineMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-<>", ":BufferLineMovePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>bl", ":BufferLineCloseLeft<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>br", ":BufferLineCloseRight<CR>", opts)

-- vim-bye plugin
vim.api.nvim_set_keymap("n", "<A-c>", ":Bdelete<CR>", opts)

vim.api.nvim_set_keymap("n", "<C-s>", ":BufferLinePick<CR>", opts)
