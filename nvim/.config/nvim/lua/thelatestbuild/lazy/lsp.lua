return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "gopls" },
            }
            vim.diagnostic.config({
                virtual_text = {
                    wrap = true,
                    spacing = 4,
                    source = "if_many",
                },
                signs = true,     -- Shows error signs in gutter
                underline = true, -- Underlines problematic code
                update_in_insert = false,
            })
        end
    }
}
