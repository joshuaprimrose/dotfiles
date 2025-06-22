local getBasicCapabilities = function(lspconfig, cmp_nvim_lsp)
    local capabilities = lspconfig.util.default_config.capabilities

    if cmp_nvim_lsp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
    end

    return capabilities
end

return {
    getBasicCapabilities = getBasicCapabilities,
}

