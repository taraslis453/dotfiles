require("git-conflict").setup({
	default_mappings = false, -- disable buffer local mapping created by this plugin
	disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "DiffText",
		current = "DiffAdd",
	},
})
vim.keymap.set("n", "gco", "<Plug>(git-conflict-ours)")
vim.keymap.set("n", "gcp", "<Plug>(git-conflict-both)")
vim.keymap.set("n", "gc0", "<Plug>(git-conflict-none)")
vim.keymap.set("n", "gct", "<Plug>(git-conflict-theirs)")
vim.keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)")
vim.keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)")
