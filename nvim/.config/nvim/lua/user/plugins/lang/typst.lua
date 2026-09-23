-- Source:
--  https://myriad-dreamin.github.io/tinymist/frontend/neovim.html
--  https://www.youtube.com/watch?v=8hGZRpD_5HQ
--  https://github.com/SylvanFranklin/.config/blob/main/nvim/lsp/tinymist.lua

-- if not require('user.config').pde.typst then
--   return {}
-- end

local function create_tinymist_command(command_name, client, bufnr)
  local cmd_display = command_name:match 'tinymist%.export(%w+)'
  local function run_tinymist_command()
    local arguments = { vim.api.nvim_buf_get_name(bufnr) }
    return client:exec_cmd({
      title = 'Export ' .. cmd_display,
      command = command_name,
      arguments = arguments,
    }, { bufnr = bufnr })
  end
  return run_tinymist_command, ('Export' .. cmd_display), ('Export to ' .. cmd_display)
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      OhVim.list_insert_unique(opts.ensure_installed, {
        'typst',
      })
    end,
  },
  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'tinymist',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tinymist = {
          settings = {
            formatterMode = 'typstyle',
            exportPdf = 'onType',
            semanticTokens = 'disable',
          },
          on_attach = function(client, bufnr)
            for _, command in ipairs {
              'tinymist.exportSvg',
              'tinymist.exportPng',
              'tinymist.exportPdf',
              'tinymist.exportHtml',
              'tinymist.exportMarkdown',
              -- 'tinymist.exportText',
              -- 'tinymist.exportQuery',
              -- 'tinymist.exportAnsiHighlight',
            } do
              local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
              vim.api.nvim_buf_create_user_command(bufnr, cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
            end
          end,
        },
      },
    },
  },
  {
    'chomosuke/typst-preview.nvim',
    -- lazy = false, -- or ft = 'typst'
    ft = 'typst',
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
