-- [[ Native config ]]
require 'options'
require 'keymaps'
require 'core-lsp'

-- [[ Plugin config ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- 🌙 Tokyonight colorscheme
	{
		'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
			require('tokyonight').setup {
				style = 'night',
				transparent = true,
			}

			vim.cmd.colorscheme('tokyonight')
		end
	},
})

-- require 'plugins.colorscheme'
-- require 'plugins.statusline'
-- require 'plugins.git'
-- require 'plugins.fuzzyfind'
-- require 'plugins.lsp'
-- require 'plugins.treesitter'
