return { {
    "rose-pine/neovim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lualine/lualine.nvim",
    },
    NormalFloatme = "rose-pine",
    config = function()
        vim.cmd("colorscheme rose-pine")
        require('lualine').setup({})

        local groups = {
            "Normal", "NormalNC", "NormalFloat",
            "FloatBorder", "WinSeparator", "VertSplit",
            "StatusLine", "StatusLineNC", "EndOfBuffer",
            "LineNr", "SignColumn", "CursorLineNr"
        }

        for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
        end
    end

} }
