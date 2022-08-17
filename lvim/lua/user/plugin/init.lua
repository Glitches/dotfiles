-- Additional Plugins
lvim.plugins = {
	-- Themes
	{ "folke/tokyonight.nvim" },
	{ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } },
	{ "sainnhe/sonokai" },
	--Trouble diagnostics and more
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	-- TODO and keywords in comment highlight
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = require("user.plugin.todocomments").config,
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = require("user.plugin.nvim-hop").config,
	},
	{
		"aserowy/tmux.nvim",
		config = require("user.plugin.nvim-tmux").config,
	},
	-- Null_ls typescript utils
	{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
	-- Git diff view
	{ "sindrets/diffview.nvim", event = "BufRead" },
	-- Rainbow parentheses
	{
		"p00f/nvim-ts-rainbow",
	},
	-- Get color representation of RGB codes
	{
		"norcalli/nvim-colorizer.lua",
		config = require("user.plugin.colorizer").config,
	},

	-- Advanced code refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		config = require("user.plugin.refactor").config,
		requires = {
			{ "nvi-rua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- emmet support
	{ "mattn/emmet-vim" },
	-- Shows indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = require("user.plugin.blankline").config,
	},
	-- An organizer like notion (uses neorg files)?
	{
		"nvim-neorg/neorg",
		config = require("user.plugin.norg").config,
		requires = "nvim-lua/plenary.nvim",
	},
}
