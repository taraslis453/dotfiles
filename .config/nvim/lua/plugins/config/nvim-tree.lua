local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "[g", api.node.navigate.git.prev, opts("Prev Git"))
	vim.keymap.set("n", "]g", api.node.navigate.git.next, opts("Next Git"))
	vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
	vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
end

nvim_tree.setup({
	on_attach = on_attach,
	respect_buf_cwd = true,
	disable_netrw = true,
	hijack_netrw = false,
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
		update_root = true,
		ignore_list = { "toggleterm", "DiffviewFiles" },
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
		side = "left",
		number = false,
		relativenumber = false,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	renderer = {
		indent_width = 2,
		root_folder_label = true,
		icons = {
			webdev_colors = true,
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

local function open_nvim_tree()
	local IGNORED_FT = {
		"startify",
		"dashboard",
		"alpha",
	}
	if vim.tbl_contains(IGNORED_FT) then
		return
	end

	-- always open the tree
	require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFocus<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>r", ":NvimTreeRefresh<CR>", opts)
