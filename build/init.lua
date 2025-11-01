vim.api.nvim_create_user_command('Build', function()
	require 'install'
end, {})
