-- add your own keymapping
vim.api.nvim_del_keymap("i", "jj")
vim.api.nvim_del_keymap("i", "jk")
vim.api.nvim_del_keymap("i", "kj")
lvim.keys.normal_mode["t"] = "f"
lvim.keys.visual_mode["t"] = "f"
lvim.keys.normal_mode["Y"] = 'gg"+yG``'
lvim.keys.visual_mode["-"] = '"+y'
lvim.keys.normal_mode["-"] = '"+yy'
lvim.keys.visual_mode["x"] = '"+ygvd'
lvim.keys.visual_mode["+"] = '"+p'
lvim.keys.normal_mode["+"] = '"+P'
lvim.keys.normal_mode["_"] = "a <esc>"
lvim.keys.normal_mode["o"] = "o <Esc>"
lvim.keys.normal_mode["O"] = "O <Esc>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<C-l>"] = ":nohl<CR>"
lvim.keys.insert_mode["<Del>"] = "<esc>ciw"
lvim.keys.normal_mode["<C-m>"] = ":MarkdownPreviewToggle"
lvim.keys.insert_mode["<C-m>"] = "<esc>:MarkdownPreviewToggle"
lvim.keys.normal_mode["<M-t>"] = ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>'
lvim.keys.insert_mode["<M-t>"] = '<esc>:exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>i'
lvim.keys.visual_mode["f"] = "<CMD>lua require'hop'.hint_words()<CR>"
lvim.keys.normal_mode["f"] = "<CMD>lua require'hop'.hint_words()<CR>"
lvim.keys.visual_mode["F"] = "<CMD>lua require'hop'.hint_words({current_line_only = true})<CR>"
lvim.keys.normal_mode["F"] = "<CMD>lua require'hop'.hint_words({current_line_only = true})<CR>"
vim.api.nvim_set_keymap("o", "f", "<CMD>lua require'hop'.hint_words()<CR>", {})
vim.api.nvim_set_keymap("o", "F", "<CMD>lua require'hop'.hint_words({current_line_only = true})<CR>", {})
lvim.builtin.nvimtree.setup.view.mappings = {
  custom_only = true,
  list = {
    { key = { "l" }, action = "edit" },
    { key = { "O" }, action = "edit_no_picker" },
    { key = { "o" }, action = "cd" },
    { key = "v", action = "vsplit" },
    { key = "s", action = "split" },
    { key = "t", action = "tabnew" },
    { key = "b", action = "prev_sibling" },
    { key = "w", action = "next_sibling" },
    { key = "P", action = "parent_node" },
    { key = "h", action = "close_node" },
    { key = "<Tab>", action = "preview" },
    { key = "^", action = "first_sibling" },
    { key = "$", action = "last_sibling" },
    { key = "I", action = "toggle_dotfiles" },
    { key = "R", action = "refresh" },
    { key = "a", action = "create" },
    { key = "d", action = "remove" },
    { key = "D", action = "trash" },
    { key = "r", action = "rename" },
    { key = "<C-r>", action = "full_rename" },
    { key = "x", action = "cut" },
    { key = "c", action = "copy" },
    { key = "p", action = "paste" },
    { key = "y", action = "copy_name" },
    { key = "Y", action = "copy_path" },
    { key = "gy", action = "copy_absolute_path" },
    { key = "gp", action = "prev_git_item" },
    { key = "gn", action = "next_git_item" },
    { key = "<BS>", action = "dir_up" },
    { key = "s", action = "system_open" },
    { key = "q", action = "close" },
    { key = "g?", action = "toggle_help" },
  },
}
