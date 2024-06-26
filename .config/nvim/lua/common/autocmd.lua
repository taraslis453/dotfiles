vim.cmd([["
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END

  augroup cursorline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal cursorline
    autocmd WinLeave,BufLeave * setlocal nocursorline
  augroup END
augroup fzf_commands
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <c-j> <down>
  autocmd FileType fzf tnoremap <silent> <buffer> <c-k> <up>
augroup end

""]])

local create_autocmds = require("utils").create_autocmds

-------------------------------------------------------------------------------
------ AUTOCOMMANDS
-------------------------------------------------------------------------------

local BufCheck = vim.api.nvim_create_augroup("bufcheck", { clear = true })
local buffer_dict = {
  BufEnter = {
    {
      group = BufCheck,
      pattern = "*",
      desc = "Update a buffer's contents on focus if it has changed outside of Vim.",
      command = "checktime",
    },
  },
  FocusGained = {
    {
      group = BufCheck,
      pattern = "*",
      desc = "Update a buffer's contents on focus if it has changed outside of Vim.",
      command = "checktime",
    },
    {
      group = BufCheck,
      pattern = "*",
      desc = "Refresh NvimTree on FocusGained.",
      command = "NvimTreeRefresh",
    },
  },
  TermClose = {
    {
      group = BufCheck,
      pattern = "*",
      desc = "Refresh NvimTree on TermClose.",
      command = "NvimTreeRefresh",
    },
  },
  FileType = {
    {
      group = BufCheck,
      pattern = { "gitcommit", "gitrebase" },
      command = "startinsert | 1",
    },
  },
}

--
local Filetype = vim.api.nvim_create_augroup("filetype", { clear = true })

local filetype_dict = {
  FileType = {
    -- {
    -- 	group = Filetype,
    -- 	pattern = { "sql", "mysql", "plsql" },
    -- 	desc = "Use dadbod-completion source in nvim-cmp.",
    -- 	callback = function()
    -- 		local cmp_status_ok, cmp = pcall(require, "cmp")
    -- 		if not cmp_status_ok then
    -- 			return
    -- 		end
    -- 		cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    -- 		vim.g.vim_dadbod_completion_mark = "[db]"
    -- 	end,
    -- },
    {
      group = Filetype,
      pattern = { "gitcommit", "gitrebase" },
      command = "startinsert | 1",
    },
  },
}

create_autocmds(buffer_dict)
create_autocmds(filetype_dict)

-------------------------------------------------------------------------------
------ PLUGINS
-------------------------------------------------------------------------------

local alpha_disable_folding = vim.api.nvim_create_augroup("AlphaDisableFolding", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = alpha_disable_folding,
  pattern = "alpha",
  desc = "Disable folding on Alpha buffer.",
  command = "setlocal nofoldenable",
})

local lightbulb_augroup = vim.api.nvim_create_augroup("lightbulb_augroup", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = lightbulb_augroup,
  pattern = "*",
  desc = "Show a lightbulb if a code action is available at the current cursor position.",
  callback = function()
    local status_ok, alpha = pcall(require, "nvim-lightbulb")
    if not status_ok then
      return
    end
    require("nvim-lightbulb").update_lightbulb()
  end,
})
