return {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local handlers = require('nvim-autopairs.completion.handlers')
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        cmp.setup({
            experimrntal = {
                ghost_text = true,
            },
            formatting = {
                expandable_indicator = true,
                format = function (entry, item)
                    local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

                    item = lspkind.cmp_format({
                        menu = {
                            buffer = "[BUF]",
                            luasnip = "[SNIP]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[API]",
                            path = "[PATH]",
                        },
                        with_text = true,
                    })(entry, item)

                    if color_item.abbr_hl_group then
                        item.kind_hl_group = color_item.abbr_hl_group
                        item.kind = color_item.abbr
                    end

                    return item
                end,
            },
            mapping = {
                ["<Down>"] = cmp.mapping(function (fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Up>"] = cmp.mapping(function (fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<ESC>"] = cmp.mapping.close(),
                ["<S-Tab>"] = cmp.mapping(function ()
                    if luasnip.expandable() then
                        luasnip.expand()
                    end
                end, { "i" }),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                {
                    keyword_length = 3,
                    name = "buffer",
                    option = {
                        get_bufnrs = function()
                            local minutes = 15

                            local recentBuffers = vim.iter(vim.fn.getbufinfo { buflisted = 1 })
                                :filter(function(buf) return os.time() - buf.lastused < minutes * 60 end)
                                :map(function(buf) return buf.bufnr end)
                                :totable()

                            return recentBuffers
                        end,
                    },
                    priority = 750,
                },
                {
                    name = "nvim_lua",
                    priority = 750,
                },
                {
                    name = "luasnip",
                },
                {
                    name = "async_path",
                },
            }),
            window = {
                documentation = cmp.config.window.bordered(),
            }
        })

        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done({
                ["*"] = {
                    ["("] = {
                        kind = {
                            cmp.lsp.CompletionItemKind.Function,
                            cmp.lsp.CompletionItemKind.Method,
                        },
                        handler = handlers["*"],
                    },
                },
                lua = {
                    ["("] = {
                        kind = {
                            cmp.lsp.CompletionItemKind.Function,
                            cmp.lsp.CompletionItemKind.Method,
                        },
                        handler = function(char, item, bufnr, rules, commit_character)
                            print(char, item, bufnr, rules, commit_character)
                        end
                    }
                }
            })
        )

        local vs_code_style_snippet_path = vim.fn.stdpath("config") .. "\\lua\\plugins\\snippets\\vs_code_style"
        require("luasnip.loaders.from_vscode").lazy_load({ paths = vs_code_style_snippet_path })
        require("lua.plugins.snippets.lua_style.snippets").add_snippets()

        vim.keymap.set("n", "<leader>ls", ":LuaSnipListAvailable<CR>", { desc = "LuaSnip: List Available Snippets" })
    end,
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
                "saadparwaiz1/cmp_luasnip",
            },
            opts = {
                history = true,
                updateevents = "TextChanged,TextChangedI",
            },
            version = "v2.*",
        },
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "FelipeLema/cmp-async-path",
        "nvim-lua/plenary.nvim",
        "brenoprata10/nvim-highlight-colors",
        "onsails/lspkind.nvim",
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {
                --     check_comma = true,
                --     check_ts = false,
                disable_filetype = {
                    "ps1",
                    "TelescopePrompt",
                },
                disable_in_macro = true,
                -- fast_wrap = {
                --     map = "<leader>ww",
                -- },
                -- ts_config = {
                --     java = false,
                --     javascript = {
                --         "tempalate_string",
                --     },
                --     lua = {
                --         "string",
                --     },
                -- },
            },
        }
    },
}
