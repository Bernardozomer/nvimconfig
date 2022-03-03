local status_ok, configs = pcall(require, 'alpha.themes.dashboard')
if not status_ok then
	return
end

configs.section.header.val = {
[[                                             o8o                   ]],
[[                                             `"'                   ]],
[[ooo. .oo.    .ooooo.   .ooooo.  oooo    ooo oooo  ooo. .oo.  .oo.  ]],
[[`888P"Y88b  d88' `88b d88' `88b  `88.  .8'  `888  `888P"Y88bP"Y88b ]],
[[ 888   888  888ooo888 888   888   `88..8'    888   888   888   888 ]],
[[ 888   888  888    .o 888   888    `888'     888   888   888   888 ]],
[[o888o o888o `Y8bod8P' `Y8bod8P'     `8'     o888o o888o o888o o888o]],
}

configs.section.buttons.val = {
	configs.button("e", "  New file", ":ene <BAR>startinsert<CR>"),
	configs.button(vim.api.nvim_replace_termcodes("<leader>f", true, false, true), "  Find files", ":Telescope find_files<CR>"),
	configs.button(vim.api.nvim_replace_termcodes("<leader>s", true, false, true), "  File browser", ":Telescope file_browser<CR>"),
	configs.button(vim.api.nvim_replace_termcodes("<leader>o", true, false, true), "  Old files", ":Telescope oldfiles<CR>"),
	configs.button(vim.api.nvim_replace_termcodes("<leader>lg", true, false, true), "  Live grep", ":Telescope live_grep<CR>"),
	configs.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
	configs.button("q", "✖  Quit Neovim", ":qa<CR>"),
}

