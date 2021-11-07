local indent = require("indent_blankline")

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

indent.setup({
	space_char_blankline = " ",
	show_current_context = true,
})
