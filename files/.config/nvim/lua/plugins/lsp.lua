return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "zeioth/garbage-day.nvim",
        "artemave/workspace-diagnostics.nvim"
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

        local ls = require("luasnip")

        local s = ls.s
        local fmt = require("luasnip.extras.fmt").fmt
        local i = ls.insert_node
        local rep = require("luasnip.extras").rep

        ls.add_snippets("cpp", {
            s("#ifndef", fmt("#ifndef {}_H\n#define {}_H\n\n{}\n\n#endif // {}_H", {
                i(1, "HEADERNAME"), rep(1), i(0), rep(1)
            })),
        })

        vim.keymap.set({ "i", "s" }, "<C-l>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-h>", function()
            if ls.expand_or_jumpable(-1) then
                ls.expand_or_jump(-1)
            end
        end, { silent = true })

        local cmp = require("cmp")

        cmp.setup({
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = {
                { name = "nvim_lua" },
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "luasnip" },
            },
            snippet = {
                expand = function(args)
                    ls.lsp_expand(args.body)
                end,
            }
        })

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
                },
            },
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
