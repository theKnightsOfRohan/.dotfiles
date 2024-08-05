return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "zeioth/garbage-day.nvim",
        "artemave/workspace-diagnostics.nvim",
        "RubixDev/mason-update-all",
    },
    event = "VeryLazy",
    config = function()
        local lsp_zero = require("lsp-zero")

        require("mason").setup({
            ui = {
                border = "rounded",
            },
        })

        local ensure_installed = {
            "bash-language-server",
            "beautysh",
            "checkmake",
            "clang-format",
            "clangd",
            "csharpier",
            "gradle-language-server",
            "html-lsp",
            "java-debug-adapter",
            "jdtls",
            "json-lsp",
            "kotlin-language-server",
            "lua-language-server",
            "luacheck",
            "omnisharp",
            "prettierd",
            "python-lsp-server",
            "shfmt",
            "stylua",
            "typos-lsp",
            "vim-language-server",
            "zls",
        }

        local registry = require("mason-registry")

        for _, package in ipairs(ensure_installed) do
            local package_info = registry.get_package(package)

            if not package_info:is_installed() then
                print("Package " .. package .. " is not installed. Installing...")
                package_info:install({});
            end
        end

        require("mason-update-all").setup()

        local lspconfig = require("lspconfig")

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            "${3rd}/luv/library",
                            unpack(vim.api.nvim_get_runtime_file("", true)),
                        },
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                    completion = {
                        singleFileMode = false,
                    }
                },
            },
            root_dir = function() return vim.fn.getcwd() end
        })

        lspconfig.bashls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "sh", "zsh", "make" },
        })

        lspconfig.clangd.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "c", "cpp", "objc", "objcpp", "h" },
        })

        lspconfig.jdtls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "java" },
        })

        lspconfig.gradle_ls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "gradle" },
        })

        lspconfig.kotlin_language_server.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "kotlin" },
        })

        lspconfig.jsonls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "json" },
        })

        lspconfig.typos_lsp.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "*" },
        })

        lspconfig.zls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "zig" },
        })

        lspconfig.tsserver.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "typescript", "javascript" },
        })

        lspconfig.html.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "html", "nml" },
        })

        vim.g.zig_fmt_autosave = 0

        require("workspace-diagnostics").setup({})

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

            if (client.name ~= "lua_ls" and client.name ~= "jdtls" and client.name ~= "zls") then
                client.server_capabilities.semanticTokensProvider = nil
            end

            vim.keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end, opts)

            vim.keymap.set("n", "<leader>i", function()
                vim.lsp.buf.hover()
            end, opts)

            vim.keymap.set("n", "<leader>r", function()
                vim.lsp.buf.rename()
            end, opts)

            vim.keymap.set({ "n", "v" }, "<leader>a", function()
                vim.lsp.buf.code_action({})
            end, opts)
        end)

        vim.diagnostic.config({
            signs = false,
        })
    end,
}
