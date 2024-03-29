local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
	return
end

local cb = require("diffview.config").diffview_callback
local actions = require("diffview.actions")
diffview.setup({
	diff_binaries = false, -- Show diffs for binaries
	use_icons = true, -- Requires nvim-web-devicons
	file_panel = {
		win_config = {
			width = 35,
		},
	},
	view = {
		merge_tool = {
			layout = "diff3_mixed",
			disable_diagnostics = false,
		},
	},
	key_bindings = {
		disable_defaults = false, -- Disable the default key bindings
		-- The `view` bindings are active in the diff buffers, only when the current
		-- tabpage is a Diffview.
		view = {
			["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
			["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
			["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
			["<leader>b"] = cb("toggle_files"), -- Toggle the files panel.
			["g<C-x>"] = cb("cycle_layout"),
			["[x"] = actions.prev_conflict,
			["]x"] = actions.next_conflict,
			["gco"] = actions.conflict_choose("ours"),
			["gct"] = actions.conflict_choose("theirs"),
			["gcb"] = actions.conflict_choose("base"),
			["gca"] = actions.conflict_choose("all"),
			["gcn"] = actions.conflict_choose("none"),
		},
		file_panel = {
			["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
			["<down>"] = cb("next_entry"),
			["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
			["<up>"] = cb("prev_entry"),
			["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
			["o"] = cb("select_entry"),
			["<2-LeftMouse>"] = cb("select_entry"),
			["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
			["S"] = cb("stage_all"), -- Stage all entries.
			["U"] = cb("unstage_all"), -- Unstage all entries.
			["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
			["<tab>"] = cb("select_next_entry"),
			["<s-tab>"] = cb("select_prev_entry"),
			["<leader>e"] = cb("focus_files"),
			["<leader>b"] = cb("toggle_files"),
		},
	},
})
vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dc", ":DiffviewClose<cr>", { noremap = true, silent = true })
