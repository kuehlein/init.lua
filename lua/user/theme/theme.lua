-- inspired by: https://machineroom.purplekraken.com/posts/neovim-theme-lua/

local theme = require("user.theme.colors");

local colors = theme.colors; -- all colors
local p = theme.palette; -- commonly used colors

local M = {};


-- TODO: i wonder if there's a way to "compile" this so we don't have to run this on every startup
-- TODO: come up with a proper theme name?


function M.color_scheme()
    -- theme
    local t = {
        Comment = { fg = p.fg.gray },
        ColorColumn = { bg = colors.gray[8] },
        CursorLine = { bg = colors.gray[8] },
        CursorLineNr = { fg = p.white },
        EndOfBuffer = { fg = p.fg.gray },
        Identifier = { fg = p.fg.purple },
        Keyword = { fg = p.fg.red },
        LineNr = { fg = p.fg.gray },
        NonText = { fg = p.white },
        Normal = { bg = p.bg.gray },
        Pmenu = { bg = colors.gray[8] },
        PmenuSbar = {},
        PmenuSel = { bg = p.gray },
        PmenuThumb = {},
        SignColumn = { bg = p.bg.gray },
        -- SpellBad = { bg = colors.blue[9], undercurl = true },
        Special = { fg = p.white },
        Statement = { fg = p.fg.red },
        Type = { fg = p.fg.orange },
        Visual = { bg = colors.gray[7] },
        Whitespace = { fg = colors.gray[7] },

        -- DiagnosticUnnecessary = { blend = 20 }, -- ?????

        -- TODO: can this be lazily loaded upon opening a rust file (if it hasn't already been loaded)?
        -- rust specific highlight groups
        ["@lsp.mod.constant.rust"] = { fg = p.fg.blue },
        ["@lsp.mod.mutable.rust"] = { underline = true },
        ["@lsp.type.enumMember.rust"] = { fg = p.fg.blue },
        ["@lsp.type.formatSpecifier.rust"] = { fg = p.fg.red },
        ["@lsp.type.macro.rust"] = { fg = p.fg.purple },
        ["@lsp.type.parameter.rust"] = { fg = p.fg.orange },
        ["@lsp.type.variable.rust"] = { fg = p.white },
        ["@lsp.typemod.keyword.crateRoot.rust"] = { fg = p.fg.red },
        ["@lsp.typemod.decorator.attribute.rust"] = { fg = p.fg.orange },
        ["@lsp.typemod.function.defaultLibrary.rust"] = { fg = p.fg.blue },
        ["@number.rust"] = { fg = colors.blue[1] },
        ["@punctuation.bracket.rust"] = { fg = p.fg.green },
        ["@punctuation.delimiter.rust"] = { fg = p.fg.red },
        ["@string.rust"] = { fg = colors.blue[1] },
        ["@string.escape.rust"] = { fg = p.fg.red },
        ["@type.builtin.rust"] = { fg = p.fg.blue },
        ["@type.qualifier.rust"] = { fg = p.fg.red },
    };

    -- Each entry into the inner table corresponds to a configuration key,
    -- mapped to a highlight argument. We implement this in a function which we
    -- conveniently call highlight(), just like the vim command we wrap:
    local function highlight(group, style)
        -- 0 is the global level, maybe add level to the `t` object?
        vim.api.nvim_set_hl(0, group, style);
    end;

    -- if another theme is set, clear it, then apply our theme
    if vim.g.colors_name then
        vim.cmd("highlight clear")
    end

    -- name of theme we are applying
    vim.g.colors_name = "theme"
    
    -- apply the theme for each value in `t`
    for group, style in pairs(t) do
        highlight(group, style)
    end

    -- highlight illegal characters ()
    -- vim.cmd('syntax match IllegalCharacter "​|‌|‍|‎|‏|﻿"');
    -- vim.api.nvim_set_hl(0, "IllegalCharacter", { bg = "#FF0000" });

    -- create custom highlight group to target tokens we can't target alone
    vim.cmd('syntax match Punctuation ",|;"');
    vim.api.nvim_set_hl(0, "Punctuation", { fg = p.white });
end;


-- TODO: remove this once the colorscheme is finished...
M.color_scheme();


-- dark
-- Temp override until Primitives are updated
-- darkColors.fg.default = "#e6edf3",
-- darkColors.fg.muted = "#7d8590",
-- darkColors.accent.fg = "#2f81f7",
-- darkColors.severe.subtle = "rgba(219, 109, 40, 0.1)",
-- darkColors.danger.subtle = "rgba(248, 81, 73, 0.1)",
-- darkColors.done.subtle = "rgba(163, 113, 247, 0.1)",
-- darkColors.sponsors.subtle = "rgba(219, 97, 162, 0.1)",

-- dark & high contrast...
-- dark & colorblind...
-- dark & dimmed...


-- TODO: does putting this in a different file cause things to slow down?

return M;

