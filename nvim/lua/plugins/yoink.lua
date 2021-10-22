local u = require("utils")

vim.g.yoinkMoveCursorToEndOfPaste = true
vim.g.yoinkIncludeDeleteOperations = 1
vim.g.yoinkSyncSystemClipboardOnFocus = 0

local opts = { noremap = false }

u.map("n", "[y", "<Plug>(YoinkPostPasteSwapBack)", opts)
u.map("n", "]y", "<Plug>(YoinkPostPasteSwapForward)", opts)

u.map("n", "y", "<Plug>(YoinkYankPreserveCursorPosition)", opts)
u.map("x", "y", "<Plug>(YoinkYankPreserveCursorPosition)", opts)
