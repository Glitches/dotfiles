local lspconfig = require("lspconfig")

local M = {}
M.setup = function(on_attach, capabilities)
	lspconfig.yamlls.setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			on_attach(client, bufnr)
		end,
	})
end

return M
