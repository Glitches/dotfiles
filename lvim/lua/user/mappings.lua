-- Keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- Load keybindings config

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["a"] = {
	name = "+Telescope",
	a = { "<cmd>Telescope<CR>", "Telescope" },
	f = { "<cmd>Telescope git_files<CR>", "Git Files" },
	s = { "<cmd>Telescope git_status<CR>", "Git Status" },
	p = { "<cmd>Telescope projects<CR>", "Projects" },
	t = { "<cmd>Telescope tags<CR>", "Tags" },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- add null-lsp-ts-utils commands to lsp menu
lvim.builtin.which_key.mappings["l"]["o"] = { "<cmd>TSLspOrganize<CR>", "Organize" }
lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>TSLspRenameFile<CR>", "Rename File" }
lvim.builtin.which_key.mappings["l"]["e"] = { "<cmd>TSLspImportAll<CR>", "Import All" }
lvim.builtin.which_key.mappings["l"]["F"] = { "<cmd>TSLspFixCurrent<CR>", "Fix Current" }
lvim.builtin.which_key.mappings["l"]["A"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Float Diagnostics" }

-- Buffer split
lvim.builtin.which_key.mappings["b"]["v"] = { "<cmd>vert belowright sb<CR>", "Split view right" }

-- Cmp completion disambiguate from tmux
lvim.builtin.cmp.mapping["<C-p>"] = require("cmp").mapping.complete()
