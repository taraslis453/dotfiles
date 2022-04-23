vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

require("auto-session").setup({
	auto_session_enable_last_session = true,
	auto_save_enabled = true,
	auto_restore_enabled = true,
	auto_session_create_enabled = true,

	pre_save_cmds = { "tabdo NvimTreeClose" },
})

require("session-lens").setup({
	path_display = { "shorten" },
})
vim.cmd([[
    autocmd VimLeavePre * silent! :SaveSession
]])
