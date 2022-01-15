-- Built-in plugin settings
lvim.builtin.dashboard.active = true

lvim.builtin.notify.active = true

lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.telescope.defaults.initial_mode = "insert"
lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.prompt_position = "bottom"
lvim.builtin.telescope.defaults.layout_config.vertical.mirror = false
lvim.builtin.telescope.defaults.layout_config.width = 0.90
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"

lvim.builtin.terminal.active = true

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow = {
	enable = true,
	extended_mode = true,
	colors = {
		"#3d59a1",
		"#7dcfff",
		"#ff9e64",
		"#1abc9c",
		"#bb9af7",
		"#24283b",
	},
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- If you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"java",
	"yaml",
	"norg",
	"norg_meta",
	"norg_table",
}
