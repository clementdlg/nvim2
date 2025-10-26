-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	-- 🌙 Tokyonight colorscheme
	{
		'folke/tokyonight.nvim',
		priority = 1000,
	},

	-- 🔭 Telescope + dependencies
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable('make') == 1
				end,
			},
		},
	},

	-- ⚙️ LSP config
	{ 'neovim/nvim-lspconfig' },

	-- 🧠 Completion (blink.cmp)
	{ 'saghen/blink.cmp' },

	-- 🌳 Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		branch = 'master', -- equivalent of `checkout`
	},

	-- 📊 Mini.statusline
	{ 'echasnovski/mini.statusline' },
})
