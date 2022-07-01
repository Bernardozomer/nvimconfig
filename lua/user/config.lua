-- Enable hybrid line numbers
vim.o.number = true

vim.api.nvim_exec([[
		augroup numbertoggle
			autocmd!
			autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
			autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
		augroup END
	]],
	false
)

-- Make CursorHold events trigger faster
vim.opt.updatetime = 300

-- Fix indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Highlight the cursor line
vim.o.cursorline = true

-- Highlight column 80
vim.o.colorcolumn = "80"

-- Highlight yanked lines
vim.api.nvim_exec([[
		augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
		augroup END
	]],
	false
)

-- Disable line wrapping
vim.o.wrap = false

-- Minimal number of screen lines to keep above and below cursor
vim.opt.scrolloff = 8

-- Minimal number of characters to keep left and right of the cursor
vim.opt.sidescrolloff = 8

-- Don't display the current mode
-- (avoids redundancy with the tabline plugin)
vim.o.showmode = false

-- Fix splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Set colorscheme
vim.o.background = "dark"
pcall(vim.cmd, 'colorscheme gruvbox')

-- Fix autocompletion menu
vim.o.completeopt = 'menu,menuone,noselect'

-- Delete trailing whitespace on save
StripTrailingWhitespaces = function ()
	local l = vim.fn.line('.')
	local c = vim.fn.col('.')
	vim.cmd("%s/\\s\\+$//e")
	-- Preserve cursor position
	vim.cmd(":call cursor(" .. l .. ", " .. c .. ")")
end

vim.api.nvim_exec(
	[[autocmd BufWritePre * :lua StripTrailingWhitespaces()]],
	false
)

