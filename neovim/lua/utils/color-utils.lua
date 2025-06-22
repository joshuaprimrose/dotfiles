local clamp = function (color)
    return math.min(math.max(color, 0), 255)
end

local ldc = function (color, amount)
    if color == nil then
        return ""
    end

    if string.sub(color, 1, 1) == "#" then
        color = string.sub(color, 2, string.len(color))
    end

    color = tonumber(color, 16)
    local r = clamp(math.floor(color / 0x10000) + amount) * 0x10000
    local g = clamp((math.floor(color / 0x100) % 0x100) + amount) * 0x100
    local b = clamp((color % 0x100) + amount)

    local rgb = string.format("%#x", r + g + b)
    return "#" .. string.sub(rgb, 3, string.len(rgb))
end

local darken = function (color, amount)
    return ldc(color, (amount * -1))
end

local lighten = function (color, amount)
    return ldc(color, amount)
end

return {
    darken = darken,
    lighten = lighten,
}
