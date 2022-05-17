-- Source: https://github.com/whatsthatsmell/dots/blob/master/public%20dots/vim-nvim/lua/joel/globals.lua
--         https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/lua/theprimeagen/init.lua

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

-- Source: https://github.com/whatsthatsmell/dots/blob/master/public%20dots/vim-nvim/lua/joel/globals.lua
-- Debug Notification
-- (value, context_message)
DN = function(v, cm)
  local time = os.date "%H:%M"
  local context_msg = cm or " "
  local msg = context_msg .. " " .. time
  require "notify"(vim.inspect(v), "debug", { title = { "Debug Output", msg } })
  return v
end
