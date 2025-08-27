return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "folke/lazydev.nvim",
            dependencies = {
                {
                    "hrsh7th/nvim-cmp",
                    opts = function(_, opts)
                        opts.sources = opts.sources or {}
                        table.insert(opts.sources, {
                            name = "lazydev",
                            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                        })
                    end,
                },
                {
                    "Bilal2453/luvit-meta",
                    lazy = true
                },
            }
        },
        "zeioth/garbage-day.nvim",
        "artemave/workspace-diagnostics.nvim",
        "RubixDev/mason-update-all",
    },
    event = "VeryLazy",
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
            },
        })

        local ensure_installed = {
            "asmfmt",
            "bash-language-server",
            "beautysh",
            "checkmake",
            "clang-format",
            "clangd",
            "gradle-language-server",
            "gopls",
            "html-lsp",
            "java-debug-adapter",
            "jdtls",
            "json-lsp",
            "kotlin-language-server",
            "lua-language-server",
            "luacheck",
            "omnisharp",
            "prettierd",
            "pyright",
            "shfmt",
            "stylua",
            "typos-lsp",
            "texlab",
            "verible",
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

        require("mason-update-all").setup({})

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
            filetypes = { "sh", "zsh" },
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

        lspconfig.gopls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "go" },
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

        lspconfig.ts_ls.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "typescript", "javascript" },
        })

        lspconfig.html.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "html", "nml" },
        })

        lspconfig.verible.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "systemverilog", "verilog" },
        })

        lspconfig.pyright.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "python" }
        })

        lspconfig.texlab.setup({
            root_dir = function() return vim.fn.getcwd() end,
            filetypes = { "latex", "markdown" }
        })

        vim.g.zig_fmt_autosave = 0

        require("workspace-diagnostics").setup({})

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local bufnr = event.buf
                local opts = { buffer = bufnr, remap = false }

                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)

                vim.keymap.set("n", "<leader>i", function()
                    vim.lsp.buf.hover({ border = "rounded" })
                end, opts)

                vim.keymap.set("n", "<leader>r", function()
                    vim.lsp.buf.rename()
                end, opts)

                vim.keymap.set({ "n", "v" }, "<leader>a", function()
                    vim.lsp.buf.code_action({})
                end, opts)
            end,
        })

        -- Below diagnostics config and autocmds lifted from https://www.reddit.com/r/neovim/comments/1jpbc7s/disable_virtual_text_if_there_is_diagnostic_in/?share_id=TMnSUgCygO7v9SW_qlAv4&utm_medium=ios_app&utm_name=ioscss&utm_source=share&utm_term=1
        vim.diagnostic.config({
            virtual_text = true,
            virtual_lines = { current_line = true },
            underline = true,
            update_in_insert = false,
            signs = false,
        })

        local og_virt_text
        local og_virt_line
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
            group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', {}),
            callback = function()
                if og_virt_line == nil then
                    og_virt_line = vim.diagnostic.config().virtual_lines
                end

                -- ignore if virtual_lines.current_line is disabled
                if not (og_virt_line and og_virt_line.current_line) then
                    if og_virt_text then
                        vim.diagnostic.config({ virtual_text = og_virt_text })
                        og_virt_text = nil
                    end
                    return
                end

                if og_virt_text == nil then
                    og_virt_text = vim.diagnostic.config().virtual_text
                end

                local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

                if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
                    vim.diagnostic.config({ virtual_text = og_virt_text })
                else
                    vim.diagnostic.config({ virtual_text = false })
                end
            end
        })

        vim.api.nvim_create_autocmd('ModeChanged', {
            group = vim.api.nvim_create_augroup('diagnostic_redraw', {}),
            callback = function()
                pcall(vim.diagnostic.show)
            end
        })
    end,
}
