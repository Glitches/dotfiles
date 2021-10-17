local u = require("utils")

vim.g.yoinkMoveCursorToEndOfPaste = true
vim.g.yoinkIncludeDeleteOperations = true
vim.g.yoinkSyncSystemClipboardOnFocus = 0
vim.g.clipboard = "xclip"

local opts = { noremap = false }

u.map("n", "[y", "<Plug>(YoinkPostPasteSwapBack)", opts)
u.map("n", "]y", "<Plug>(YoinkPostPasteSwapForward)", opts)

u.map("n", "y", "<Plug>(YoinkYankPreserveCursorPosition)", opts)
u.map("x", "y", "<Plug>(YoinkYankPreserveCursorPosition)", opts)
