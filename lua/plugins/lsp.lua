-- [[ LSP setup ]]
MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add({
	source = 'saghen/blink.cmp',
	version = '1.*',
})

-- [[ LSP config ]]
local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
	bashls = {},

	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { 'vim' } },
			},
		},
	},

	ansiblels = {
		settings = {
			ansible = {
				validation = { enabled = false },
			},
		},
	},
}

for name, config in pairs(servers) do
	config.capabilities = capabilities
	vim.lsp.config[name] = config
	vim.lsp.enable(name)
end

-- [[ Diagnostics ]]
local severity = vim.diagnostic.severity

vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = severity.ERROR },
	signs = {
		text = {
			[severity.ERROR] = '󰅚 ',
			[severity.WARN] = '󰀪 ',
			[severity.INFO] = '󰋽 ',
			[severity.HINT] = '󰌶 ',
		},
	},
	virtual_lines = {
		enabled = true,
		source = 'if_many',
		format = function(diagnostic) return diagnostic.message end,
	},
}

-- [[ Completion ]]
-- require('blink.cmp').setup({
--   keymap = { preset = 'default' }, -- basic mappings
--   completion = {
--     auto_trigger = true,        -- automatically open menu when typing
--     min_length = 1,             -- start after 1 character
--     documentation = { auto_show = true },
--     menu = { border = 'rounded' },
--   },
--   appearance = { use_nvim_cmp_as_default = false },
-- })

-- [[ Highlights ]]
