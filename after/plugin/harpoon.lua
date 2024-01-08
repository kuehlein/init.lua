local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file) -- <leader>a
vim.keymap.set("n", "<C-m>", ui.toggle_quick_menu) -- <C-e>

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end) -- <C-h>
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end) -- <C-t>
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end) -- <C-n>
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end) -- <C-s>
