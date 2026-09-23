-- https://deepwiki.com/rest-nvim/rest.nvim/1-introduction-to-rest.nvim
return {
  {
    'rest-nvim/rest.nvim',
    ft = { 'http', 'rest' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
    -- keys = {
    --   { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
    -- },
    config = function()
      require('rest-nvim').setup {
        env = {
          find = function()
            local config = require 'rest-nvim.config'
            return vim.fs.find(function(name, _)
              return name:match(config.env.pattern)
            end, {
              path = OhVim.root.get(),
              type = 'file',
              limit = math.huge,
            })
          end,
          -- find = function()
          --   -- Custom function to find environment files
          --   return vim.fn.glob('~/projects/envs/*.env', false, true)
          -- end,
        },
        _log_level = vim.log.levels.DEBUG,
      }

      -- To have response body proper formatted.
      -- Details: https://github.com/rest-nvim/rest.nvim/issues/414#issuecomment-2308629381
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('fix_rest_formatting', { clear = true }),
        pattern = 'json',
        callback = function(ev)
          -- If formatexpr is set → Neovim uses it instead of formatprg.
          -- So only set one — or set formatexpr = "" if switching to formatprg.
          --
          -- Formatting with Conform
          -- vim.bo[ev.buf].formatexpr = "v:lua.require'conform'.formatexpr()"
          --
          -- Formatting with jq
          vim.bo[ev.buf].formatexpr = ''
          vim.bo[ev.buf].formatprg = 'jq'
        end,
      })

      local function rest_env_select(_)
        local dotenv = require 'rest-nvim.dotenv'
        local lines = dotenv.find_env_files()

        require('fzf-lua').fzf_exec(lines, {
          prompt = 'Select Env File❯ ',
          previewer = 'builtin',
          actions = {
            ['default'] = function(selected)
              dotenv.register_file(selected[1])
            end,
          },
        })
      end

      vim.keymap.set('n', '<leader>Rc', '<cmd>Rest  curl yank<cr>', { desc = 'Rest: Copy as cURL' })
      vim.keymap.set('n', '<leader>RC', '<cmd>Rest  curl comment<cr>', { desc = 'Rest: Paste from curl' })
      vim.keymap.set('n', '<leader>Rs', '<cmd>Rest run<cr>', { desc = 'Rest: Run request under the cursor' })
      vim.keymap.set('n', '<leader>Rr', '<cmd>Rest last<cr>', { desc = 'Rest: Run last request' })

      vim.keymap.set('n', '<leader>Re', function()
        rest_env_select()
      end, { desc = 'Rest: Select environment' })
    end,
  },
}
