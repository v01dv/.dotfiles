return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      { 'rcarriga/nvim-dap-ui' },
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'jay-babu/mason-nvim-dap.nvim' },
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
          commented = true,
        },
      },
      { 'nvim-neotest/nvim-nio' },
      {
        'LiadOz/nvim-dap-repl-highlights',
        opts = {},
      },
      'igorlfs/nvim-dap-view',
    },
    opts = {
      setup = {},
    },
    config = function(plugin, opts)
      -- https://github.com/alpha2phi/modern-neovim/blob/main/lua/plugins/dap/init.lua
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
      -- stylua: ignore start
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = ""})
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DapBreakpointCondition", linehl = "", numhl = ""}) -- 'ﳁ' 'B'
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = ""}) -- 'L'
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedLine", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }) -- '' "󰁕 "
      vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }) -- ''
      -- stylua: ignore end

      -- dap.set_log_level("TRACE")

      -- require('nvim-dap-virtual-text').setup {
      --   commented = true,
      -- }

      require('user.plugins.dap.dap-keymaps').dap_keymaps()

      -- set up debugger
      for k, _ in pairs(opts.setup) do
        opts.setup[k](plugin, opts)
      end
    end,
  },
  -- {
  --   'Jorenar/nvim-dap-disasm',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'mfussenegger/nvim-dap',
  --     'rcarriga/nvim-dap-ui',
  --   },
  --   config = function()
  --     require('dap-disasm').setup {
  --       ins_before_memref = 64,
  --       ins_after_memref = 64,
  --       columns = { 'address', 'instruction' },
  --     }
  --   end,
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'dap_repl',
      },
    },
  },
  {
    'igorlfs/nvim-dap-view',
    opts = {
      winbar = {
        show = true,
        -- You can add a "console" section to merge the terminal with the other views
        sections = { 'console', 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'disassembly' },
        controls = {
          enabled = true,
          position = 'right',
          buttons = {
            'play',
            'step_into',
            'step_over',
            'step_out',
            'step_back',
            'run_last',
            'terminate',
            'disconnect',
          },
          custom_buttons = {},
        },
      },
    },
  },

  {
    'rcarriga/nvim-dap-ui',
    opts = {
      expand_lines = true,
      -- icons = { expanded = '▾', collapsed = '▸' },
      icons = { expanded = '󰅀 ', collapsed = '󰅂 ' },
      -- icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      -- Layouts define sections of the screen to place windows.
      -- The position can be "left", "right", "top" or "bottom".
      -- The size specifies the height/width depending on position. It can be an Int
      -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
      -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
      -- Elements are the elements shown in the layout (in order).
      -- Layouts are opened in order so that earlier layouts take priority in window sizing.
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.33 },
            { id = 'breakpoints', size = 0.17 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
            { id = 'rtt', size = 0.33 },
          },
          size = 0.33,
          position = 'right',
        },
        {
          elements = {
            { id = 'repl', size = 0.45 },
            { id = 'console', size = 0.55 },
          },
          size = 0.27, -- 27% of total lines
          position = 'bottom',
        },
        {
          elements = {
            { id = 'disassembly' },
          },
          position = 'bottom',
          size = 0.15,
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        -- border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
        border = 'rounded', -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
    },
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)

      -- You can use nvim-dap events to open and close the windows automatically (:help dap-extensions)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
        -- dapui.open { reset = true } -- Details: https://theosteiner.de/debugging-javascript-frameworks-in-neovim
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  -- mason.nvim integration
  {
    -- We need the actual programs to connect to running instances of our code.
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      automatic_setup = true,
      handlers = {},
      -- Note: this plugin uses the dap adapter names in the APIs it exposes - not mason.nvim package names
      -- See https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
      ensure_installed = {},
    },
  },
  -- mason-nvim-dap is loaded when nvim-dap loads
  config = function() end,
}
