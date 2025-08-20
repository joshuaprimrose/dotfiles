local luasnip = require("luasnip")

local add_snippets = function ()
    luasnip.add_snippets(nil, {
        all = {
            luasnip.parser.parse_snippet("expand", "-- this is the eXpanded text!"),
        },
    })
end

return {
    add_snippets = add_snippets,
}
