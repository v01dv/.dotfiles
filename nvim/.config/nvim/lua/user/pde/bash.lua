if not require("user.config").pde.bash then return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bash" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bash-debug-adapter" , "shellcheck", "shfmt"})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        -- bashls
        bashls = {
          filetypes = { "sh", "zsh" },
          -- NOTE: Feature described here: https://github.com/bash-lsp/bash-language-server/pull/45
          -- FIX: explainshell doesn't work because of issue https://github.com/bash-lsp/bash-language-server/issues/1107
          -- explainshellEndpoint = "https://explainshell.com",
          -- settings = {
          --   bashIde = {
          --     includeAllWorkspaceSymbols = true,
          --     shellcheckArguments = {
          --       string.format("--source-path=%s", vim.loop.cwd()),
          --     },
          --   },
          -- },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      table.insert(opts.sources, nls.builtins.formatting.shfmt)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        bash_debug_adapter = function()
          local dap = require "dap"

          local install_path = require("mason-registry").get_package("bash-debug-adapter"):get_install_path()
          local install_lib = install_path .. "/extension/bashdb_dir"

          dap.adapters.bashdb = {
            type = 'executable';
            command = install_path .. "/bash-debug-adapter";
            name = 'bashdb';
          }

          dap.configurations.sh = {
            {
              type = 'bashdb';
              request = 'launch';
              name = "Launch bash debugger";
              showDebugOutput = true;
              pathBashdb = install_lib .. "/bashdb";
              pathBashdbLib = install_lib;
              trace = true;
              file = "${file}";
              program = "${file}";
              cwd = "${fileDirname}",
              -- cwd = '${workspaceFolder}';
              pathCat = "cat";
              pathBash = "bash";
              pathMkfifo = "mkfifo";
              pathPkill = "pkill";
              args = {};
              env = {};
              terminalKind = "integrated";
              -- repl_lang = "bash"
            }
          }
        end,
      },
    },
  },
}
