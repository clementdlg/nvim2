-- local cfg_path = os.getenv("NVIM_CFG")
--
-- if cfg_path then
--   vim.opt.runtimepath:append(cfg_path)
-- else
--   print("NVIM_CFG not set")
-- end

vim.opt.path:append('**')

-- [[ Plugin config ]]
require 'plugins.lazy'

print('hello world')
