---@param opts? {cwd:false, subdirectory: true, parent: true, other: true, icon?:string}
local function root_dir(opts)
  opts = vim.tbl_extend('force', {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = '󱉭 ',
    color = { fg = '#f4b8e4' },
    -- color = function()
    --   return { fg = Snacks.util.color 'Special' }
    -- end,
  }, opts or {})

  local function get()
    local cwd = OhVim.root.cwd()
    local root = OhVim.root.get { normalize = true }
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      -- root is subdirectory of cwd
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      -- root is parent directory of cwd
      return opts.parent and name
    else
      -- root and cwd are not related
      return opts.other and name
    end
  end

  return {
    function()
      return (opts.icon and opts.icon .. ' ') .. get()
    end,
    cond = function()
      return type(get()) == 'string'
    end,
    color = opts.color,
  }
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local components = require 'user.plugins.statusline.components'
    local icons = require 'user.config.icons'

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        icons_enabled = true,
        -- theme = 'auto',
        theme = components.theme,
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'dashboard', 'alpha', 'lazy', 'fugitive' },
          winbar = {
            'NvimTree', -- Because don't need to display NvimTree on the top of window
            'dap-repl', -- Without this icons in nvim-dap-ui plugin will not shown
            'help',
            'lazy',
            'neo-tree',
            'kulala_ui', -- Without this the winbar in the result pane will not shown
            'rest_nvim_result', -- Without this the winbar in the result pane will not shown
            'dap-view', -- Without this the winbar, which is needed for nvim-dap-view, will not shown
          },
        },
        ignore_focus = { 'NvimTree' },
        always_divide_middle = true,
        globalstatus = vim.o.laststatus == 3,
      },
      sections = {
        lualine_a = { components.mode },
        lualine_b = { components.branch, root_dir(), components.dap },
        lualine_c = {
          components.diff,
          'filename',
          components.wcount,
          components.formatters,
          components.linters,
          components.cmake_preset,
          components.cmake_build_preset,
          -- components.cmake_build_target,
          components.cmake_target,
        },
        lualine_x = {
          components.windsurf,
          components.diagnostics,
          components.kulala,
          components.rest,
          components.lsp_new,
          components.treesitter,
          components.filetype,
          components.get_spellang,
          components.encoding,
          components.spaces,
        },
        lualine_y = { components.progress },
        lualine_z = { components.location },
      },
      inactive_sections = {
        lualine_a = { components.mode },
        lualine_b = { components.branch },
        lualine_c = { components.diff },
        lualine_x = { components.diagnostics, components.lsp_new, components.treesitter, components.filetype, components.encoding, components.spaces },
        lualine_y = { components.progress },
        lualine_z = { components.location },
      },
      winbar = {
        -- lualine_a = {},
        -- lualine_b = {} ,
        lualine_a = { components.bufcount },
        lualine_b = { components.filename },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = { components.filename },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'quickfix', 'man', 'fugitive', 'trouble', 'lazy', 'mason', 'nvim-dap-ui', 'neo-tree', 'nvim-tree', 'toggleterm', 'oil', 'fzf' },
    }
    return opts
  end,
}
