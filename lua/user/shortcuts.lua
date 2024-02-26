-- TODO: autocomplete brackets...
--       * auto open/close
--       * auto delete
--       * do nothing if manually closing
--       * format expanding... (hitting enter...)
--       * if opening brackets not followed by \n, normal behavior

-- TODO: what is prime's window manager? (how he navigates the file system so fast)

local function smart_open_bracket(opening, closing)
    return function()
        local col = vim.api.nvim_win_get_cursor(0)[2];
        local line = vim.api.nvim_get_current_line();

        if col == #line then
            vim.api.nvim_feedkeys(opening .. closing, "i", false);
            -- todo move cursor inside...
        else
            vim.api.nvim_feedkeys(opening, "i", false);
        end
    end
end

-- TODO: move this to utils?
local function smart_close_bracket(opening, closing)
    return function()
        local col = vim.api.nvim_win_get_cursor(0)[2];
        local prev_char = vim.api.nvim_get_current_line():sub(col, col);

        if prev_char == opening then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", true);
        else
            vim.api.nvim_feedkeys(closing, "i", false);
        end
    end
end

-- autocomplete closing brackets/strings
-- vim.keymap.set("i", '"', '""<Left>');
-- vim.keymap.set("i", "(", "()<Left>");
-- vim.keymap.set("i", "[", "[]<Left>");
-- vim.keymap.set("i", "{", "{}<Left>");
-- vim.keymap.set("i", '"', smart_open_bracket('"', '"'));
-- vim.keymap.set("i", "(", smart_open_bracket("(", ")"));
-- vim.keymap.set("i", "[", smart_open_bracket("[", "]"));
-- vim.keymap.set("i", "{", smart_open_bracket("{", "}"));

-- ...
-- vim.keymap.set("i", '"', smart_close_bracket('"', '"'));
-- vim.keymap.set("i", ")", smart_close_bracket("(", ")"));
-- vim.keymap.set("i", "]", smart_close_bracket("[", "]"));
-- vim.keymap.set("i", "}", smart_close_bracket("{", "}"));

vim.keymap.set("i", "{", function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0));
    local current_line = vim.api.nvim_get_current_line();
    local indent = current_line:match("^%s*");

    if col > 2 and current_line:sub(col - 1, col) == ") " then
        local expandtab = vim.api.nvim_get_option("expandtab");
        local tabstop = vim.api.nvim_get_option("tabstop");
        local tab = expandtab and string.rep(" ", tabstop) or "\t";

        vim.api.nvim_put({ "{", indent .. tab, indent .. "}" }, "", true, true);
        vim.api.nvim_win_set_cursor(0, { line + 1, col + 1 });
    else
        vim.api.nvim_put({ "{}" }, "", false, true);
        vim.api.nvim_win_set_cursor(0, { line, col + 1 });
    end
end);
-- vim.keymap.set("i", "<", function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0));
--     local current_line = vim.api.nvim_get_current_line();
--
--     -- TODO: should we expand this to cover more than just turbo fish?
--
--     if col > 2 and current_line:sub(col - 1, col) == "::" then
--         vim.api.nvim_put({ "<>" }, "", false, true);
--         vim.api.nvim_win_set_cursor(0, { line, col + 1 });
--     end
-- end);



-- print
-- TODO: cursor placement here is messed up
vim.keymap.set("n", "<leader>pl", function()
    vim.api.nvim_put({ 'println!("");' }, "", false, true);
    vim.api.nvim_command("normal ==");
    local line, col = unpack(vim.api.nvim_win_get_cursor(0));
    vim.api.nvim_win_set_cursor(0, { line, col + 2 });
    vim.cmd("startinsert");
end); -- rust
vim.keymap.set("n", "<leader>clg", function()
    vim.api.nvim_put({ 'console.log("")' }, "", false, true);
    vim.api.nvim_command("normal ==");
    local line, col = unpack(vim.api.nvim_win_get_cursor(0));
    vim.api.nvim_win_set_cursor(0, { line, col + 3 });
    vim.cmd("startinsert");
end); -- js/ts

