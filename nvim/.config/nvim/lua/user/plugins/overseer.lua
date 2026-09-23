-- Source: https://www.lazyvim.org/extras/editor/overseer
return {
  {
    'stevearc/overseer.nvim',
    lazy = false, -- plugin is self-lazy-loading
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerRun',
      'OverseerTaskAction',
    },
    opts = {
      dap = false,
      task_list = {
        -- render = function(task)
        -- local render = require 'overseer.render'
        -- return { render.status(task), { { task.name, 'OverseerTask' } }, { render.format_verbose(task) } }

        -- return vim.list_extend({
        --   { { task.name, 'OverseerTask1' } },
        -- }, render.source_lines(task, { num_lines = 3, prefix = '$ ' })),
        -- return require('overseer.render').format_verbose(task)
        -- return require('overseer.render').format_compact(task)
        -- return require('overseer.render').format_standard(task)
        -- end,
        keymaps = {
          ['<C-j>'] = false,
          ['<C-k>'] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
      -- default = {},
      -- template_dirs = { 'lua/user/plugins/overseer/templates/' },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle!<cr>",    desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",        desc = "Run task" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
    },
    config = function(_, opts)
      local overseer = require 'overseer'
      overseer.setup(opts)

      require 'user.plugins.overseer.stm32_tasks'
    end,
  },
  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = 'Overseer',
        ft = 'OverseerList',
        open = function()
          require('overseer').open()
        end,
      })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    opts = function()
      require('overseer').enable_dap()
    end,
  },
  {
    'nvim-neotest/neotest',
    opts = function(_, opts)
      opts = opts or {}
      opts.consumers = opts.consumers or {}
      opts.consumers.overseer = require 'neotest.consumers.overseer'
    end,
  },
}
