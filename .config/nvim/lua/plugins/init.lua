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
		"tpope/vim-surround",
	})

	-- Motion
	require("plugins.config.hop")
	require("plugins.config.quickscope")
	require("plugins.config.wordmotion")
	use({
		"phaazon/hop.nvim",
		"unblevable/quick-scope",
		"chaoren/vim-wordmotion",
	})

	-- UI
	require("plugins.config.bufferline")
	require("plugins.config.project")
	require("plugins.config.feline")
	require("plugins.config.alpha")
	require("plugins.config.toggleterm")
	require("plugins.config.lightbulb")
	use({
		"kosayoda/nvim-lightbulb",
		"akinsho/bufferline.nvim",
		"feline-nvim/feline.nvim",
		{
			"ahmedkhalf/project.nvim",
			wants = { "telescope" },
		},
		"goolord/alpha-nvim",
		"kevinhwang91/nvim-bqf",
		"akinsho/toggleterm.nvim",
	})

	-- Code reading
	require("plugins.config.colorscheme")
	require("plugins.config.colorizer")
	use({
		"navarasu/onedark.nvim",
		"norcalli/nvim-colorizer.lua",
	})

	-- Treesitter
	require("plugins.config.treesitter")
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
		-- show context in statusline
		{
			"SmiteshP/nvim-gps",
			config = function()
				require("nvim-gps").setup()
			end,
		},
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
		"ray-x/lsp_signature.nvim",
		"folke/trouble.nvim",
		{
			"CosmicNvim/cosmic-ui",
			requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		},
		{
			"narutoxy/dim.lua",
			requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
			config = function()
				require("dim").setup()
			end,
		},
	})

	-- Completion
	require("plugins.config.cmp")
	use({
		{
			"hrsh7th/nvim-cmp", -- The completion plugin
			commit = "dd6e4d96f9e376c87302fa5414556aa6269bf997",
		},
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		"hrsh7th/cmp-nvim-lsp",
		{ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" },

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
	require("plugins.config.octo")
	use({
		{
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
		},
		"lewis6991/gitsigns.nvim",
		"sindrets/diffview.nvim",
	})
	require("plugins.config.dap")
	use({ "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" })
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
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
