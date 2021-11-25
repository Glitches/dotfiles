local u = require("utils")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.g.mapleader = ","

vim.opt.completeopt = { "menuone", "noinsert" }
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 2
vim.opt.cursorline = true
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 300
vim.opt.shortmess:append("cA")
vim.opt.clipboard:append("unnamedplus")

_G.global = {}

-- maps
-- \ to go to previous match
u.nmap("\\", ",")

-- make useless keys useful
u.nmap("<BS>", "<C-^>")

u.nmap("<Esc>", ":nohl<CR>")

u.nmap("<Tab>", "%", { noremap = false })
u.xmap("<Tab>", "%", { noremap = false })
u.omap("<Tab>", "%", { noremap = false })

u.imap("<S-Tab>", "<Esc>A")
u.nmap("<S-CR>", ":wqall<CR>")

u.nmap("H", "^")
u.omap("H", "^")
u.xmap("H", "^")
u.nmap("L", "$")
u.omap("L", "$")
u.xmap("L", "$")

u.nmap("<Space>", ":", { silent = false })
u.xmap("<Space>", ":", { silent = false })

-- misc
u.xmap(">", ">gv")
u.xmap("<", "<gv")

u.nmap("n", "nzz")
u.nmap("N", "Nzz")

u.nmap("k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], { expr = true })
u.nmap("j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], { expr = true })

-- nvim-tree
u.nmap("<C-n>", ":NvimTreeToggle<CR>")
u.nmap("<leader>r", ":NvimTreeRefresh<CR>")
u.nmap("<leader>n", ":NvimTreeFindFile<CR>")

require("commands")
require("plugins")
require("tmux")
require("lsp")
require("lsp")
