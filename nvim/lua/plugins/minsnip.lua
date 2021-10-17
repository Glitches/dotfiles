local minsnip = require("minsnip")

local u = require("utils")

minsnip.setup(require("snippets"))

_G.global.tab_complete = function()
    if not minsnip.jump() then
        if vim.fn.pumvisible() == 1 then
            u.input("<C-y>")
        elseif vim.opt_local.omnifunc ~= "" then
            u.input("<C-x><C-o>")
        else
            u.input("<C-n>")
        end
    end
end

u.map("i", "<Tab>", "<cmd> lua global.tab_complete()<CR>")
