return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                experimental = {
                    ghost_text = true,
                    native_menu = false,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        ellipsis_char = "…",  -- Use this to truncate when maxwidth is reached
                        maxwidth = 75,        -- Limit the number of characters that can appear in cmp popup
                        mode = "symbol_text",      -- Show only symbol_text annotations
                        -- The function below will be called before any lspkind modifications occur
                        before = function (entry, vim_item)
                            return vim_item
                        end
                    })
                },
                mapping = {
                    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                    ["<C-e"] = cmp.mapping.close(),
                },
                sources = {
                    {
                        name = "nvim_lsp",
                        keyword_length = 1,
                    },
                    {
                        name = "luasnip",
                        keyword_length = 2,
                        option = { show_autosnippets = true }
                    },
                    { name = "path", keyword_length = 3 },
                    {
                        name = "buffer",
                        keyword_length = 3,
                        option = {
                            get_bufnrs = function()
                                local buf = vim.api.nvim_get_current_buf()
                                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))

                                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                                    return {}
                                end

                                return { buf }
                            end
                        },
                    },

                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
            })
        end,
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                version = "2.*",
            },
            "onsails/lspkind.nvim",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
        event = "InsertEnter",  -- Load the plugin when we enter insert mode
    }
}

