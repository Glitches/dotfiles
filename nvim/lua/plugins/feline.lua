local feline = require("feline")
local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")
local cursor = require("feline.providers.cursor")
local file = require("feline.providers.file")

local force_inactive = {
	filetypes = {},
	buftypes = {},
	bufnames = {},
}

local components = {
	active = { {}, {}, {} },
	inactive = { {}, {}, {} },
}

local colors = {
	bg = "#3c3836",
	black = "#282828",
	cyan = "#73daca",
	fg = "#ebdbb2",
	green = "#98971a",
	yellow = "#d79921",
	aqua = "#7aa2f7",
	orange = "#fe8019",
	red = "#fb4934",
	blue = "#458588",
	violet = "#b16286",
	white = "#fbf1c7",
	dark = "#32302f",
}

local vi_mode_colors = {
	NORMAL = "orange",
	OP = "orange",
	INSERT = "aqua",
	VISUAL = "violet",
	LINES = "blue",
	BLOCK = "blue",
	REPLACE = "green",
	["V-REPLACE"] = "violet",
	ENTER = "cyan",
	MORE = "cyan",
	SELECT = "red",
	COMMAND = "blue",
	SHELL = "blue",
	TERM = "blue",
	NONE = "yellow",
}

local vi_mode_text = {
	NORMAL = "NORMAL",
	OP = "OP",
	INSERT = "INSERT",
	VISUAL = "VISUAL",
	LINES = "LINES",
	BLOCK = "BLOCK",
	REPLACE = "REPLACE",
	["V-REPLACE"] = "V-REPLACE",
	ENTER = "ENTER",
	MORE = "MORE",
	SELECT = "SELECT",
	COMMAND = "COMMAND",
	SHELL = "SHELL",
	TERM = "TERM",
	NONE = "NONE",
}

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 60 then
		return true
	end
	return false
end

local commonHl = {
	fg = "blue",
	bg = "bg",
}

force_inactive.filetypes = {
	"NvimTree",
	"dbui",
	"packer",
	"startify",
	"fugitive",
	"fugitiveblame",
}

force_inactive.buftypes = {
	"terminal",
}

-- LEFT
-- vi-mode
components.active[1][1] = {
	provider = function()
		return " " .. vi_mode_text[vi_mode_utils.get_vim_mode()] .. " "
	end,
	hl = function()
		local val = {}

		val.bg = vi_mode_utils.get_mode_color()
		val.fg = "black"
		val.style = "bold"

		return val
	end,
	right_sep = " ",
}

-- filename
components.active[1][2] = {
	provider = function()
		return vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.expand("%"), ":~:."))
	end,
	hl = {
		fg = "white",
		bg = "bg",
		style = "bold",
	},
	right_sep = " ",
}
-- gitBranch
components.active[1][3] = {
	provider = "git_branch",
	hl = {
		fg = "yellow",
		bg = "bg",
		style = "bold",
	},
}
-- diffAdd
components.active[1][4] = {
	provider = "git_diff_added",
	hl = {
		fg = "blue",
		bg = "bg",
		style = "bold",
	},
}
-- diffModfified
components.active[1][5] = {
	provider = "git_diff_changed",
	hl = {
		fg = "orange",
		bg = "bg",
		style = "bold",
	},
}
-- diffRemove
components.active[1][6] = {
	provider = "git_diff_removed",
	hl = {
		fg = "red",
		bg = "bg",
		style = "bold",
	},
}

-- MID
-- fill
components.active[2][1] = {
	provider = " ",
	enabled = checkwidth(),
	hl = commonHl,
}

-- LspName
components.active[2][2] = {
	provider = "lsp_client_names",
	enabled = checkwidth(),
	hl = {
		fg = "yellow",
		bg = "bg",
		style = "bold",
	},
}

-- fill
components.active[2][3] = {
	provider = " ",
	hl = commonHl,
}

-- fileType
components.active[2][4] = {
	provider = function()
		return " " .. file.file_type() .. " "
	end,
	hl = function()
		local val = {}
		local filename = vim.fn.expand("%:t")
		local extension = vim.fn.expand("%:e")
		local icon, name = require("nvim-web-devicons").get_icon(filename, extension)
		if icon ~= nil then
			val.fg = vim.fn.synIDattr(vim.fn.hlID(name), "fg")
		else
			val.fg = "white"
		end
		val.bg = "bg"
		val.style = "bold"
		return val
	end,
}

-- fill
components.active[2][5] = {
	provider = "",
	enabled = checkwidth(),
	hl = commonHl,
}

-- fileFormat
components.active[2][6] = {
	provider = function()
		return " " .. vim.bo.fileformat:upper() .. " "
	end,
	enabled = checkwidth(),
	hl = {
		fg = "white",
		bg = "bg",
		style = "bold",
	},
}

-- fill
components.active[2][7] = {
	provider = "",
	hl = commonHl,
}

-- fileEncode
components.active[2][8] = {
	provider = function()
		return " " .. file.file_encoding():upper() .. " "
	end,
	hl = commonHl,
}

-- fill
components.active[2][9] = {
	provider = " ",
	enabled = checkwidth(),
	hl = commonHl,
}

-- fileSize
components.active[2][10] = {
	provider = "file_size",
	enabled = checkwidth(),
	hl = {
		fg = "red",
		bg = "bg",
	},
}

-- fill
components.active[3][1] = {
	provider = "",
	hl = commonHl,
}

-- lineInfo
components.active[3][2] = {
	provider = function()
		return " ☰" .. cursor.position():upper() .. " "
	end,
	hl = commonHl,
}

components.active[3][3] = {
	hl = {
		fg = "orange",
		bg = "bg",
	},
	provider = function()
		return ""
	end,
}

-- linePercent
components.active[3][4] = {
	provider = function()
		return " " .. cursor.line_percentage():upper() .. " "
	end,
	hl = {
		fg = "black",
		bg = "orange",
		style = "bold",
	},
}

-- scrollBar
components.active[3][5] = {
	provider = "scroll_bar",
	hl = {
		fg = "dark",
		bg = "orange",
	},
}

-- INACTIVE
-- fileType
components.inactive[1][1] = {
	provider = function()
		return file.file_type():upper() .. " "
	end,
	hl = {
		fg = "black",
		bg = "orange",
		style = "bold",
	},
	left_sep = {
		str = " ",
		hl = {
			fg = "NONE",
			bg = "orange",
		},
	},
	right_sep = {
		{
			str = "",
			hl = {
				fg = "orange",
				bg = "bg",
			},
		},
		" ",
	},
}

feline.setup({
	colors = colors,
	default_bg = colors.bg,
	default_fg = colors.fg,
	vi_mode_colors = vi_mode_colors,
	components = components,
	force_inactive = force_inactive,
})
