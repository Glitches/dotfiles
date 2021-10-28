local buftabline = require("buftabline")
local u = require("utils")

local options = {
	tab_format = " #{n}: #{b}#{f} #{i} ",
	buffer_id_index = true,
	icon_colors = true,
	start_hidden = false,
	auto_hide = false,
	disable_commands = false,
	go_to_maps = true,
	flags = {
		modified = "[+]",
		not_modifiable = "[-]",
		readonly = "[RO]",
	},
	hlgroups = {
		current = "TabLineSel",
		normal = "TabLine",
		active = nil,
		spacing = nil,
		modified_current = nil,
		modified_normal = nil,
		modified_active = nil,
	},
}

buftabline.setup(options)

buftabline.map({ prefix = "<Leader>c", cmd = "bdelete" })
buftabline.map({ prefix = "<Leader>v", cmd = "vertical sb" })

u.nmap("<C-n>", ":BufPrev<CR>")
u.nmap("<C-p>", ":BufNext<CR>")
