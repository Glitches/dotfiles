local M = {}

M.config = function()
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
end

return M
