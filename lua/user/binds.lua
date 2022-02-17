local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Yank to system clipboard
keymap('n', '<leader>y', '"+y<CR>', opts)
keymap('v', '<leader>y', '"+y<CR>', opts)
keymap('x', '<leader>y', '"+y<CR>', opts)

-- Paste from system clipboard
keymap('n', '<leader>p', '"+p', opts)
keymap('v', '<leader>p', '"+p', opts)

-- Toggle search highlighting
keymap('n', '<C-s>', ':set hlsearch!<CR>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

keymap('i', '<C-h>', '<C-w>h', opts)
keymap('i', '<C-j>', '<C-w>j', opts)
keymap('i', '<C-k>', '<C-w>k', opts)
keymap('i', '<C-l>', '<C-w>l', opts)

keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Better window resizing
keymap('n', '<M-j>', ':resize -1<CR>', opts)
keymap('n', '<M-k>', ':resize +1<CR>', opts)
keymap('n', '<M-h>', ':vertical resize -1<CR>', opts)
keymap('n', '<M-l>', ':vertical resize +1<CR>', opts)

keymap('i', '<M-j>', ':resize -1<CR>', opts)
keymap('i', '<M-k>', ':resize +1<CR>', opts)
keymap('i', '<M-h>', ':vertical resize -1<CR>', opts)
keymap('i', '<M-l>', ':vertical resize +1<CR>', opts)

-- Better terminal usage
keymap('n', '<C-_>', ':split<CR> :resize 8<CR> :term<CR>', opts)

-- Better buffer navigation
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Replace all
keymap('n', 'S', ':%s///g<Left><Left><Left>', opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Plugin: telescope
keymap('n', '<leader>f', '<cmd>lua require(\'telescope.builtin\').find_files()<CR>', opts)
keymap('n', '<leader>o', '<cmd>lua require(\'telescope.builtin\').oldfiles()<CR>', opts)
keymap('n', '<leader>lg', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>', opts)
keymap('n', '<leader>b', '<cmd>lua require(\'telescope.builtin\').buffers()<CR>', opts)
keymap('n', '<leader>cm', '<cmd>lua require(\'telescope.builtin\').commands()<CR>', opts)
keymap('n', '<leader>k', '<cmd>lua require(\'telescope.builtin\').keymaps()<CR>', opts)
keymap('n', '<leader>h', '<cmd>lua require(\'telescope.builtin\').help_tags()<CR>', opts)

keymap('n', '<leader>ca', '<cmd>lua require(\'telescope.builtin\').lsp_code_actions()<CR>', opts)
keymap('n', 'gr', '<cmd>lua require(\'telescope.builtin\').lsp_references()<CR>', opts)
keymap('n', '<leader>d', '<cmd>lua require(\'telescope.builtin\').diagnostics()<CR>', opts)

keymap('n', '<leader>gb', '<cmd>lua require(\'telescope.builtin\').git_branches()<CR>', opts)

keymap('n', '<leader>e', '<cmd>lua require(\'telescope\').extensions.emoji.emoji()<CR>', opts)
keymap('n', '<leader>s', '<cmd>lua require(\'telescope\').extensions.file_browser.file_browser()<CR>', opts)
