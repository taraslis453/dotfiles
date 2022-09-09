local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		-- path_display = { "smart" },

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				-- <C-i>
				["<Tab>"] = actions.select_horizontal,
				["<C-s>"] = actions.select_vertical,
			},

			n = {
				["<esc>"] = actions.close,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<CR>"] = actions.select_default,
				["<Tab>"] = actions.select_horizontal,
				["<C-s>"] = actions.select_vertical,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		git_status = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
		oldfiles = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
		},
		lsp_references = {
			theme = "dropdown",
			path_display = { "smart" },
		},
	},
})
telescope.load_extension("fzf")
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>t", ":Telescope git_status<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>p", ":Telescope projects theme=dropdown<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>r", ":Telescope oldfiles<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>v", ":Telescope buffers<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>s", ":SearchSession<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references<cr>", opts)
