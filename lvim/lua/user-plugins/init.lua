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
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = require("user-plugins.todocomments").config,
	},
	{
		"blackCauldron7/surround.nvim",
		config = require("user-plugins.surround").config,
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	-- null_ls typescript utils
	{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
	-- Git diff view
	{ "sindrets/diffview.nvim", event = "BufRead" },
	-- rainbow parentheses
	{
		"p00f/nvim-ts-rainbow",
	},
	-- advanced refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		config = require("user-plugins.refactor").config,
		requires = {
			{ "nvi-rua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- xml/html tag autoclose
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = require("user-plugins.tagsautoclose").config,
	},
	-- emmet support
	{ "mattn/emmet-vim" },
	-- shows indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = require("user-plugins.blankline").config,
	},
	-- An organizer like notion (uses neorg files)?
	{
		"nvim-neorg/neorg",
		config = require("user-plugins.norg").config,
		requires = "nvim-lua/plenary.nvim",
	},
}
