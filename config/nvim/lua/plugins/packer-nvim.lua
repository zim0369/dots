local cmd = vim.cmd
cmd([[packadd packer.nvim]])

local packer = require("packer")

return packer.startup(function(use)
  -- colorschemes
  use({ "sainnhe/everforest" })
  use({ "yuttie/hydrangea-vim" })
  use({ "ellisonleao/gruvbox.nvim", requires = "rktjmp/lush.nvim" })

  use({ "savq/paq-nvim" })
  use({ "L3MON4D3/LuaSnip" })
  use({ "mattn/webapi-vim" })
  use({ "jbyuki/venn.nvim" })
  use({ "tpope/vim-repeat" })
  use({ "muellan/am-colors" })
  use({ "simeji/winresizer" })
  use({ "tpope/vim-surround" })
  use({ "markonm/traces.vim" })
  use({ "wellle/targets.vim" })
  use({ "fedepujol/move.nvim" })
  use({ "rhysd/vim-grammarous" })
  use({ "numToStr/Comment.nvim" })
  use({ "karb94/neoscroll.nvim" })
  use({ "windwp/nvim-autopairs" })
  use({ "navarasu/onedark.nvim" })
  use({ "svban/YankAssassin.vim" }) --TODO: use it
  use({ "wbthomason/packer.nvim" })
  use({ "AndrewRadev/sideways.vim" })
  use({ "mhartington/formatter.nvim" })
  use({ "dhruvasagar/vim-table-mode" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "phaazon/hop.nvim", as = "hop" })
  use({ "lukas-reineke/headlines.nvim" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "neoclide/coc.nvim", branch = "release" })
  use({ "echasnovski/mini.nvim"})
  use({ "filipdutescu/renamer.nvim", requires = "nvim-lua/plenary.nvim" })
  use({ "VonHeikemen/searchbox.nvim", requires = "MunifTanjim/nui.nvim" })
  use({ "VonHeikemen/fine-cmdline.nvim", requires = "MunifTanjim/nui.nvim" })
  use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
  use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", requires = "nvim-telescope/telescope.nvim", run = "make" })

  use({
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  })
   
-- use({
-- 	"abecodes/tabout.nvim",
-- 	requires = "nvim-treesitter/nvim-treesitter",
-- 	after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
-- })
-- Lua
use {
  'abecodes/tabout.nvim',
  config = function()
    require('tabout').setup {
    tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    enable_backwards = true, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      {open = "'", close = "'"},
      {open = '"', close = '"'},
      {open = '`', close = '`'},
      {open = '(', close = ')'},
      {open = '[', close = ']'},
      {open = '{', close = '}'}
    },
    ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {} -- tabout will ignore these filetypes
}
  end,
	wants = {'nvim-treesitter'}, -- or require if not used so far
	after = {'completion-nvim'} -- if a completion plugin is using tabs load it before
} 

end)

-- use({ "hrsh7th/nvim-cmp" })
-- use({ "hrsh7th/cmp-nvim-lsp" })
-- use({ "neovim/nvim-lspconfig" })
-- use({ "saadparwaiz1/cmp_luasnip" })
