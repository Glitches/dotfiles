local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")

local u = require("utils")
local commands = require("commands")

telescope.setup({
	extensions = {
		fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
	},
	defaults = {
		layout_config = {
			horizontal = { width = 0.9 },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--ignore",
			"--hidden",
			"-g",
			"!.git",
		},
		mappings = {
			i = {
				["<Esc>"] = require("telescope.actions").close,
				["<C-u>"] = false,
				["<c-t>"] = trouble.open_with_trouble,
			},
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
})

telescope.load_extension("fzf")

_G.global.telescope = {
	-- try git_files and fall back to find_files
	find_files = function()
		local set = require("telescope.actions.set")
		local builtin = require("telescope.builtin")

		local current = vim.api.nvim_get_current_buf()
		local opts = {
			attach_mappings = function(_, map)
				map("i", "<C-v>", function(prompt_bufnr)
					set.edit(prompt_bufnr, "Vsplit")
				end)

				-- replace current buffer
				map("i", "<C-r>", function(prompt_bufnr)
					set.edit(prompt_bufnr, "edit")
					commands.bdelete(current)
				end)

				-- close all other buffers
				map("i", "<C-x>", function(prompt_bufnr)
					set.edit(prompt_bufnr, "edit")
					commands.bonly()
				end)

				-- edit file and matching test file in split
				map("i", "<C-f>", function(prompt_bufnr)
					set.edit(prompt_bufnr, "edit")
					commands.edit_test_file("Vsplit", function()
						vim.cmd("wincmd w")
					end)
				end)

				return true
			end,
		}

		local is_git_project = pcall(builtin.git_files, opts)
		if not is_git_project then
			builtin.find_files(opts)
		end
	end,
}

u.lua_command("Files", "global.telescope.find_files()")
u.command("Rg", "Telescope live_grep")
u.command("BLines", "Telescope current_buffer_fuzzy_find")
u.command("Buffers", "Telescope buffers")
u.command("BCommits", "Telescope git_bcommits")
u.command("Commits", "Telescope git_commits")
u.command("HelpTags", "Telescope help_tags")
u.command("ManPages", "Telescope man_pages")
u.command("History", "Telescope oldfiles")

u.nmap("<Leader>ff", "<cmd>Files<CR>")
u.nmap("<Leader>fg", "<cmd>Rg<CR>")
u.nmap("<Leader>fl", "<cmd>BLines<CR>")
u.nmap("<Leader>fb", "<cmd>Buffers<CR>")
u.nmap("<Leader>fm", "<cmd>BCommits<CR>")
u.nmap("<Leader>fc", "<cmd>Commits<CR>")
u.nmap("<Leader>fo", "<cmd>History<CR>")
u.nmap("<Leader>fh", "<cmd>HelpTags<CR>")
u.nmap("<Leader>fs", "<cmd>LspSym<CR>")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
