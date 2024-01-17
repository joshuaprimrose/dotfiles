return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function ()
            require("neodev").setup()

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "jdtls",
                    "gopls",
                    "lua_ls",
                    "templ",
                },
                handlers = nil
            })

            local lspconfig = require("lspconfig")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local keymap = require("lua.config.utils").keymap
            local on_attach = function (_, bufnr)
                keymap("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "LSP: Open floating diagnostics" })

                keymap("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP:  Goto Definition" })
                keymap("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Goto Declaration" })
                keymap("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto Implementation" })
                keymap("n", "<leader>td", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })

                -- See `:help K` for why this keymap
                keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover Documentation" })
                keymap("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Documentation" })

                keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
                keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, "LSP: Code Action" })

                keymap("<leader>gr", require('telescope.builtin').lsp_references, "Goto References")
                keymap("<leader>ds", require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                keymap("<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- Lesser used LSP functionality
                keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "[W]orkspace [A]dd Folder" })
                keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "[W]orkspace [R]emove Folder" })
                keymap("n", "<leader>wl", function ()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = bufnr, desc = "[W]orkspace [L]ist Folders" })

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function (_)
                    vim.lsp.buf.format()
                end, { buffer = bufnr,  desc = "Format current buffer with LSP" })
            end

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },
                        hint = {
                            await = true,
                            enable = true,
                            semicolon = "Disable", -- "All", "Disable", "SameLine"
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        telemetry = {
                            enable = false,
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
                flags = {
                    allow_incremental_sync = true,
                    debounce_text_changes = 500
                },
                on_attach = on_attach,
                settings = {
                    gopls = {
                        analyses = {
                            fieldalignment = false,
                            fillreturns = true,
                            nilness = true,
                            nonewvars = true,
                            shadow = true,
                            ST1003 = true,
                            undeclaredname = true,
                            unreachable = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        codelenses = {
                            generate = true, -- show the `go generate` lens.
                            gc_details = true, -- Show a code lens toggling the display of gc's choices.
                            test = true,
                            regenerate_cgo = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                        matcher = 'Fuzzy',
                        diagnosticsDelay = '500ms',
                        symbolMatcher = 'fuzzy',
                    },
                },
            })

            vim.filetype.add({ extension = { templ = "templ"} })
            lspconfig.templ.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
        dependencies = {
            "folke/neodev.nvim",
            "hrsh7th/cmp-nvim-lsp",
            {
                "j-hui/fidget.nvim",
                event = "LspAttach",
                opts = {},
                tag = "legacy",
            },
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
        }
    }
}

