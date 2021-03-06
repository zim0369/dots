require("settings")
require("autocmds")
require("mappings")
require("plugins/hop-nvim")
require("plugins/nvim-tree")
require("plugins/telescope")
require("plugins/venn-nvim")
require("plugins/glow-nvim")
require("plugins/packer-nvim")
require("plugins/lualine-nvim")
require("plugins/renamer-nvim")
require("plugins/nvim-colorizer")
require("plugins/headlines-nvim")
require("plugins/nvim-autopairs")
require("plugins/neoscroll-nvim")

require("plugins/mini-nvim")
require("plugins/bufferline-nvim")
-- require("plugins/alpha-nvim")

require("plugins/telescope-fzf-native")
require("plugins/markdown-preview-nvim")
require("plugins/indent-blankline-nvim")

-- require("luasnip")
-- require("plugins/null-ls")
-- require("plugins/nvim-cmp")
require("plugins/comment-nvim")
-- require("plugins/nvim-lspconfig")
-- require("plugins/nvim-treesitter")

vim.cmd([[source ~/.config/nvim/lua/plugins/coc-nvim.vim]])
