return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup({})
        end
    },
    "github/copilot.vim",
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
        "mbbill/undotree",

        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    }
}
