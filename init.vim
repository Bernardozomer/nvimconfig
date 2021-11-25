"   ███              ███   █████                    ███
"  ░░░              ░░░   ░░███                    ░░░
"  ████  ████████   ████  ███████      █████ █████ ████  █████████████
" ░░███ ░░███░░███ ░░███ ░░░███░      ░░███ ░░███ ░░███ ░░███░░███░░███
"  ░███  ░███ ░███  ░███   ░███        ░███  ░███  ░███  ░███ ░███ ░███
"  ░███  ░███ ░███  ░███   ░███ ███    ░░███ ███   ░███  ░███ ░███ ░███
"  █████ ████ █████ █████  ░░█████  ██  ░░█████    █████ █████░███ █████
" ░░░░░ ░░░░ ░░░░░ ░░░░░    ░░░░░  ░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░

" TODO: Consider switching to lua.
" TODO: Split between several files.

" = Basic settings =

" Enable hybrid line numbering.
set number

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
augroup END

" Enable hidden buffers.
set hidden

" Make CursorHold autocommands faster.
set updatetime=250

" Enable mouse use.
set mouse=a

" Fix indentation.
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Use 24-bit (true-color) mode.
if (empty($TMUX))
	" For Neovim 0.1.3 and 0.1.4
	if (has("nvim"))
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif

	" For Neovim > 0.1.5
	if (has("termguicolors"))
		set termguicolors
	endif
endif

" Don't display the current mode.
set noshowmode

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Display a colored beam at column 80.
set colorcolumn=80

" Disable line wrapping.
set nowrap

" Open horizontal splits below.
set splitbelow
" Open vertical splits right.
set splitright

" Highlight yanked lines.
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
augroup END

" Use ALT + hjkl to resize windows.
nnoremap <M-j> :resize -1<CR>
nnoremap <M-k> :resize +1<CR>
nnoremap <M-h> :vertical resize -1<CR>
nnoremap <M-l> :vertical resize +1<CR>

" Enable autocompletion menu.
set completeopt=menu,menuone,noselect

" Alias <leader>y to "+y
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" Alias <leader>p to "+p
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Alias S to replace all.
nnoremap S :%s///g<Left><Left><Left>

" Alias CTRL + t to newtab.
nnoremap <silent> <C-t> :tabnew<CR>

" Automatically delete trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" = Plugins =

call plug#begin()

" Color theme.
Plug 'ellisonleao/gruvbox.nvim'
" Autocompletion and snippets for native LSP.
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" Automatic bracket pairing.
Plug 'jiangmiao/auto-pairs'
" Documentation generator.
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
" Performance.
Plug 'lewis6991/impatient.nvim'
" Show VCS diffs.
Plug 'mhinz/vim-signify'
" Start page.
Plug 'mhinz/vim-startify'
" Faster startup time.
Plug 'nathom/filetype.nvim'
" Enable native LSP.
Plug 'neovim/nvim-lspconfig'
" Color highlighter.
Plug 'norcalli/nvim-colorizer.lua'
" Statusline.
Plug 'nvim-lualine/lualine.nvim'
" Dependency.
" TODO: check if I still need this.
Plug 'nvim-lua/plenary.nvim'
" Fuzzy finder.
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Better syntax highlighting.
" TODO: change to master branch once neovim 0.6 arrives.
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate', 'branch': '0.5-compat' }
" Dependency for some color themes.
" TODO: check if I still need this.
Plug 'rktjmp/lush.nvim'
" Dev icons.
Plug 'ryanoasis/vim-devicons'
" UI for native LSP.
" TODO: change to master branch once neovim 0.6 arrives.
Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim51' }
" Line commenting keybindings.
Plug 'tpope/vim-commentary'
" Git integration.
Plug 'tpope/vim-fugitive'
" Personal wiki.
Plug 'vimwiki/vimwiki'
" Easy LSP installation.
Plug 'williamboman/nvim-lsp-installer'

call plug#end()

lua << END

-- impatient needs to setup before any other lua plugin.
require('impatient')

require('colorizer').setup()
require('filetype')
require('lualine').setup {
	tabline = {
		lualine_a = {'tabs'},
		lualine_b = {'buffers'},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {}
	},
    inactive_sections = {}
}
require('lspsaga')
require('telescope').setup()
require('telescope').load_extension('fzf')

local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
    },
    mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
		    elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
		    else
				fallback()
		    end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),

		['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
    }, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/`
-- (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
-- (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
    }, {
		{ name = 'cmdline' }
    })
})

local capabilities = require('cmp_nvim_lsp')
	.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true }
}

END

" = nvim-lspconfig and lspsaga =

" Show diagnostics.
nnoremap <silent> <leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
" Jump diagnostics.
nnoremap <silent> [d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
" Show hover doc.
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" Show signature help.
nnoremap <silent> <C-k> <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" Rename.
nnoremap <silent> <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
" Open float terminal.
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <C-f> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

" = filetype.nvim =

lua << END

vim.g.did_load_filetypes = 1

END

" = lsp-installer =

lua << END

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)

END

" = telescope =

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <silent> gd <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <silent> gr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent> gi <cmd>lua require('telescope.builtin').lsp_implementations><CR>
nnoremap <silent> ca <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>

" = gruvbox =

let g:gruvbox_italic=1

colorscheme gruvbox

