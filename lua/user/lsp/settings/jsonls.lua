-- Find more schemas at https://www.schemastore.org/json/
local schemas = {
}

local opts = {
	settings = {
		json = {
			schemas = schemas,
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
				end,
			},
		},
	},
}

return opts

