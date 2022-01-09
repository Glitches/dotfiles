local api = vim.api

local ts_utils_settings = {
	debug = false,
	auto_inlay_hints = true,
	inlay_hints_highlight = "Comment",
	enable_import_on_completion = true,
	-- import all
	import_all_timeout = 5000, -- ms
	-- lower numbers = higher priority
	import_all_priorities = {
		same_file = 1, -- add to existing import statement
		local_files = 2, -- git files or files with relative path markers
		buffer_content = 3, -- loaded buffer content
		buffers = 4, -- loaded buffer names
	},
	import_all_scan_buffers = 100,
	import_all_select_source = false,
	eslint_bin = "eslint_d",
	eslint_enable_diagnostics = true,
	eslint_opts = {
		condition = function(utils)
			return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json")
		end,
		diagnostics_format = "#{m} [#{c}]",
	},
	enable_formatting = true,
	formatter = "eslint_d",
	update_imports_on_move = true,
	-- filter out dumb module warning
	filter_out_diagnostics_by_code = { 80001 },
}

local opts = {
	init_options = require("nvim-lsp-ts-utils").init_options,
	single_file_support = true,
	root_dir = function(fname)
		return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname) -- or vim.fn.getcwd()
	end,
	on_attach = function(client, bufnr)
		require("lsp_signature").on_attach()

		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup(ts_utils_settings)
		ts_utils.setup_client(client)

		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		--buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)
		--Enable completion triggered by <c-x><c-o>
		api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
}
-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("tsserver", opts)
