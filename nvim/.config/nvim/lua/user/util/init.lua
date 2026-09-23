-- local LazyUtil = require 'lazy.core.util'

local M = {}

setmetatable(M, {
  __index = function(t, k)
    -- if LazyUtil[k] then
    --   return LazyUtil[k]
    -- end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require('user.util.' .. k)
    return t[k]
  end,
})
--
--- Insert values into a list if they don't already exist
---@param tbl string[]
---@param vals string|string[]
function M.list_insert_unique(tbl, vals)
  if type(vals) ~= 'table' then
    vals = { vals }
  end
  for _, val in ipairs(vals) do
    if not vim.tbl_contains(tbl, val) then
      table.insert(tbl, val)
    end
  end
end

---@param name string
function M.get_plugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

---@param plugin string
function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

-- FIX: Looks like as duplicattion of the has() function
--- Check if a plugin is installed via Lazy.nvim
---@param name string The plugin name, e.g. "telescope.nvim"
---@return boolean is_installed
function M.is_plugin_installed(name)
  return require('lazy.core.config').plugins[name] ~= nil
end

M.lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }

-- Register the custom LazyFile event
-- Based on: https://github.com/LazyVim/LazyVim/discussions/1583#discussioncomment-7187450
function M.lazy_file()
  -- Add support for the LazyFile event
  local Event = require 'lazy.core.handler.event'

  Event.mappings.LazyFile = { id = 'LazyFile', event = M.lazy_file_events }
  Event.mappings['User LazyFile'] = Event.mappings.LazyFile
end

local cache = {} ---@type table<(fun()), table<string, any>>
---@generic T: fun()
---@param fn T
---@return T
function M.memoize(fn)
  return function(...)
    local key = vim.inspect { ... }
    cache[fn] = cache[fn] or {}
    if cache[fn][key] == nil then
      cache[fn][key] = fn(...)
    end
    return cache[fn][key]
  end
end

---@alias NotifyOpts {level?:number, once?:boolean}

---@param msg string|string[]
---@param opts? NotifyOpts
function M.notify(msg, opts)
  if vim.in_fast_event() then
    return vim.schedule(function()
      M.notify(msg, opts)
    end)
  end

  opts = opts or {}
  if type(msg) == 'table' then
    msg = table.concat(
      vim.tbl_filter(function(line)
        return line or false
      end, msg),
      '\n'
    )
  end
  local n = opts.once and vim.notify_once or vim.notify
  n(msg, opts.level or vim.log.levels.INFO)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.error(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.info(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.INFO
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.warn(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.WARN
  M.notify(msg, opts)
end

return M
