vim.cmd [[packadd packer.nvim]]
  
local packer = require('packer')

return packer.startup(function()
    use({ 'wbthomason/packer.nvim', opt = true })
 
    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end
    
    local use_with_config = function(path, name)
        use({ path, config = config(name) })
    end

    -- basic
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")
    use("tpope/vim-commentary")
    use_with_config("lewis6991/gitsigns.nvim", "git")

    -- text objects
    use("wellle/targets.vim") -- many useful additional text objects
    use({
        "kana/vim-textobj-user",
        {
            "kana/vim-textobj-entire", -- ae/ie for entire buffer
            "Julian/vim-textobj-variable-segment", -- av/iv for variable segment
            "michaeljsmith/vim-indent-object", -- ai/ii for indentation area
        },
    })

    -- registers
    use_with_config("svermeulen/vim-subversive", "subversive") -- adds substitute operator
    use_with_config("svermeulen/vim-cutlass", "cutlass") -- separates cut and delete operations
    use_with_config("svermeulen/vim-yoink", "yoink") -- improves paste
    use_with_config("tversteeg/registers.nvim", "registers") -- shows register contents intelligently

     -- additional functionality
    use_with_config("windwp/nvim-autopairs", "autopairs") -- autocomplete pairs
    use_with_config("phaazon/hop.nvim", "hop") -- motion

    -- integrations
    use_with_config("christoomey/vim-tmux-runner", "vtr") -- run commands in a linked tmux pane
    use_with_config("mcchrish/nnn.vim", "nnn") -- simple nnn integration

    use 'svermeulen/vimpeccable'
    
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = config("nvimtree")
    }
    
    use 'neovim/nvim-lspconfig'
    
    use({
        "nvim-telescope/telescope.nvim",
        config = config("telescope"),
        requires = { {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
        } },
    })
    
    -- completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'SirVer/ultisnips' -- snippets

    -- development
    -- use("~/git/nvim-lsp-ts-utils") -- improve typescript experience
    use({
        "vuki656/package-info.nvim", -- manage package.json
        config = config("package-info"),
        requires = "MunifTanjim/nui.nvim",
        ft = { "typescript", "typescriptreact" },
    })
    use("jose-elias-alvarez/null-ls.nvim")
    use("jose-elias-alvarez/nvim-lsp-ts-utils")
    
    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter"),
    })
    use({
        "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
        ft = { "lua", "typescript", "typescriptreact" },
    })
    use({ "windwp/nvim-ts-autotag", ft = { "typescript", "typescriptreact" } }) -- automatically close jsx tags
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work

    -- visual
    use({ -- themes
        "sainnhe/sonokai",
        "RRethy/nvim-base16",
    })
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    
    -- line bar
    use_with_config("famiu/feline.nvim", "feline")
    -- use_with_config("~/git/buftabline.nvim", "buftabline") -- show buffers in tabline

    -- misc
    use("teal-language/vim-teal") -- teal language support
    use("nvim-lua/plenary.nvim") -- required for plugins (and testing)
    use({
        "iamcco/markdown-preview.nvim", -- preview markdown output in browser
        opt = true,
        ft = { "markdown" },
        config = "vim.cmd[[doautocmd BufEnter]]",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
    })

    -- use_with_config("mhartington/formatter.nvim", "formatter") -- formatter
end)

