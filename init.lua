-- [[ Native config ]]
require 'options'
require 'keymaps'
require 'core-lsp'

-- [[ Plugin config ]]
require 'plugins.minideps'
require 'plugins.colorscheme'
require 'plugins.statusline'
require 'plugins.git'
require 'plugins.fuzzyfind'
require 'plugins.treesitter'
require 'plugins.lsp'

--   { -- Autoformat
--     'stevearc/conform.nvim',
--     event = { 'BufWritePre' },
--     cmd = { 'ConformInfo' },
--     keys = {
--       {
--         '<leader>f',
--         function()
--           require('conform').format { async = true, lsp_format = 'fallback' }
--         end,
--         mode = '',
--         desc = '[F]ormat buffer',
--       },
--     },
--     opts = {
--       notify_on_error = false,
--       format_on_save = function(bufnr)
--         -- Disable "format_on_save lsp_fallback" for languages that don't
--         -- have a well standardized coding style. You can add additional
--         -- languages here or re-enable it for the disabled ones.
--         local disable_filetypes = { c = true, cpp = true }
--         if disable_filetypes[vim.bo[bufnr].filetype] then
--           return nil
--         else
--           return {
--             timeout_ms = 500,
--             lsp_format = 'fallback',
--           }
--         end
--       end,
--       formatters_by_ft = {
--         lua = { 'stylua' },
--         -- Conform can also run multiple formatters sequentially
--         -- python = { "isort", "black" },
--         --
--         -- You can use 'stop_after_first' to run the first available formatter from the list
--         -- javascript = { "prettierd", "prettier", stop_after_first = true },
--       },
--     },
--   },
--
--   -- Highlight todo, notes, etc in comments
--   { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
--
--   { -- Collection of various small independent plugins/modules
--     'echasnovski/mini.nvim',
--     config = function()
--       -- Better Around/Inside textobjects
--       --
--       -- Examples:
--       --  - va)  - [V]isually select [A]round [)]paren
--       --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--       --  - ci'  - [C]hange [I]nside [']quote
--       require('mini.ai').setup { n_lines = 500 }
--
--       -- Simple and easy statusline.
--       --  You could remove this setup call if you don't like it,
--       --  and try some other statusline plugin
--       local statusline = require 'mini.statusline'
--       -- set use_icons to true if you have a Nerd Font
--       statusline.setup { use_icons = vim.g.have_nerd_font }
--
--       -- You can configure sections in the statusline by overriding their
--       -- default behavior. For example, here we set the section for
--       -- cursor location to LINE:COLUMN
--       ---@diagnostic disable-next-line: duplicate-set-field
--       statusline.section_location = function()
--         return '%2l:%-2v'
--       end
--
--       -- ... and there is more!
--       --  Check out: https://github.com/echasnovski/mini.nvim
--     end,
--   },
-- }
