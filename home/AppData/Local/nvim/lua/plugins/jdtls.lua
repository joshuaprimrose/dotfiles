return {
    {
        "mfussenegger/nvim-jdtls",
        init = function()
            local group = vim.api.nvim_create_augroup("Java", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local jdtls = require("jdtls")
                    local cmp_nvim_lsp = require("cmp_nvim_lsp")

                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    if cmp_nvim_lsp then
                        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
                    end

                    local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
                    local path_to_lombok = jdtls_dir .. "/lombok.jar"
                    local path_to_jar = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")
                    local config_dir = jdtls_dir .. "/config_win"
                    local path_to_java_debug = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server"
                    local path_to_java_test = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server"

                    local bundles = {
                        vim.fn.glob(path_to_java_debug .. "/com.microsoft.java.debug.plugin-*.jar", true),
                    }
                    vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_java_test .. "/*.jar", true), "\n"))

                    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
                    local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
                    print("Workspace dir: " .. workspace_dir)
                    os.execute("mkdir " .. workspace_dir)

                    local cmd = {
                        "C:/EngTools/Java/jdk-20/bin/java",
                        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                        "-Dosgi.bundles.defaultStartLevel=4",
                        "-Declipse.product=org.eclipse.jdt.ls.core.product",
                        "-Dlog.protocol=true",
                        "-Dlog.level=ALL",
                        "-javaagent:" .. path_to_lombok,
                        "-Xms1g",
                        "--add-modules=ALL-SYSTEM",
                        "--add-opens", "java.base/java.util=ALL-UNNAMED",
                        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                        "-jar", path_to_jar,
                        "-configuration", config_dir,
                        "-data", workspace_dir
                    }

                    local extendedClientCapabilities = jdtls.extendedClientCapabilities
                    extendedClientCapabilities.classFileContentsSupport = true
                    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                    local java = {
                        configuration = {
                            runtimes = {
                                {
                                    name = "JavaSE-1.8",
                                    path = "C:/EngTools/Java/OpenJdk-8",
                                },
                            },
                            updateBuildConfiguration = "interactive",
                        },
                        eclipse = {
                            downloadSources = true,
                        },
                        format = {
                            enabled = true,
                            settings = {
                                profile = "GoogleStyle",
                                url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                            },
                        },
                        home = "C:/EngTools/Java/OpenJdk-8",
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        inlayHints = {
                            parameterNames = {
                                enabled = "all",
                            },
                        },
                        maven = {
                            downloadSources = true,
                        },
                        references = {
                            includeDecompiledSources = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                    }

                    local settings = {
                        code_generation = {
                            toString = {
                                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                            },
                            useBlocks = true,
                        },
                        completion = {
                            favoriteStaticMembers = {},
                            importOrder = {
                                "java",
                                "javax",
                                "org",
                                "com",
                            },
                        },
                        contentProvider = {
                              preferred = "fernflower",
                        },
                        java = java,
                        signatureHelp = {
                            enabled = true,
                        },
                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticThreshold = 9999,
                            },
                        },
                    }

                    local keymap = require("lua.config.utils").keymap

                    -- Standard LSP functionality (add it because we aren't using native LSP for JDTLS)
                    keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "JDTLS: Code Action" })
                    keymap("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "JDTLS: Goto Declaration" })
                    keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "JDTLS: Goto Definition" })
                    keymap("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "JDTLS: Goto Implementation" })
                    keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "JDTLS: Goto References" })
                    keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "JDTLS: Rename" })
                    keymap("n", "<leader>td", vim.lsp.buf.type_definition, { desc = "JDTLS: Type Definition" })

                    -- See `:help K` for why this keymap
                    keymap("n", "K", vim.lsp.buf.hover, { desc =  "Hover Documentation" })
                    keymap("n", "<leader>K", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

                    -- Extra functionality provided by JDTLS
                    keymap("n", "<leader>ec", ":lua require('jdtls').extract_constant(true)<CR>", { desc = "JDTLS: Extract Constant" })
                    keymap("n", "<leader>em", ":lua require('jdtls').extract_method(true)<CR>", { desc = "JDTLS: Extract Method" })
                    keymap("n", "<leader>ev", ":lua require('jdtls').extract_variable()<CR>", { desc = "JDTLS: Extract Variable" })
                    keymap("n", "<leader>oi", ":lua require('jdtls').organize_imports()<CR>", { desc = "JDTLS: Organize Imports" })

                    keymap("n", "<leader>tc", ":lua require('jdtls').test_class()<CR>", { desc = "JDTLS: Test Class" })
                    keymap("n", "<leader>tm", ":lua require('jdtls').test_nearest_method()<CR>", { desc = "JDTLS: Test Nearest Method" })

                    -- DAP setup
                    function Attach_To_Karaf()
                        local dap = require("dap")

                        dap.configurations.java = {
                            {
                                type = "java",
                                request = "attach",
                                name = "Attach To Karaf",
                                hostName = "localhost",
                                port = "5005",
                            },
                        }

                        dap.continue()
                    end

                    keymap("n", "<leader>ad", ":lua Attach_To_Karaf()<CR>", { desc = "DAP: Attach to karaf" })
                    keymap("n", "<leader>sd", ":lua require('dap').disconnect()<CR>", { desc = "DAP: Stop debugging" })

                    jdtls.start_or_attach({
                        capabilities = capabilities,
                        cmd = cmd,
                        flags = {
                            allow_incremental_sync = true,
                        },
                        init_options = {
                            bundles = bundles,
                            extendedClientCapabilities = extendedClientCapabilities,
                        },
                        on_attach = function(client, bufnr)
                            jdtls.setup_dap({ hotcodereplace = "auto" })
                        end,
                        root_dir = vim.loop.fs_realpath(jdtls.setup.find_root({ ".git", "build.gradle", "gradlew", "mvnw", "pom.xml" })),
                        settings = settings,
                    })
                end,
                group = group,
                pattern = "java",
            })
        end,
    },
}

