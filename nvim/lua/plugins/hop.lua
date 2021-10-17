local u = require("utils")

require("hop").setup()

u.nmap("q", ":HopChar1<CR>")
u.omap("q", ":HopChar1<CR>")
-- command doesn't work in visual mode
u.map("v", "q", '<cmd> lua require("hop").hint_char1()<CR>')

u.nmap("Q", "q")
