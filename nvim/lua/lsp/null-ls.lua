local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.prettierd.with({
		filetypes = { "html", "json", "yaml", "markdown", "typescript", "typescriptreact", "svelte" },
	}),
	b.formatting.stylua,
	b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
	b.formatting.shfmt,
	b.diagnostics.write_good,
	b.diagnostics.markdownlint,
	b.diagnostics.teal,
	b.diagnostics.stylua,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
	b.code_actions.gitsigns,
}

local M = {}
M.setup = function(on_attach)
	null_ls.config({
		debug = true,
		sources = sources,
	})
	lspconfig["null-ls"].setup({ on_attach = on_attach })
end

return M
