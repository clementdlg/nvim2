--[[-----------
	LSP setup 
-----------]]

-- [[ Plugins ]]
MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add({
	source = 'saghen/blink.cmp',
})

-- [[ LSP config ]]
-- use lspconfig's config and override them with my own preferences
local servers = require('lsp_servers').servers
local capabilities = require('blink.cmp').get_lsp_capabilities()

for name, config in pairs(servers) do
	config.capabilities = capabilities
	vim.lsp.config[name] = config
	vim.lsp.enable(name)
end

-- [[ Diagnostics ]]
local severity = vim.diagnostic.severity

vim.diagnostic.config {
	-- severity_sort = true,
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
require('blink.cmp').setup {
	keymap = {
		preset = 'default',
	},
	appearance = {
		nerd_font_variant = 'mono',
	},
	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { 'lsp', 'path' },
	},
	fuzzy = { implementation = 'lua' },
	signature = { enabled = true },
}

-- [[ Highlights ]]
