require("todo-comments").setup({
	highlight = {
		pattern = [[.*<(KEYWORDS)\s*]],
	},
	pattern = [[\b(KEYWORDS)]], -- ripgrep regex
})
