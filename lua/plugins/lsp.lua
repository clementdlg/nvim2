--[[-------------
	LSP setup 
---------------]]
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
	virtual_text = {
		source = 'if_many',
		spacing = 2,
		format = function(diagnostic) return diagnostic.message end,
	},
}

-- [[ Completion ]]
require('blink.cmp').setup {
	sources = {
		default = { 'lsp', 'path' }
	},
	fuzzy = { implementation = 'lua' },
	signature = { enabled = true },
}

-- [[ Highlights ]]
local function lsp_highlight(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	local method = vim.lsp.protocol.Methods.textDocument_documentHighlight

	-- Only attach highlights if the server supports it
	if not (client and client.supports_method and client:supports_method(method)) then
		return
	end

	local group = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })

	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		buffer = event.buf,
		group = group,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
		buffer = event.buf,
		group = group,
		callback = vim.lsp.buf.clear_references,
	})

	vim.api.nvim_create_autocmd('LspDetach', {
		buffer = event.buf,
		group = vim.api.nvim_create_augroup('lsp_highlight_detach', { clear = true }),
		callback = function(ev)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds({ group = 'lsp_highlight', buffer = ev.buf })
		end,
	})
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event) lsp_highlight(event) end
})
