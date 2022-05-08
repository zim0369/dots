vim.cmd([[ set rnu]])
vim.opt.clipboard = ""
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:⋅")
vim.o.guifont = "Iosevka Nerd Font:h7"
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.glow_binary_path = vim.env.HOME .. "/bin"
lvim.builtin.nvimtree.setup.view.side = "right"
