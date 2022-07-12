local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end
nvim_tree.setup({
	respect_buf_cwd = true,
	disable_netrw = true,
	hijack_netrw = false,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = true,
			list = {
				{ key = "s", action = "vsplit" },
				{ key = "i", action = "split" },
				{ key = "t", action = "tabnew" },
				{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
				{ key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
				{ key = "[g", action = "prev_git_item" },
				{ key = "]g", action = "next_git_item" },
				{ key = "<", action = "prev_sibling" },
				{ key = ">", action = "next_sibling" },
				{ key = "P", action = "parent_node" },
				{ key = "<Tab>", action = "preview" },
				{ key = "K", action = "first_sibling" },
				{ key = "J", action = "last_sibling" },
				{ key = "I", action = "toggle_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "R", action = "refresh" },
				{ key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "D", action = "trash" },
				{ key = "r", action = "rename" },
				{ key = "<C-r>", action = "full_rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "y", action = "copy_name" },
				{ key = "Y", action = "copy_path" },
				{ key = "gy", action = "copy_absolute_path" },
				{ key = "-", action = "dir_up" },
				{ key = "q", action = "close" },
				{ key = "g?", action = "toggle_help" },
				{ key = "W", action = "collapse_all" },
			},
		},
		number = false,
		relativenumber = false,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	renderer = {
		icons = {
			webdev_colors = true,
			padding = " ",
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					deleted = "",
					untracked = "",
					ignored = "",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
		highlight_git = true,
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
	},
	actions = {
		open_file = {
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "HLJKFQDS",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
})

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFile<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>r", ":NvimTreeRefresh<CR>", opts)
