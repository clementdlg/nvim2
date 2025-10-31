MiniDeps.add({
	source = 'nvim-treesitter/nvim-treesitter',
	checkout = 'master',
	monitor = 'main',
	hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

local languages = require('languages').highlight_syntax

require('nvim-treesitter.configs').setup({
	ensure_installed = languages,
	highlight = { enable = true },
	auto_install = false,
	-- sync_install = true,
	-- disable for large files
	disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,
})
