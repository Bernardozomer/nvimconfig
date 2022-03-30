local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	}

	print 'Installing packer, please close and reopen Neovim...'
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')

if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install plugins
require('packer').startup(function(use)
	-- Package manager
	use 'wbthomason/packer.nvim'

	-- Improved startup time
	use 'lewis6991/impatient.nvim'
	use 'nathom/filetype.nvim'

	-- Startup time output breakdown
	use 'tweekmonster/startuptime.vim'

	-- Custom start page
	use {
		'goolord/alpha-nvim',
		config = function ()
			require'alpha'.setup(require'alpha.themes.dashboard'.config)
		end
	}

	-- Indent guides
	use "lukas-reineke/indent-blankline.nvim"

	-- Colorizer
	use "norcalli/nvim-colorizer.lua"

	-- Text surrounding tool
	use 'machakann/vim-sandwich'

	-- Completion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'
	use "saadparwaiz1/cmp_luasnip"

	-- Snippets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	-- Built-in LSP
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'

	-- Comment toggler
	use 'terrortylor/nvim-comment'

	-- Treesitter
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

	-- Colorscheme
	use 'ellisonleao/gruvbox.nvim'

	-- Statusline
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- Telescope: highly extensible fuzzy finder
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- File browser for telescope
	use 'nvim-telescope/telescope-file-browser.nvim'

	-- FZF sorter for telescope
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make'
	}

	-- Emoji picker for telescope
	use 'xiyaowong/telescope-emoji.nvim'

	-- Autopairs
	use 'windwp/nvim-autopairs'

	-- Git integration
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}
end)

-- Configure plugins
require('impatient')

-- indent-blankline
require('indent_blankline').setup {
	filetype_exclude = {
		'lspinfo',
		'packer',
		'checkhealth',
		'help',
		'alpha',
		'',
	},
}

-- lualine
require('lualine').setup {
	tabline = {
		lualine_a = {'buffers'},
		lualine_z = {'tabs'},
	},
}

-- nvim-comment
require('nvim_comment').setup()

-- telescope
local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('emoji')

require("telescope-emoji").setup({
	action = function(emoji)
		vim.fn.setreg("e", emoji.value)
		print([[Press "ep to paste this emoji]] .. emoji.value)
	end,
})

-- nvim-autopairs
require('nvim-autopairs').setup()

-- gitsigns
require('gitsigns').setup({
	current_line_blame = true
})

-- colorizer
require('colorizer').setup()
