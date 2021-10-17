local u = require("utils")

require("gitsigns").setup()

-- allows opening files from lazygit in the same neovim instance
vim.env["GIT_EDITOR"] = "nvr --remote-wait"

u.nmap("<Leader>g", ":term lazygit<CR>")
