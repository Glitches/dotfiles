local tsserver = require("lsp.tsserver")
local cmp = require("lsp.cmp")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
--vlocal null_ls = require("lsp.null-ls")

local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

local popup_opts = { border = "single", focusable = false }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

_G.global.lsp = {
    popup_opts = popup_opts,
}

local on_attach = function(client, bufnr)
   local buf_map = vim.api.nvim_buf_set_keymap
   vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
   vim.cmd("command! LspDec lua vim.lsp.buf.declaration()")
   vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
   vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
   vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
   vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
   vim.cmd("command! LspOrganize lua lsp_organize_imports()")
   vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
   vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
   vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
   vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
   vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
   vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
   vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
   
   buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
   buf_map(bufnr, "n", "gD", ":LspDec<CR>", {silent = true})
   buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
   buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
   buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
   buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
   buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
   buf_map(bufnr, "n", "<Leader>h", ":LspDiagPrev<CR>", {silent = true})
   buf_map(bufnr, "n", "<Leader>l", ":LspDiagNext<CR>", {silent = true})
   buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
   buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
   buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", {silent = true})

    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
   
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end

cmp.setup()

local capabilities =  require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

tsserver.setup(on_attach, capabilities)
sumneko.setup(on_attach)
-- null_ls.setup(on_attach)
