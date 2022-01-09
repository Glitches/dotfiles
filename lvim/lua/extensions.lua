local P = {
	-- themes
	{ "folke/tokyonight.nvim" },
	{ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } },
	{ "rebelot/kanagawa.nvim" },
	-- trouble diagnostics display
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	-- null_ls typescript utils
	{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
	{ "sindrets/diffview.nvim", event = "BufRead" },
	-- rainbow parentheses
	{
		"p00f/nvim-ts-rainbow",
	},
	-- xml/html tag autoclose
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"typescriptreact.tsx",
					"svelte",
					"vue",
				},
				skip_tags = {
					"area",
					"base",
					"br",
					"col",
					"command",
					"embed",
					"hr",
					"img",
					"slot",
					"input",
					"keygen",
					"link",
					"meta",
					"param",
					"source",
					"track",
					"wbr",
					"menuitem",
				},
			})
		end,
	},
	-- emmet support
	{ "mattn/emmet-vim" },
	-- shows indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.opt.list = true
			vim.opt.listchars:append("space:⋅")
			-- 	vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			-- 	vim.g.indent_blankline_show_trailing_blankline_indent = false
			-- 	vim.g.indent_blankline_show_first_indent_level = true
			vim.g.indent_blankline_space_char_blankline = " "
			vim.g.indent_blankline_show_current_context = true
			vim.g.indent_blankline_show_current_context_start = true
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
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
	-- show function signature during write
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "InsertEnter",
	},
	-- fast scroll
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end,
	},
	-- an organizer like notion (uses neorg files)?
	{
		"nvim-neorg/neorg",
		config = function()
			require("neorg").setup({
				-- Tell Neorg what modules to load
				load = {
					["core.defaults"] = {}, -- Load all the default modules
					["core.norg.concealer"] = {}, -- Allows for use of icons
					["core.norg.dirman"] = { -- Manage your directories with Neorg
						config = {
							workspaces = {
								my_workspace = "~/neorg",
							},
						},
					},
					["core.norg.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
				},
			})
		end,
		requires = "nvim-lua/plenary.nvim",
	},
}

return P
