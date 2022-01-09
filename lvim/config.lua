--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

parser_configs.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_configs.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}
-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
vim.opt.timeoutlen = 500
lvim.lsp.diagnostics.float.border = "none"
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Load keybindings config
require("mappings")

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.show_icons.git = 1

--  Add neorg completion
table.insert(lvim.builtin.cmp.sources, { name = "neorg" })

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"norg",
	"norg_meta",
	"norg_table",
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"java",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow = {
	enable = true,
	extended_mode = true,
	max_file_lines = nil,
	colors = {
		"#E06C75",
		"#E5C07B",
		"#98C379",
		"#56B6C2",
		"#61AFEF",
		"#C678DD",
		"#E06C75",
	},
}
-- generic LSP settings
require("typescriptserver")
-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("tsserver", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>

-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
-- 	if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
-- 		return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
-- 			or require("lspconfig/util").path.dirname(fname)
-- 	elseif vim.bo.filetype == "lua" then
-- 		return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or vim.fn.getcwd()
-- 	else
-- 		return require("lspconfig/util").root_pattern("Makefile", ".git")(fname)
-- 			or require("lspconfig/util").path.dirname(fname)
-- 	end
-- end

-- set luasnip personal snippets folder
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lvim/snips" })

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "shfmt", filetypes = { "lua" } },
	{
		exe = "prettier",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		args = { "--print-with", "100" },
		-- args = { api.nvim_buf_get_name(0) },
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "html", "json", "yaml", "markdown", "typescript", "typescriptreact", "svelte" },
	},
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "write_good", filetypes = { "markdown" } },
	{ exe = "eslint_d", filetypes = { "svelte", "typescript", "typescriptreact" } },
})

local plugins_conf = require("extensions")
lvim.plugins = plugins_conf

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
