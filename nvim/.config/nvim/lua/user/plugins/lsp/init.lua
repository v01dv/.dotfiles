-- Brief aside: **What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer

return {
  {
    'neovim/nvim-lspconfig',
    -- event = { 'BufReadPre', 'BufNewFile' },
    event = 'LazyFile',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
      {
        'j-hui/fidget.nvim',
        -- config = true,
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      {
        'smjonas/inc-rename.nvim',
        config = true,
      },
    },
    -- By default, we don’t configure any language server.
    -- For each programming language, we will provide the configuration under the lang folder.
    config = function(_, opts)
      -- -- Hover configuration
      -- local original_hover = vim.lsp.buf.hover
      -- vim.lsp.buf.hover = function()
      --   return original_hover {
      --     -- h: vim.lsp.util.open_floating_preview.Opts
      --     max_width = 100,
      --     -- max_height = 14,
      --     -- style = 'minimal',
      --     border = 'rounded',
      --     source = 'always',
      --     title = ' LSP Hover ',
      --     title_pos = 'center', -- "left" | "center" | "right"
      --   }
      -- end
      --
      -- -- Signature help configuration
      -- local signature_help = vim.lsp.buf.signature_help
      -- vim.lsp.buf.signature_help = function()
      --   return signature_help {
      --     max_width = 100,
      --     -- max_height = 14,
      --     -- style = 'minimal',
      --     border = 'rounded',
      --     source = 'always',
      --     title = ' Signature Help ',
      --     title_pos = 'center',
      --   }
      -- end

      -- TODO: make this work
      OhVim.lsp.on_attach(function(client, buffer)
        -- require('lazyvim.plugins.lsp.keymaps').on_attach(client, buffer)
      end)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode, opts)
            mode = mode or 'n'
            -- vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            opts = vim.tbl_extend('force', { buffer = event.buf, desc = 'LSP: ' .. desc }, opts or {})
            vim.keymap.set(mode, keys, func, opts)
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>. To jump next, press <C-i>.
          -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gd', '<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>', 'Goto Definition')

          -- Find references for the word under your cursor.
          -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gr', '<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>', 'References')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          -- map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('gI', '<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>', 'Goto Implementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          -- map('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe Definition')
          -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe Definition')
          map('gy', '<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>', 'Goto Type Definition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, 'LSP: Goto Declaration')

          -- Show the signature of the function you're currently completing.
          map('gK', vim.lsp.buf.signature_help, 'LSP: Signature Help')
          map('<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature Help', { 'i' })

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Action', { 'n', 'x' })
          map('<leader>cc', vim.lsp.codelens.run, 'LSP: Run Codelens', { 'n', 'x' })
          map('<leader>cC', vim.lsp.codelens.enable, 'LSP: Refresh & Display Codelens')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          -- map('<leader>cr', function()
          map('<leader>cr', function()
            if pcall(require, 'inc_rename') then
              return ':IncRename ' .. vim.fn.expand '<cword>'
            else
              vim.lsp.buf.rename()
            end
            -- NOTE: When you return a string from the callback function and want it to be executed
            -- as a command, you must use { expr = true }.
          end, 'Rename', 'n', { expr = true })

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- If you're working in a monorepo, LSP and build tools need to understand
          -- the full project tree, which is why tools like vim.lsp.buf.add_workspace_folder()
          -- become useful — you might open a file in /monorepo/apps/app1, but
          -- want the LSP to also understand /monorepo/libs/shared
          map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          map('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              -- map(']oh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end

          -- folds
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_foldingRange, event.buf) then
            vim.api.nvim_set_option_value('foldmethod', 'expr', { scope = 'local' })
            vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.lsp.foldexpr()', { scope = 'local' })
          end

          -- code lens
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_codeLens, event.buf) then
            vim.lsp.codelens.enable()
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              buffer = buffer,
              callback = function()
                vim.lsp.codelens.enable()
              end,
            })
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      local icons = require 'user.config.icons'

      -- h: vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        -- Options for floating windows.
        -- h: vim.diagnostic.Opts.Float
        -- float = { border = 'rounded', source = 'if_many' },
        float = { border = 'rounded', source = true },
        -- To displays wavy (undercurl, squiggly underline) line below the diagnostic text
        -- Your terminal needs to support such type of line.
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        } or {},
        -- virtual_text = false,
        virtual_text = {
          source = true,
          -- source = 'if_many',
          prefix = '●', -- " ", -- ■
          -- This will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- prefix = function(diagnostic)
          --   for d, icon in pairs(icons.diagnostics) do
          --     if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
          --       return icon
          --     end
          --   end
          --   return '●'
          -- end,
          -- spacing = 2,
          current_line = true,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
        -- New feature in neovim 0.11: shows diagnostics as separate “virtual lines” in a buffer.
        -- Details: https://gpanders.com/blog/whats-new-in-neovim-0-11/
        -- virtual_lines = {
        --   -- Only show virtual line diagnostics for the current cursor line
        --   current_line = true,
        -- },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = {
        textDocument = {
          -- Tell the server the capability of foldingRange,
          -- Neovim hasn't added foldingRange to default capabilities,
          -- users must add it manually
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
          -- Some language servers have snippet support built-in.
          -- And if they do I want to turn it on in most cases.
          -- capabilities.textDocument.completion.completionItem.snippetSupport = true
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      }

      -- https://cmp.saghen.dev/installation#merging-lsp-capabilities
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      require('mason-lspconfig').setup {
        -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
        ensure_installed = {},
        -- Whether installed servers should automatically be enabled via `:h vim.lsp.enable()`.
        -- Default: true
        automatic_enable = vim.tbl_keys(opts.servers or {}),
      }

      -- Installed LSPs are configured and enabled automatically with mason-lspconfig
      -- The loop below is for overriding the default configuration of LSPs with the ones in the servers table
      for server_name, config in pairs(opts.servers) do
        -- For each LSP server (cfg), we merge:
        -- 1. A fresh empty table (to avoid mutating capabilities globally)
        -- 2. Your capabilities object with Neovim + cmp features
        -- 3. Any server-specific cfg.capabilities if defined in `servers`

        -- This handles overriding only values explicitly passed
        -- by the server configuration in capabilities option . Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for ts_ls)
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        vim.lsp.config(server_name, config)

        -- There is no need to enable it manually because it is enabled automatically in the mason-lspconfig above.
        -- vim.lsp.enable(server)
      end

      -- NOTE: Some servers may require an old setup until they are updated. For the full list refer here: https://github.com/neovim/nvim-lspconfig/issues/3705
      -- These servers will have to be manually set up with require("lspconfig").server_name.setup{}
    end,
  },

  -- cmdline tools and lsp servers
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ui = {
        border = 'rounded',
      },
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger {
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
