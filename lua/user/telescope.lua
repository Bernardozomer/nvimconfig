local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require "telescope.actions"

telescope.setup {
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				['<esc>'] = actions.close,

				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},
		},
	},
	pickers = {
		commands = {
			theme = 'ivy',
		},
		current_buffer_fuzzy_find = {
			theme = 'cursor',
		},
		diagnostics = {
			theme = 'cursor',
			previewer = false,
		},
		help_tags = {
			theme = 'ivy',
		},
		keymaps = {
			theme = 'ivy',
		},
		lsp_code_actions = {
			theme = 'cursor',
		},
		lsp_range_code_actions = {
			theme = 'cursor',
		},
		registers = {
			theme = 'cursor',
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
}

