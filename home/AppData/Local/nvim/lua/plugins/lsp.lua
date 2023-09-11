return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local icon = require("nvim-web-devicons")

            require("neodev").setup()

            local lsp_servers = {
                gopls = {},
                jsonls = {},
                lua_ls = {
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
                },
                powershell_es = {},
                tsserver = {},
                yamlls = {},
            }

            local on_attach = function(_, bufnr)
                local keymap = require("lua.config.utils").keymap

                keymap("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP:  Goto Definition" })
                keymap("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Goto Declaration" })
                keymap("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto Implementation" })
                keymap("n", "<leader>td", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
                -- See `:help K` for why this keymap
                keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover Documentation" })
                keymap("n", "<leader>K", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Documentation" })

                keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
                keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, "LSP: Code Action" })


                keymap("<leader>gr", require('telescope.builtin').lsp_references, "Goto References")
                keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                keymap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')


                -- Lesser used LSP functionality
                keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "[W]orkspace [A]dd Folder" })
                keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "[W]orkspace [R]emove Folder" })
                keymap("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = bufnr, desc = "[W]orkspace [L]ist Folders" })

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                    vim.lsp.buf.format()
                end, { buffer = bufnr,  desc = "Format current buffer with LSP" })
            end

            mason.setup({
                ui = {
                    icons = {
                        package_installed = icon.get_icon("package_installed"),
                        package_pending = icon.get_icon("package_pending"),
                        package_uninstalled = icon.get_icon("package_uninstalled"),
                    },
                },
            })

            mason_lspconfig.setup({
                automatic_installation = true,
                ensure_installed = vim.tbl_keys(lsp_servers)
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

            mason_lspconfig.setup_handlers({
                function(lsp_server_name)
                    if lsp_server_name ~= "jdtls" then
                        lspconfig[lsp_server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = lsp_servers[lsp_server_name].settings or {},
                        })
                    end
                end
            })
        end,
        dependencies = {
            "folke/neodev.nvim",
            {
                "j-hui/fidget.nvim",
                event = "LspAttach",
                opts = {},
                tag = "legacy",
            },
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig",
            "nvim-tree/nvim-web-devicons",
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim",
                },
                opts = {
                    lsp = {
                        auto_attach = true,
                    },
                },
            },
            "williamboman/mason-lspconfig.nvim",
        },
        lazy = false,
    }
}

