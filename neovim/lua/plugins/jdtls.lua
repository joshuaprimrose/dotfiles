return {
    "mfussenegger/nvim-jdtls",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "mfussenegger/nvim-dap",
    },
    init = function ()
        local group = vim.api.nvim_create_augroup("Java", { clear = true })

        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local java_utils = require("lua.utils.java-utils")
        local lsp_utils = require("lua.utils.lsp-utils")
        local jdtls = require("jdtls")
        local lspconfig = require("lspconfig")

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()

                local cmd = {
                    "C:/EngTools/Java/jdk-23/bin/java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-javaagent:" .. java_utils.getLombokPath(),
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", java_utils.getLauncherPath(),
                    "-configuration", java_utils.getConfigPath(),
                    "-data", java_utils.getWorkspaceRoot(),
                }

                local root_patterns = { ".git", ".gradlew", "build.gradle.kts", "gradle.properties", "mvnw", "pom.xml" }

                jdtls.start_or_attach({
                    capabilities = lsp_utils.getBasicCapabilities(lspconfig, cmp_nvim_lsp),
                    cmd = cmd,
                    flags = {
                        allow_incremental_sync = true,
                    },
                    init_options = {
                        bundles = java_utils.getBundles(),
                    },
                    on_attach = function (_, bufnr)
                        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Java LSP: Code Action" })
                        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Java LSP: Declaration" })
                        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Java LSP: Goto Definition" })
                        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Java LSP: Goto Implementation" })
                        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Java LSP: Goto References" })
                        vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Java LSP: Signature Help" })
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Java LSP: Rename" })
                        vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Java LSP: Type Definition" })

                        -- Extra JDTLS functionality
                        vim.keymap.set("n", "<leader>em", ":lua require('jdtls').extract_method(true)<CR>", { buffer = bufnr, desc = "Java LSP: Extract Method" })
                        vim.keymap.set("n", "<leader>mt", ":lua require('jdtls.tests').generate()<CR>", { buffer = bufnr, desc = "Java LSP: Generate Tests" })
                        vim.keymap.set("n", "<leader>oi", ":lua require('jdtls').organize_imports()<CR>", { buffer = bufnr, desc = "Java LSP: Organize Imports" })
                        vim.keymap.set("n", "<leader>tc", ":lua require('jdtls').test_class()<CR>", { buffer = bufnr, desc = "Java LSP: Test Class" })
                        vim.keymap.set("n", "<leader>tm", ":lua require('jdtls').test_nearest_method()<CR>", { buffer = bufnr, desc = "Java LSP: Test Nearest Method" })

                        -- Setup debugging
                        ---@diagnostic disable-next-line: missing-fields
                        jdtls.setup_dap({ hotcodereplace = "auto" })
                    end,
                    root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1]),
                    -- root_dir = vim.uv.fs_realpath(jdtls.setup.find_root({ ".git", ".gradlew", "build.gradle.kts", "gradle.properties", "mvnw", "pom.xml" })),
                    settings = java_utils.getJavaSettings(jdtls),
                })
            end,
            group = group,
            pattern = "java",
        })
    end,
}

