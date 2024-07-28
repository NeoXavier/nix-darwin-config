return require('packer').startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Status and Buffer line
    use("nvim-lualine/lualine.nvim")
    use { 'akinsho/bufferline.nvim',  requires = 'nvim-tree/nvim-web-devicons' }

    --LSP
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    
    -- LSP Support
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }

    -- Autocompletion
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'j-hui/fidget.nvim' }

    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

    -- Autocompletion
    use("jiangmiao/auto-pairs")
    use("alvan/vim-closetag")

    -- Comments
    use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
    }

    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons"
    }

    -- Theme
    -- use("olimorris/onedarkpro.nvim")
    -- use("artanikin/vim-synthwave84")
    -- use({ "rose-pine/neovim", as = "rose-pine" })
    -- use { "catppuccin/nvim", as = "catppuccin" }
    -- use { "folke/tokyonight.nvim", as = "tokyonight" }
    use ("ellisonleao/gruvbox.nvim")
    use ("sainnhe/gruvbox-material")

    -- Web-dev
    --use('mattn/emmet-vim')
    --use('AndrewRadev/tagalong.vim')
    --use('tpope/vim-surround')

    --Copilot
    use("github/copilot.vim")

    -- LateX
    --use('lervag/vimtex')
    --use {
        --"iurimateus/luasnip-latex-snippets.nvim",
        ---- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
        ---- using treesitter.
        --requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
        --config = function()
            --require 'luasnip-latex-snippets'.setup()
            ---- or setup({ use_treesitter = true })
        --end,
        ---- treesitter is required for markdown
        --ft = { "tex", "markdown" },
    --}
end)
