local M = {}

function M.dap_keymaps()

  local dap, dapui = require "dap", require "dapui"

  -- stylua: ignore start
  local function dap_start_debugging()
    require("dap").continue({})
    -- vim.cmd("tabedit %")
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", false, true, true), "n", false)
    require("dapui").toggle({})
  end


    local function dap_clear_breakpoints()
      dap.clear_breakpoints()
      -- require("notify")("Breakpoints cleared", "warn")
    end

  -- TODO: Shift + F9
  vim.keymap.set("n", "<leader>dD", dap_clear_breakpoints, { silent = true, desc = 'Debug: Clear all breakpoints' })

   local function dap_end_debug()
      dap.clear_breakpoints()
      dapui.close()
      dap.terminate({}, { terminateDebuggee = true }, function()
        -- vim.cmd.bd() -- :bd (without argument) delete(unload) current buffer
        -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- resize vertical splits
        -- require("notify")("Debugger session ended", "warn")
      end)
    end

  -- <F17> = Shift+F5 -> https://github.com/neovim/neovim/issues/7384
  vim.keymap.set("n", "<F17>", dap_end_debug, { silent = true, desc = "Debug: Terminates the debug session" }) -- <leader>dx

  -- stylua: ignore
  vim.keymap.set("n", "<F5>", function() require('dap').continue() end, { silent = true, desc = "Debug: Start/Continue the debugger" }) -- <leader>dc
  vim.keymap.set("n", "<F10>", function() require('dap').step_over() end, { silent = true, desc = 'Debug: Step Over'  }) -- <leader>do
  vim.keymap.set("n", "<F11>", function() require('dap').step_into() end, { silent = true, desc = 'Debug: Step Into' }) -- <leader>di
  vim.keymap.set("n", "<F12>", function() require('dap').step_out() end, { silent = true, desc = 'Debug: Step Out' }) -- <F23> = Shift+F11 -> https://github.com/neovim/neovim/issues/7384 or <leader>du
  vim.keymap.set("n", "<F9>", function() require('dap').toggle_breakpoint() end, { silent = true, desc = 'Debug: Toggle Breakpoint' }) -- "<leader>dt",
  vim.keymap.set("n", "<leader>db>", function() require('dap').step_back() end, { silent = true, desc = 'Debug: Step Back' })
  vim.keymap.set("n", "<laeder>dR>", function() require('dap').run_to_cursor() end, { silent = true, desc = 'Debug: Run To Cursor' }) -- Maybe Shift + F10 ???
  vim.keymap.set({ "n", "v" }, "<leader>de", function() require('dapui').eval() end, { silent = true, desc = 'Debug: Evaluate' })
  vim.keymap.set( "n", "<leader>dE", function() require('dapui').eval(vim.fn.input "[Expression] > ") end, { silent = true, desc = 'Debug: Evaluate Input' })

  -- A Logpoint is a variant of a breakpoint that does not "break" into the debugger but
  -- instead logs a message to the console. Logpoints are especially useful for injecting l
  -- ogging while debugging production servers that cannot be paused or stopped.
  --
  -- A Logpoint is represented by a "diamond" shaped icon. Log messages are plain text but
  -- can include expressions to be evaluated within curly braces ('{}').
  vim.keymap.set('n', '<Leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Logpoint message: ')) end, { silent = true, desc = 'Debug: Set logpoint' })
  -- Conditional breakpoints
  -- A powerful debugging feature is the ability to set conditions based on expressions, hit counts, or a combination of both.
  --  * Expression condition: The breakpoint will be hit whenever the expression evaluates to true.
  --  * Hit count: The 'hit count' controls how many times a breakpoint needs to be hit before it will 'break' execution.
  --    Whether a 'hit count' is respected and the exact syntax of the expression vary among debugger extensions.
  vim.keymap.set('n', '<leader>dC', function() require('dap').set_breakpoint(vim.fn.input '[Breakpoint condition] > ') end, { silent = true, desc = 'Debug: Set conditional breakpoint' })

  vim.keymap.set("n", "<leader>dr", function() require('dap').repl.toggle() end, { silent = true, desc = 'Debug: Toggle REPL' })
  vim.keymap.set("n", "<leader>dp", function() require('dap').pause.toggle() end, { silent = true, desc = 'Debug: Pause' })
  vim.keymap.set("n", "<leader>dc", function() require('dap').continue() end, { silent = true, desc = 'Debug: Continue' })

  -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  vim.keymap.set('n', '<leader>dU', function() require("dapui").toggle( {reset = true} ) end, { silent = true, desc = 'Debug: Toggle UI' })

  vim.keymap.set('n', '<leader>dh', function() require("dap.ui.widgets").hover() end, { silent = true, desc = 'Debug: Hover Variables' })
  vim.keymap.set('n', '<leader>dS', function() require("dap.ui.widgets").scopes() end, { silent = true, desc = 'Debug: Scopes' })
end

return M
