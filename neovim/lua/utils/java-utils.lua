local getJdtlsPath = function ()
    return vim.fn.stdpath("data") .. "/mason/packages/jdtls"
end

local getLombokPath = function ()
    return getJdtlsPath() .. "/lombok.jar"
end

local getLauncherPath = function ()
    return vim.fn.glob(getJdtlsPath() .. "/plugins/org.eclipse.equinox.launcher_*.jar")
end

local getConfigPath = function ()
    return getJdtlsPath() .. "/config_win"
end

local getWorkspaceRoot = function ()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

    vim.fn.mkdir(workspace_dir, "p")

    return workspace_dir
end

local getJavaDebugPath = function ()
    return vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server"
end

local getJavaTestPath = function ()
    return vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server"
end

local getBundles = function ()
    local bundles = {
        vim.fn.glob(getJavaDebugPath() .. "/com.microsoft.java.debug.plugin-*.jar", true)
    }

    vim.list_extend(bundles, vim.split(vim.fn.glob(getJavaTestPath() .. "/*.jar", true), "\n"))

    return bundles
end

local getJavaSettings = function (jdtls)
    return {
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
        java = {
            configuration = {
                runtimes = {
                    -- {
                    --     name = "JavaSE-1.8",
                    --     path = "C:/EngTools/Java/OpenJdk-8",
                    -- },
                    {
                        name = "JavaSE-11",
                        path = "C:/EngTools/Java/OpenJdk-11",
                    },
                },
                updateBuildConfiguration = "interactive",
            },
            eclipse = {
                downloadSources = true,
            },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            format = {
                enabled = true,
                settings = {
                    profile = "GoogleStyle",
                    url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                },
            },
            home = "C:/EngTools/Java/jdk-23",
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
            signatureHelp = {
                enabled = true,
            },
        },
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
end

return {
    getBundles = getBundles,
    getConfigPath = getConfigPath,
    getJavaDebugPath = getJavaDebugPath,
    getJavaTestPath = getJavaTestPath,
    getJavaSettings = getJavaSettings,
    getLauncherPath = getLauncherPath,
    getLombokPath = getLombokPath,
    getWorkspaceRoot = getWorkspaceRoot,
}

