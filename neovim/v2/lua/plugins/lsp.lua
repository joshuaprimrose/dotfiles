return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc, silent = true })
                    end

                    map("<leader>lr", ":LspRestart<CR>", "Restart LSP")

                    map("<leader>ca", vim.lsp.buf.code_action, "Open code actions", { "n", "x" })
                    map("<leader>gd", require("telescope.builtin").lsp_definitions, "Goto definitions")
                    map("<leader>gD", vim.lsp.buf.declaration, "Goto declaration")
                    map("<leader>gi", require("telescope.builtin").lsp_implementations, "Goto implementations")
                    map("<leader>gr", require("telescope.builtin").lsp_references, "Goto references")
                    map("<leader>gs", require("telescope.builtin").lsp_document_symbols, "Goto buffer symbols")
                    map("<leader>gS", require("telescope.builtin").lsp_workspace_symbols, "Goto workspace symbols")
                    map("<leader>gt", require("telescope.builtin").lsp_type_definitions, "Goto type definitions")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename variable under cursor")

                    local function client_suports_method(client, method, bufnr)
                        if vim.fn.has("nvim-0.11") == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client and client_suports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })

                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                            group = highlight_augroup,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                            group = highlight_augroup,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({
                                    buffer = event2.buf,
                                    group = "my-lsp-highlight",
                                })
                            end,
                            group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true })
                        })
                    end

                    if client and client_suports_method(client, vim.lsp.protocol.Methods.textDocument_formatting, event.buf) then
                        map("<leader>lf", function()
                            vim.lsp.buf.format()
                        end, "LSP: Format Buffer")
                    end

                    if client and client_suports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                        map("<leader>lh", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, "LSP: Toggle Inlay Hints")
                    end
                end,
            })

            vim.api.nvim_create_autocmd("LspProgress", {
                callback = function(ev)
                    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

                    vim.notify(vim.lsp.status(), 2, {
                        id = "lsp_progress",
                        title = "LSP Progress",
                        opts = function(notif)
                            notif.icon = ev.data.params.value.kind == "end" and " " or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                    })
                end,
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            lspconfig.dockerls.setup({
                capabilities = capabilities,
            })

            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                filetypes = {
                    "css",
                    "html",
                    "javascriptreact",
                    "less",
                    "sass",
                    "scss",
                    "templ",
                    "typescriptreact",
                },
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Both", --was Replace
                        },
                        diagnostics = {
                            disable = {
                                "missing-fields",
                            },
                            globals = {
                                "require",
                                "vim",
                            },
                        },
                        format = {
                            enable = true,
                            defaultConfig = {
                                continuation_indent_size = "4",
                                indent_size = "4",
                                indent_style = "space",
                            }
                        },
                        hint = {
                            enable = true,
                            arrayIndex = "Disable",
                            paramName = "Disable",
                            paramType = true,
                            semicolon = "Disable",
                            setType = false,
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        type = {
                            castNumberToInteger = true,
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
                root_dir = util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", ".git"),
            })

            lspconfig.ts_ls.setup({
                init_options = {
                    hostInfo = "neovim",
                },
                plugins = {},
                settings = {
                    javascript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = true,
                        },
                    },
                    typescript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "literal",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = false,
                        },
                    },
                },
            })


            -- local servers = {
            --     dockerls = {},
            --     emmet_ls = {
            --         capabilities = capabilities,
            --         filetypes = {
            --             "html",
            --             "javascript",
            --             "javascriptreact",
            --             "templ",
            --             "typescript",
            --             "typescriptreact",
            --         },
            --     },
            --     gopls = {
            --         analysis = {
            --             unusedparams = true,
            --         },
            --         completeUnimported = true,
            --         usePlaceholders = true,
            --     },
            --     lua_ls = {
            --         settings = {
            --             Lua = {
            --                 completion = {
            --                     callSnippet = "Replace",
            --                 },
            --                 diagnostics = {
            --                     disable = {
            --                         "missing-fields",
            --                     },
            --                     globals = {
            --                         "require",
            --                         "vim",
            --                     },
            --                 },
            --             },
            --         },
            --     },
            -- }
            --
            -- local ensure_installed = vim.tbl_keys(servers or {})
            -- vim.list_extend(ensure_installed, {
            --     "delve",
            --     "java-debug-adapter",
            --     "java-test",
            --     "jdtls",
            --     "local-lua-debugger-vscode",
            --     "sonarlint-language-server",
            --     "stylua",
            -- })

            require("mason-tool-installer").setup({
                ensure_installed = {
                    "delve",
                    "java-debug-adapter",
                    "java-test",
                    "local-lua-debugger-vscode",
                    "sonarlint-language-server",
                    "stylua",
                },
            })

            require("mason-lspconfig").setup({
            --     automatic_enable = true,
            --     automatic_installation = false,
                ensure_installed = {
                    "dockerls",
                    "emmet_language_server",
                    "jdtls",
                    "lua_ls",
                    "ts_ls",
                }
            --     handlers = function(server_name)
            --         local server = servers[server_name] or {}
            --         -- This handles overriding only values explicitly passed
            --         -- by the server configuration above. Useful when disabling
            --         -- certain features of an LSP (for example, turning off formatting for ts_ls)
            --         server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            --         require("lspconfig")[server_name].setup(server)
            --     end,
            })
        end,
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
        },
    }
}
