local jdtls_ok, jdtls = pcall(require("jdtls"))

if not jdtls_ok then
    vim.notify("JDTLS is not installed...", vim.log.levels.ERROR)

    return {}
end

local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })

local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local config_dir = jdtls_dir .. "/config_win"
local path_to_jar = jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar"
local path_to_lombok = jdtls_dir .. "/lombok.jar"

local root_files = {
    "build.gradle",
    ".git",
    "gradlew",
    "pom.xml",
}

local features = {
    codelens = false,
    debugger = false,
}

