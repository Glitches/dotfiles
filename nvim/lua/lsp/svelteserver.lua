local lspconfig = require("lspconfig")
local u = require("utils")

local M = {}
M.setup = function(on_attach, capabilities)
	lspconfig.svelte.setup({
		capabilities = capabilities,
		filetypes = { "html", "svelte" },
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			on_attach(client, bufnr)

			u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
			u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
			u.buf_map("n", "go", ":TSLspImportAll<CR>", nil, bufnr)
			u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
			u.buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)

			vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		end,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

return M
