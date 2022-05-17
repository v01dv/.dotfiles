local M = {}
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn


---Get the full path to the cpnfig directory
---@return string
function _G.get_config_dir()
  return vim.fn.stdpath("config")
end

---Get the full path to the cash directory
---@return string
function _G.get_cache_dir()
  return vim.fn.stdpath("cache")
end

---Get the full path to the data directory
---@return string
function _G.get_data_dir()
  return vim.fn.stdpath("data")
end



-- From https://icyphox.sh/blog/nvim-lua/
-- function M.create_augroup(autocmds, name)
--     cmd('augroup ' .. name)
--     cmd('autocmd!')
--     for _, autocmd in ipairs(autocmds) do
--         cmd('autocmd ' .. table.concat(autocmd, ' '))
--     end
--     cmd('augroup END')
-- end

-- Create autocommand groups based on the passed definitions
--
-- The key will be the name of the group, and each definition
-- within the group should have:
--    1. Trigger
--    2. Pattern
--    3. Text
-- just like how they would normally be defined from Vim itself
-- From https://github.com/norcalli/nvim_M/blob/master/lua/nvim_M.lua#L554-L567
function M.create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup '..group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			-- if type(def) == 'table' and type(def[#def]) == 'function' then
			-- 	def[#def] = lua_callback(def[#def])
			-- end
			local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
			api.nvim_command(command)
		end
		api.nvim_command('augroup END')
	end
end

-- TODO: How to use it ?
-- From https://github.com/lvim-tech/lvim/blob/main/lua/core/funcs.lua
M.commands = function(commands)
    for name, c in pairs(commands) do
        local command
        if c.buffer then
            command = 'command!-buffer'
        else
            command = 'command!'
        end
        vim.cmd(command .. ' -nargs=' .. c.nargs .. ' ' .. name .. ' ' .. c.cmd)
    end
end

M.file_exists = function(name)
    local f = io.open(name, 'r')
    return f ~= nil and io.close(f)
end

function M.is_cfg_present(cfg_name)
  -- this returns 1 if it's not present and 0 if it's present
  -- we need to compare it with 1 because both 0 and 1 is `true` in lua
  return fn.empty(fn.glob(vim.loop.cwd() .. cfg_name)) ~= 1
end


-- LSP
function M.add_to_workspace_folder()
    vim.lsp.buf.add_workspace_folder()
end

function M.list_workspace_folders()
    vim.lsp.buf.list_workspace_folders()
end

function M.remove_workspace_folder()
    vim.lsp.buf.remove_workspace_folder()
end

function M.workspace_symbol()
    vim.lsp.buf.workspace_symbol()
end

function M.references()
    vim.lsp.buf.references()
    vim.lsp.buf.clear_references()
end

function M.clear_references()
    vim.lsp.buf.clear_references()
end

function M.code_action()
    vim.lsp.buf.code_action()
end

function M.range_code_action()
    vim.lsp.buf.range_code_action()
end

function M.declaration()
    vim.lsp.buf.declaration()
    vim.lsp.buf.clear_references()
end
function M.definition()
    vim.lsp.buf.definition()
    vim.lsp.buf.clear_references()
end

function M.type_definition()
    vim.lsp.buf.type_definition()
end

function M.document_highlight()
    vim.lsp.buf.document_highlight()
end

function M.document_symbol()
    vim.lsp.buf.document_symbol()
end

function M.implementation()
    vim.lsp.buf.implementation()
end

function M.incoming_calls()
    vim.lsp.buf.incoming_calls()
end

function M.outgoing_calls()
    vim.lsp.buf.outgoing_calls()
end

function M.formatting()
    vim.lsp.buf.formatting()
end

function M.range_formatting()
    vim.lsp.buf.range_formatting()
end

function M.formatting_sync()
    vim.lsp.buf.formatting_sync()
end

function M.hover()
    vim.lsp.buf.hover()
end

function M.rename()
    vim.lsp.buf.rename()
end

function M.signature_help()
    vim.lsp.buf.signature_help()
end

-- Diagnostic
function M.get_all()
    vim.lsp.diagnostic.get_all()
end

function M.get_next()
    vim.lsp.diagnostic.get_next()
end

function M.get_prev()
    vim.lsp.diagnostic.get_prev()
end

function M.goto_next()
    vim.lsp.diagnostic.goto_next()
end

function M.goto_prev()
    vim.lsp.diagnostic.goto_prev()
end

function M.show_line_diagnostics()
    vim.lsp.diagnostic.show_line_diagnostics()
end

function M.virtual_text_toggle()
    require("lsp.virtual_text").toggle()
end

function M.virtual_text_show()
    require("lsp.virtual_text").show()
end
function M.virtual_text_hide()
    require("lsp.virtual_text").hide()
end


-- GIT signs
function M.preview_hunk()
    require('gitsigns').preview_hunk()
end

function M.next_hunk()
    require('gitsigns').next_hunk()
end

function M.prev_hunk()
    require('gitsigns').prev_hunk()
end

function M.stage_hunk()
    require('gitsigns').stage_hunk()
end

function M.undo_stage_hunk()
    require('gitsigns').undo_stage_hunk()
end

function M.reset_hunk()
    require('gitsigns').reset_hunk()
end

function M.reset_buffer()
    require('gitsigns').reset_buffer()
end

function M.blame_line()
    require('gitsigns').blame_line()
end

return M
