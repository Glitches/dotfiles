local formatter = require("formatter")

local prettier_format = function()
    return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
        stdin = true
    }
end

local eslint_format = function()
    return {
        exe = "eslint_d",
        args = { '--stdin', '--stdin-filename', vim.api.nvim_buf_get_name(0), '--fix-to-stdout' },
        stdin = true
    }
end

formatter.setup(
  {
    logging = true,
    filetype = {
            typescriptreact = { prettier_format, eslint_format },
            typescript = { prettier_format, eslint_format },
            javascript = { prettier_format, eslint_format },
            javascriptreact = { prettier_format, eslint_format },
            json = { prettier_format },
    }
  }
)

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.ts,*.tsx,*.jsx,*.js,*.rs FormatWrite
augroup END
]], true)
 
