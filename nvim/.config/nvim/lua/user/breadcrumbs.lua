local M = {}

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
  "DressingSelect",
  "Jaq",
  "harpoon",
  "dapui_scopes",
  "dapui_breakpoints",
  "dapui_stacks",
  "dapui_watches",
  "dap-repl",
  "dap-terminal",
  "dapui_console",
  "lab",
  "Markdown",
  "notify",
  "noice",
  "",
}

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "user.functions"

  if not f.isempty(filename) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    local buf_ft = vim.bo.filetype

    if buf_ft == "dapui_breakpoints" then
      file_icon =""
    end

    if buf_ft == "dapui_stacks" then
      file_icon = " "
    end

    if buf_ft == "dapui_scopes" then
      file_icon = ""
    end

    if buf_ft == "dapui_watches" then
      file_icon = ""
    end

    -- if buf_ft == "dapui_console" then
    --   file_icon = lvim.icons.ui.DebugConsole
    -- end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not require("user.functions").isempty(gps_location) then
    return "> " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  return vim.tbl_contains(M.winbar_filetype_exclude or {}, vim.bo.filetype)
  -- if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
  --   vim.opt_local.winbar = nil
  --   return true
  -- end
  -- return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require "user.functions"
  local value = M.get_filename()

  local gps_added = false
  if not f.isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
    if not f.isempty(gps_value) then
      gps_added = true
    end
  end

  if not f.isempty(value) and f.get_buf_option "mod" then
    -- local mod = "%#LspCodeLens#" .. "[x]" .. "%*"
    local mod = "[x]"
    if gps_added then
      -- value = value .. " " .. mod
      value = mod ..  value
    else
      -- value = value .. mod
      value = mod .. value
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not f.isempty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has "nvim-0.8" == 1 then
    vim.api.nvim_create_autocmd(
      { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
      {
        group = "_winbar",
        callback = function()
          local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
          if not status_ok then
            require("user.breadcrumbs").get_winbar()
          end
        end,
      }
    )
  end
end

M.create_winbar()

return M





--
--
-- local M = {}
--
-- -- local Log = require "lvim.core.log"
--
-- M.config = function()
--   breadcrumbs = {
--     active = true,
--     on_config_done = nil,
--     winbar_filetype_exclude = {
--       "help",
--       "startify",
--       "dashboard",
--       "packer",
--       "neo-tree",
--       "neogitstatus",
--       "NvimTree",
--       "Trouble",
--       "alpha",
--       "lir",
--       "Outline",
--       "spectre_panel",
--       "toggleterm",
--       "DressingSelect",
--       "Jaq",
--       "harpoon",
--       "dap-repl",
--       "dap-terminal",
--       "dapui_console",
--       "lab",
--       "Markdown",
--       "notify",
--       "noice",
--       "",
--     },
--     options = {
--       icons = {
--         Array = " ",
--         Boolean = "蘒",
--         Class = " ",
--         Color = " ",
--         Constant = " ",
--         Constructor = " ",
--         Enum = " ",
--         EnumMember = " ",
--         Event = " ",
--         Field = " ",
--         File = " ",
--         Folder = " ",
--         Function = " ",
--         Interface = " ",
--         Key = " ",
--         Keyword = " ",
--         Method = " ",
--         Module = " ",
--         Namespace = " ",
--         Null = "ﳠ ",
--         Number = " ",
--         Object = " ",
--         Operator = " ",
--         Package = " ",
--         Property = " ",
--         Reference = " ",
--         Snippet = " ",
--         String = " ",
--         Struct = " ",
--         Text = " ",
--         TypeParameter = " ",
--         Unit = " ",
--         Value = " ",
--         Variable = " ",
--       },
--       highlight = true,
--       separator = " > ",
--       depth_limit = 0,
--       depth_limit_indicator = "..",
--     },
--   }
-- end
--
-- M.setup = function()
--   local status_ok, navic = pcall(require, "nvim-navic")
--   if not status_ok then
--     return
--   end
--
--   M.create_winbar()
--   navic.setup(breadcrumbs.options)
--
--   if breadcrumbs.on_config_done then
--     breadcrumbs.on_config_done()
--   end
-- end
--
-- M.get_filename = function()
--   local filename = vim.fn.expand "%:t"
--   local extension = vim.fn.expand "%:e"
--   local f = require "lvim.utils.functions"
--
--   if not f.isempty(filename) then
--     local file_icon, file_icon_color =
--       require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
--
--     local hl_group = "FileIconColor" .. extension
--
--     vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
--     if f.isempty(file_icon) then
--       file_icon =""
--     end
--
--     local buf_ft = vim.bo.filetype
--
--     if buf_ft == "dapui_breakpoints" then
--       file_icon =""
--     end
--
--     if buf_ft == "dapui_stacks" then
--       file_icon = " "
--     end
--
--     if buf_ft == "dapui_scopes" then
--       file_icon = ""
--     end
--
--     if buf_ft == "dapui_watches" then
--       file_icon = ""
--     end
--
--     -- if buf_ft == "dapui_console" then
--     --   file_icon = lvim.icons.ui.DebugConsole
--     -- end
--
--     local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
--     vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })
--
--     return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
--   end
-- end
--
-- local get_gps = function()
--   local status_gps_ok, gps = pcall(require, "nvim-navic")
--   if not status_gps_ok then
--     return ""
--   end
--
--   local status_ok, gps_location = pcall(gps.get_location, {})
--   if not status_ok then
--     return ""
--   end
--
--   if not gps.is_available() or gps_location == "error" then
--     return ""
--   end
--
--   if not require("user.functions").isempty(gps_location) then
--     return "%#NavicSeparator#".. ">" .. "%* " .. gps_location
--   else
--     return ""
--   end
-- end
--
-- local excludes = function()
--   return vim.tbl_contains(breadcrumbs.winbar_filetype_exclude or {}, vim.bo.filetype)
-- end
--
-- M.get_winbar = function()
--   if excludes() then
--     return
--   end
--   local f = require "user.functions"
--   local value = M.get_filename()
--
--   local gps_added = false
--   if not f.isempty(value) then
--     local gps_value = get_gps()
--     value = value .. " " .. gps_value
--     if not f.isempty(gps_value) then
--       gps_added = true
--     end
--   end
--
--   if not f.isempty(value) and f.get_buf_option "mod" then
--     -- TODO: replace with circle
--     local mod = "%#LspCodeLens#" .. "" .. "%*"
--     if gps_added then
--       value = value .. " " .. mod
--     else
--       value = value .. mod
--     end
--   end
--
--   local num_tabs = #vim.api.nvim_list_tabpages()
--
--   if num_tabs > 1 and not f.isempty(value) then
--     local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
--     value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
--   end
--
--   local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
--   if not status_ok then
--     return
--   end
-- end
--
-- M.create_winbar = function()
--   vim.api.nvim_create_augroup("_winbar", {})
--   if vim.fn.has "nvim-0.8" == 1 then
--     vim.api.nvim_create_autocmd(
--       { "CursorHoldI", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
--       {
--         group = "_winbar",
--         callback = function()
--           if breadcrumbs.active then
--             local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
--             if not status_ok then
--               -- TODO:
--               require("user.breadcrumbs").get_winbar()
--             end
--           end
--         end,
--       }
--     )
--   end
-- end
--
-- return M
