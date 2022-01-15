-- Requre config files
-- Mappings
require("user.mappings")
-- Parsers additional config
require("user.parsers")
-- User setting for builtin plugins
require("user.builtin")
-- Plugin list
require("user-plugins")
-- Lsp tsserver config
require("lsp.tsserver")
-- Set luasnip personal snippets folder
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lvim/snips" })

-- General settings
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"

lvim.lsp.diagnostics.float.border = "none"

vim.opt.timeoutlen = 500
vim.opt.listchars:append("space:⋅")
vim.opt.list = true

-- eneric LSP settings
-- Set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "write_good", filetypes = { "markdown" } },
	{
		exe = "eslint_d",
		filetypes = { "svelte", "typescript", "typescriptreact", "typescriptreact.tsx", "typescript.ts" },
	},
})

-- Set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "shfmt", filetypes = { "lua" } },
	{
		exe = "prettier",
		args = { "--print-with", "100" },
		filetypes = {
			"html",
			"json",
			"yaml",
			"markdown",
			"typescript",
			"typescriptreact",
			"typescript.ts",
			"typescriptreact.tsx",
			"svelte",
		},
	},
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
