if not require('user.config').pde.ai then
  return {}
end

return {
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'saghen/blink.cmp',
    },
    -- stylua: ignore
    config = function ()
      -- vim.g.codeium_disable_bindings = 1
      require("codeium").setup({
        enable_cmp_source = vim.g.ai_cmp,
        virtual_text = {
          enabled = not vim.g.ai_cmp,
          -- Set to true if you never want completions to be shown automatically.
          manual = vim.g.ai_cmp,
          -- Key bindings for managing completions in virtual text mode.
          key_bindings = {
              -- Accept the current completion.
              accept = "<C-g>",
              -- accept = false, -- handled by nvim-cmp / blink.cmp
              -- Accept the next word.
              accept_word = false,
              -- Accept the next line.
              accept_line = false,
              -- Clear the virtual text.
              clear = "<C-x>",
              -- Cycle to the next completion.
              next = "<M-]>",
              -- Cycle to the previous completion.
              prev = "<M-[>",
          },
          default_filetype_enabled = true,
          filetypes = {
            TelescopePrompt = false,  -- disables Codeium in Telescope input
            OverseerForm = false,  -- disables Codeium in Overseer parameter form input
            dapui_watches = false,  -- disables Codeium in dapui watches input
            -- dap-repl = false,  -- disables Codeium in dap repl input
          },
          workspace_root = {
            find_root = OhVim.root(),
          },
        },
        -- https://github.com/kien5436/kickstart.nvim/blob/7d501595870e087c6e460dd2d1926af05635f852/lua/kickstart/plugins/codeium.lua
        -- virtual_text = {
        --   enabled = true,
        -- },
        -- default_filetype_enabled = true,
        -- filetypes = {
        --   html = true,
        --   typescript = true,
        --   javascript = true,
        --   css = true,
        --   json = true,
        --   java = true,
        -- },
      })
      -- vim.keymap.set("i", "<C-d>", function() require('codeium.virtual_text').complete() end, { expr = true })

      -- vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
      -- vim.keymap.set("i", "<M-]", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
      -- vim.keymap.set("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      -- vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
      -- vim.keymap.set("i", "<M-space>", function() return vim.fn["codeium#Complete"]() end, { expr = true })
    end,
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      'Exafunction/windsurf.nvim',
      'saghen/blink.compat',
    },
    opts = {
      sources = {
        default = { 'codeium' },
        providers = {
          codeium = {
            name = 'Codeium',
            module = 'codeium.blink',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {
        function()
          -- return '😄'
          return '🦄'
          -- local icon = require('user.config.icons').kind.Codeium
        end,
      })
    end,
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     table.insert(opts.sections.lualine_x, 2, {
  --       function()
  --         local icon = require("user.config.icons").kind.Codeium
  --         -- if not vim.g.loaded_codeium then
  --         --   return
  --         -- end
  --         local status = vim.api.nvim_call_function("codeium#GetStatusString", {})
  --         -- print(vim.inspect(require("cmp").core.sources))
  --         -- if status == "ON" or status == "OFF" then
  --         --   return icon
  --         -- else
  --           return icon .. (status or "")
  --         -- end
  --         -- return icon
  --       end,
  --     })
  --   end,
  -- },

  -- the opts function can also be used to change the default opts:
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   opts = function(_, opts)
  --     table.insert(opts.sections.lualine_x, {
  --       function()
  --         return '😄'
  --         -- return '󰮯'
  --         -- return ''
  --       end,
  --     })
  --   end,
  -- },
}
