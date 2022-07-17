-- caching loading plugins
require("plugins.config.impatient")
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself

	require("plugins.config.noclc")
	-- Utils
	use({
		"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
		"moll/vim-bbye",
		{
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup()
			end,
		},
		"folke/which-key.nvim",
		"lewis6991/impatient.nvim",
		{
			"rmagatti/session-lens",
			requires = { "rmagatti/auto-session" },
			config = function()
				require("plugins.config.session")
			end,
		},
		"Pocco81/NoCLC.nvim",
	})

	-- File explorer
	require("plugins.config.nvim-tree")
	require("plugins.config.telescope")
	require("plugins.config.todo-comments")
	use({
		{
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icon
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
		},
		"folke/todo-comments.nvim",
	})

	-- Editing
	require("plugins.config.autopairs")
	require("plugins.config.comment")
	use({
		"windwp/nvim-autopairs",
		"numToStr/Comment.nvim",
		"tpope/vim-repeat",
		{
			"kylechui/nvim-surround",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},
	})

	-- Motion
	require("plugins.config.hop")
	require("plugins.config.quickscope")
	require("plugins.config.wordmotion")
	use({
		{
			"phaazon/hop.nvim",
			commit = "b93ed4cea9c7df625d04e41cb15370b5c43cb578",
		},
		"unblevable/quick-scope",
		"chaoren/vim-wordmotion",
	})

	-- UI
	require("plugins.config.lsp.dressing")
	require("plugins.config.bufferline")
	require("plugins.config.project")
	require("plugins.config.lualine")
	require("plugins.config.alpha")
	require("plugins.config.toggleterm")
	require("plugins.config.lightbulb")
	use({
		"stevearc/dressing.nvim",
		"kosayoda/nvim-lightbulb",
		"nvim-lualine/lualine.nvim",
		{
			"ahmedkhalf/project.nvim",
			wants = { "telescope" },
		},
		"goolord/alpha-nvim",
		"kevinhwang91/nvim-bqf",
		"akinsho/toggleterm.nvim",
		{
			"akinsho/bufferline.nvim",
		},
	})

	-- Code reading
	require("plugins.config.colorscheme")
	require("plugins.config.colorizer")
	use({
		"projekt0n/github-nvim-theme",
		"norcalli/nvim-colorizer.lua",
	})

	-- Treesitter
	require("plugins.config.treesitter")
	require("hlargs").setup()
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		},
		"nvim-treesitter/playground",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"RRethy/nvim-treesitter-textsubjects",
		"nvim-treesitter/nvim-treesitter-refactor",
		"p00f/nvim-ts-rainbow",
		"nvim-treesitter/nvim-treesitter-context",

		"m-demare/hlargs.nvim",
	})

	-- LSP
	require("plugins.config.lsp.init")
	use({
		"neovim/nvim-lspconfig", -- enable LSP
		"williamboman/nvim-lsp-installer", -- simple to use language server installer
		"tamago324/nlsp-settings.nvim", -- language server settings defined in json for
		"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
		"simrat39/symbols-outline.nvim",
		"jose-elias-alvarez/nvim-lsp-ts-utils",

		-- UI
		"folke/trouble.nvim",
		"MunifTanjim/nui.nvim",
		"lukas-reineke/indent-blankline.nvim",
		{
			"narutoxy/dim.lua",
			requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
			config = function()
				require("dim").setup()
			end,
		},

		-- show context in statusline
		{
			"SmiteshP/nvim-navic",
			requires = "neovim/nvim-lspconfig",
		},
	})

	-- Completion
	require("plugins.config.cmp")
	use({
		{
			"hrsh7th/nvim-cmp", -- The completion plugin
		},
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		"hrsh7th/cmp-nvim-lsp",

		"L3MON4D3/LuaSnip", --snippet engine
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		{
			"github/copilot.vim",
			config = function()
				vim.g.copilot_no_tab_map = true
				vim.g.copilot_assume_mapped = true
				vim.g.copilot_tab_fallback = ""
			end,
		},
	})

	-- Git
	require("plugins.config.gitsigns")
	require("plugins.config.diffview")
	require("plugins.config.git-conflict")
	require("plugins.config.octo")
	use({
		{
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			commit = "7919cca0b55830c0fdc1193ebeb6e11a893087a2",
		},
		{
			"akinsho/git-conflict.nvim",
		},
		"lewis6991/gitsigns.nvim",
		"sindrets/diffview.nvim",
	})

	-- Debugging / testing
	require("plugins.config.dap")
	require("plugins.config.neotest")
	use({ "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui", "leoluz/nvim-dap-go", "theHamsta/nvim-dap-virtual-text" })
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",

			"nvim-neotest/neotest-go",
		},
	})

	-- Database
	-- TODO: migrate to this
	-- use({
	-- 	"kristijanhusak/vim-dadbod-ui",
	-- 	"tpope/vim-dadbod",
	-- 	"kristijanhusak/vim-dadbod-completion",
	-- })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
