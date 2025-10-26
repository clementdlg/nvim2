local cfg_path = os.getenv("NVIM_CFG")

if cfg_path then
  vim.opt.runtimepath:prepend(cfg_path)
else
  print("NVIM_CFG not set")
end

print('hello world')
-- [[ Plugin config ]]
require 'plugins.lazy'
