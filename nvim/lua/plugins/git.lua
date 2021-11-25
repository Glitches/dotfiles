local u = require("utils")

require("gitsigns").setup()

-- allows opening files from lazygit in the same neovim instance
vim.env["GIT_EDITOR"] = "nvr --remote-wait"

-- for lazy plugin
u.nmap("<Leader>gg", ":LazyGit<CR>")
