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

-- import mason tool list
-- local ensure_installed = require("mason-tools").array
local ensure_installed = {
	'stylua',
	'lua-language-server',
	'bash-language-server',
	'ansible-language-server',
}

-- Setup lazy.nvim
require("lazy").setup({{
	'WhoIsSethDaniel/mason-tool-installer.nvim',

	dependencies = {
		{
			'mason-org/mason.nvim', opts = {}
		}
	},

	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			run_on_start = true,
		})
	end
}})
