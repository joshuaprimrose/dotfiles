return {
    {
        "saghen/blink.cmp",
        build = "cargo build --release",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        {
                            path = "${3rd}/luv/library",
                            words = {
                                "vim%.uv"
                            },
                        },
                    },
                },
            },
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                init = function ()
                    local vs_code_style_snippet_path = vim.fn.stdpath("config") .. "/lua/plugins/snippets/vs_code_style"

                    require("luasnip.loaders.from_vscode").lazy_load({ paths = vs_code_style_snippet_path })
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("plugins.snippets.lua_style.snippets").add_snippets()

                    vim.keymap.set("n", "<leader>ls", ":LuaSnipListAvailable<CR>", { desc = "LuaSnip: List Available Snippets" })
                end,
                opts = {
                    history = true,
                    updateevents = "TextChanged,TextChangedI",
                },
                version = "v2.*"
            },
            "xzbdmw/colorful-menu.nvim"
        },
        opts = {
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", gap = 1 },
                        },
                        components = {
                            label = {
                                width = {
                                    fill = true,
                                    max = 60,
                                },
                                text = function(ctx)
                                    local highlights_info = require("colorful-menu").blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        -- Or you want to add more item to label
                                        return highlights_info.label
                                    else
                                        return ctx.label
                                    end
                                end,
                                highlight = function(ctx)
                                    local highlights = {}
                                    local highlights_info = require("colorful-menu").blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        highlights = highlights_info.highlights
                                    end
                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                                    end
                                    -- Do something else
                                    return highlights
                                end,
                            },
                        },
                    },
                },
            },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    "score",
                    "sort_text",
                    "exact",
                },
            },
            keymap = {
                preset = "none",
                ["<C-e>"] = { "show", "hide", "fallback" },
                ["<C-h>"] = { "show_documentation", "hide_documentation" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<C-PgDn>"] = { "scroll_documentation_down", "fallback" },
                ["<C-PgUp>"] = { "scroll_documentation_up", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            signature = {
                enabled = true,
            },
            snippets = {
                preset = "luasnip",
            },
            sources = {
                default = {
                    "lazydev",
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        },
        version = "1.*",
    }
}
