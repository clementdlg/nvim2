local M = {}

M.servers = {
	bashls = {},

	lua_ls = {
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				}
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

return M
