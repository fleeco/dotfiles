return {
    {
        -- Sup
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "fredrikaverpil/neotest-golang",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "andythigpen/nvim-coverage",
        },
        config = function()
            require("coverage").setup({
                auto_reload = true
            })
            require("neotest").setup({
                output = {
                    enabled = true,
                    open_on_run = true,
                },
                adapters = {
                    require("neotest-golang")({
                        go_test_args = {
                            "-v", "-count=1", "-coverprofile=coverage.out"
                        },
                        dap = { justMyCode = false },
                    }),
                },
            })
            vim.keymap.set("n", "<leader>tt", function()
                require("neotest").run.run()
                require("coverage").load(true)
            end, { desc = "Run Nearest Test" })

            vim.keymap.set("n", "<leader>to", function()
                require("neotest").output.open()
            end, { desc = "Debug: Open test output" })

            vim.keymap.set("n", "<leader>ts", function()
                require("neotest").summary.toggle()
            end, { desc = "Debug: Summary Toggle" })

            vim.keymap.set("n", "<leader>td", function()
                require("neotest").run.run({
                    suite = false,
                    testify = true,
                    strategy = "dap",
                })
            end, { desc = "Debug: Debug Nearest Test" })
        end
    }
}
