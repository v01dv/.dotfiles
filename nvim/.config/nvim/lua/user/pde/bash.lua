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
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      table.insert(opts.sources, nls.builtins.formatting.shfmt)
      -- table.insert(opts.sources, nls.builtins.diagnostics.shellcheck)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        bash_debug_adapter = function()
          local function get_bash_debug()
            local install_path = require("mason-registry").get_package("bash-debug-adapter"):get_install_path()
            return install_path .. "/bash-debug-adapter/extension/bashdb_dir"
          end

          local install_path = require("mason-registry").get_package("bash-debug-adapter"):get_install_path()
          local install_lib = install_path .. "/extension/bashdb_dir"

          local dap = require "dap"


          dap.adapters.bashdb = {
            type = 'executable';
            -- command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
            command = install_path;
            name = 'bashdb';
          }

          dap.configurations.sh = {
            {
              type = 'bashdb';
              request = 'launch';
              name = "Launch Bash debugger";
              showDebugOutput = true;
              -- pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
              pathBashdb = install_lib .. "/bashdb";
              -- pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
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
            }
          }
        end,
      },
    },
  },
}
