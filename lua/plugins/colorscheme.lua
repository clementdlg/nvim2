MiniDeps.add('folke/tokyonight.nvim')

require('tokyonight').setup {
	style = 'night',
	transparent = true,
}

vim.cmd.colorscheme('tokyonight')
vim.cmd('hi Comment gui=none')
