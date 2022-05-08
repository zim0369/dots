-- Additional Plugins
lvim.plugins = {
  { 'tpope/vim-repeat' },
  { 'simeji/winresizer' },
  { 'sainnhe/everforest' },
  { 'tpope/vim-surround' },
  { 'Mofiqul/vscode.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'svban/YankAssassin.vim' },
  { 'Th3Whit3Wolf/space-nvim' },
  { 'davidgranstrom/nvim-markdown-preview' },

  { "ellisonleao/glow.nvim",
    branch = 'main' },

  { "ellisonleao/gruvbox.nvim",
    requires = "rktjmp/lush.nvim" },

  { 'petertriho/nvim-scrollbar',
    config = function()
      require("plugins.scrollbar").config()
    end,
  },

  { "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent").config()
    end,
  },

  { 'norcalli/nvim-colorizer.lua',
    config = function()
      require("plugins.colorizer").config()
    end,
  },

  { 'karb94/neoscroll.nvim',
    config = function()
      require("plugins.neoscroll").config()
    end,
  },

  { 'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      require("plugins.hop").config()
    end,
  },

  { 'abecodes/tabout.nvim',
    config = function()
      require("plugins.tabout").config()
    end,
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
  },

  { 'lukas-reineke/headlines.nvim',
    config = function()
      require("plugins.headlines").config()
    end,
  },

}

-- {
--   "folke/trouble.nvim",
--   cmd = "TroubleToggle",
-- },
