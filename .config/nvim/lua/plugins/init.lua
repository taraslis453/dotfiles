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
		{
			"abecodes/tabout.nvim",
			config = function()
				require("tabout").setup()
			end,
			wants = { "nvim-treesitter" },
		},
	})

	-- UI
	require("plugins.config.bufferline")
	require("plugins.config.lualine")
	require("plugins.config.project")
	require("plugins.config.alpha")
	require("plugins.config.toggleterm")
	require("plugins.config.marks")
	use({
		"akinsho/bufferline.nvim",
		"nvim-lualine/lualine.nvim",
		{
			"ahmedkhalf/project.nvim",
			wants = { "telescope" },
		},
		"goolord/alpha-nvim",
		{
			"anuvyklack/pretty-fold.nvim",
			config = function()
				require("pretty-fold").setup({})
				require("pretty-fold.preview").setup()
			end,
		},
		"kevinhwang91/nvim-bqf",
		"akinsho/toggleterm.nvim",
		"chentau/marks.nvim",
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

		-- UI
		"ray-x/lsp_signature.nvim",
		"rmagatti/goto-preview",
		"folke/trouble.nvim",
		{
			"CosmicNvim/cosmic-ui",
			requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		},
	})

	-- Completion
	require("plugins.config.cmp")
	use({
		"hrsh7th/nvim-cmp", -- The completion plugin
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		"hrsh7th/cmp-nvim-lsp",

		"L3MON4D3/LuaSnip", --snippet engine
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
	})

	-- Git
	require("plugins.config.gitsigns")
	require("plugins.config.diffview")
	use({ "lewis6991/gitsigns.nvim", "sindrets/diffview.nvim" })

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
