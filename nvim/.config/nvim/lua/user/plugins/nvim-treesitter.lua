-- [Understanding Neovim #4 - Treesitter - YouTube](https://www.youtube.com/watch?v=kYXcxJxJVxQ)

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        -- With the new version, the tree-sitter cli is required to install parsers
        'tree-sitter-cli',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    event = { 'LazyFile', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'lua',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'bash',
        'python',
        'css',
        'yaml',
        'c',
        'cpp',
        'css',
        'javascript',
        'typescript',
        'tsx',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'ninja',
        'scss',
        'ssh_config',
        'xml',
        'html',
        'vim',
        'vimdoc',
        'rust',
        'go',
        'dockerfile',
        'rst',
        'toml',
        'ron',
        'xml',
        'http',
        'graphql',
        'hurl',
        'printf',
        'regex',
        'diff',
        'query',
      },
    },
    ---@param opts lazyvim.TSConfig
    config = function(_, opts)
      local TS = require 'nvim-treesitter'

      -- Manual cache reset
      local _installed = nil ---@type table<string,boolean>?

      ---@param update boolean?
      local function get_installed(update)
        if update then
          _installed = {}
          for _, lang in ipairs(require('nvim-treesitter').get_installed 'parsers') do
            _installed[lang] = true
          end
        end
        return _installed or {}
      end

      ---@param what string|number|nil
      ---@overload fun(buf?:number):boolean
      ---@overload fun(ft:string):boolean
      ---@return boolean
      local function have(what)
        what = what or vim.api.nvim_get_current_buf()
        what = type(what) == 'number' and vim.bo[what].filetype or what --[[@as string]]
        local lang = vim.treesitter.language.get_lang(what)
        if lang == nil or get_installed()[lang] == nil then
          return false
        end
        return true
      end

      -- FIX: Need better way to do this
      if OhVim.has 'nvim-dap-repl-highlights' then
        -- You must call nvim-dap-repl-highlights.setup() before
        -- nvim-treesitter.install { 'dap_repl' }, or the dap_repl parser
        -- won't be found.
        require('nvim-dap-repl-highlights').setup()
      else
        OhVim.warn 'You have to install `LiadOz/nvim-dap-repl-highlights` plugin for syntax highlighting in the nvim-dap REPL'
      end

      -- Some quick sanity checks
      if not TS.get_installed then
        return OhVim.error 'Please use `:Lazy` and update `nvim-treesitter`'
      elseif type(opts.ensure_installed) ~= 'table' then
        return OhVim.error '`nvim-treesitter` opts.ensure_installed must be a table'
      end

      -- Setup treesitter
      TS.setup(opts)

      -- initialize the installed langs
      get_installed(true)

      -- Install missing parsers
      local install = vim.tbl_filter(function(lang)
        return not have(lang)
      end, opts.ensure_installed or {})

      if #install > 0 then
        TS.install(install, { summary = true }):await(function()
          get_installed(true) -- refresh the installed langs
        end)
      end

      -- Enable highlighting for a filetype
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('lazyvim_treesitter', { clear = true }),
        callback = function(ev)
          local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)

          if lang == nil or not have(ft) then
            return
          end

          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- folds, provided by Neovim
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    opts = {},
  },
}
