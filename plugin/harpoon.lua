local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
Nnoremap("<leader>a", mark.add_file);
Nnoremap("<leader>h", ui.toggle_quick_menu);
Nnoremap("<leader>n", Fn(ui.nav_file, 1));
Nnoremap("<leader>e", Fn(ui.nav_file, 2));
Nnoremap("<leader>i", Fn(ui.nav_file, 3));
Nnoremap("<leader>o", Fn(ui.nav_file, 4));
