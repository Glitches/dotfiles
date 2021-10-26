local feline = require("feline")
local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local cursor = require('feline.providers.cursor')
local file = require('feline.providers.file')

local force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
}

local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local colors = {
    bg = '#24283b',
    black = '#1a1b26',
    cyan = '#73daca', 
    fg = '#a9b1d6',
    green = '#9ece6a',
    yellow = '#e0af68',
    oceanblue = '#7aa2f7',
    magenta = '#bb9af7',
    orange = '#ff9e64',
    red = '#f7768e',
    skyblue = '#7aa2f7', 
    violet = '#bb9af7',
    white = '#cfc9c2',
    dark = '#414868'
}

local vi_mode_colors = {
  NORMAL = 'skyblue',
  OP = 'skyblue',
  INSERT = 'oceanblue',
  VISUAL = 'violet',
  LINES = 'skyblue',
  BLOCK = 'skyblue',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'skyblue',
  SHELL = 'skyblue',
  TERM = 'skyblue',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = 'NORMAL',
  OP = 'OP',
  INSERT = 'INSERT',
  VISUAL = 'VISUAL',
  LINES = 'LINES',
  BLOCK = 'BLOCK',
  REPLACE = 'REPLACE',
  ['V-REPLACE'] = 'V-REPLACE',
  ENTER = 'ENTER',
  MORE = 'MORE',
  SELECT = 'SELECT',
  COMMAND = 'COMMAND',
  SHELL = 'SHELL',
  TERM = 'TERM',
  NONE = 'NONE'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

force_inactive.buftypes = {
  'terminal'
}

-- LEFT
-- vi-mode
components.active[1][1] = {
  provider = function()
    return ' ' .. vi_mode_text[vi_mode_utils.get_vim_mode()] .. ' '
  end,
  hl = function()
    local val = {}

    val.bg = vi_mode_utils.get_mode_color()
    val.fg = 'black'
    val.style = 'bold'

    return val
  end,
  right_sep = ' '
}

-- filename
components.active[1][2] = {
  provider = function()
    return vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.expand("%"), ":~:."))
  end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- gitBranch
components.active[1][3] = {
  provider = 'git_branch',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffAdd
components.active[1][4] = {
  provider = 'git_diff_added',
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffModfified
components.active[1][5] = {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffRemove
components.active[1][6] = {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  }
}

-- MID
-- fill 
components.active[2][1] = {
  provider = ' ',
  hl = {
    fg = 'skyblue',
    bg = 'dark',
  },
  left_sep = ''
}

-- LspName
components.active[2][2] = {
  provider = 'lsp_client_names',
  hl = {
    fg = 'yellow',
    bg = 'dark',
    style = 'bold'
  },
}

-- fill 
components.active[2][3] = {
  provider = ' ',
  hl = {
    fg = 'skyblue',
    bg = 'dark',
  },
}

-- fileType
components.active[2][4] = {
  provider = function ()
    return ' ' .. file.file_type() .. ' ' 
  end,
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require('nvim-web-devicons').get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'dark'
    val.style = 'bold'
    return val
  end,
}

-- fill 
components.active[2][5] = {
  provider = '',
  hl = {
    fg = 'skyblue',
    bg = 'dark',
  },
}

-- fileFormat
components.active[2][6] = {
  provider = function() 
        return ' ' .. vim.bo.fileformat:upper() .. ' ' 
    end,
    enabled = checkwidth(),
  hl = {
    fg = 'white',
    bg = 'dark',
    style = 'bold'
  },
}

-- fill 
components.active[2][7] = {
  provider = '',
  hl = {
    fg = 'skyblue',
    bg = 'dark',
  },
}

-- fileEncode
components.active[2][8] = {
  provider = function ()
      return ' ' .. file.file_encoding():upper() .. ' '
  end,
  hl = {
    fg = 'skyblue',
    bg = 'dark',
    style = 'bold'
  },

}
-- fill 
components.active[3][1] = {
  provider = '',
  hl = {
    fg = 'skyblue',
    bg = 'dark',
  },
}

-- lineInfo
components.active[3][2] = {
  provider = function ()
      return ' :' .. cursor.position():upper() .. ' '
  end,
  hl = {
    fg = 'skyblue',
    bg = 'dark',
    style = 'bold'
  },
}

components.active[3][3]  =   {
    hl = {
        fg = 'skyblue',
        bg = 'dark'
    },
    provider = function ()
       return '' 
    end ,
 }

-- linePercent
components.active[3][4] = {
  provider = ' ' .. cursor.line_percentage():upper() .. ' ',
  hl = {
    fg = 'black',
    bg = 'skyblue',
    style = 'bold'
  },
}

-- scrollBar
components.active[3][5] = {
  provider = 'scroll_bar',
  hl = {
    fg = 'yellow',
    bg = 'skyblue',
  },
}

-- INACTIVE
-- fileType
components.inactive[1][1] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = '',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
    ' '
  }
}

 feline.setup({
  colors = colors,
  default_bg = colors.bg,
  default_fg = colors.fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
 })

