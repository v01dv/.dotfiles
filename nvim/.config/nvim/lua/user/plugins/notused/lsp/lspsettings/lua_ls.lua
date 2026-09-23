-- https://luals.github.io/wiki/settings/
-- Current config based on https://github.com/folke/dot/blob/master/nvim/lua/plugins/lsp.lua
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        special = {
          spec = "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      completion = {
        workspaceWord = true,
        callSnippet = "Both", -- "Replace"
      },
      misc = {
        parameters = {
          -- "--log-level=trace",
        },
      },
      hover = { expandAlias = false },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        paramName = "Disable", -- "All" | "Literal" | "Disable"
        semicolon = "Disable", -- "All" | "SameLine" | "Disable"
        await = true,
      },
      doc = {
        privateName = { "^_" },
      },
      type = {
        castNumberToInteger = true,
      },
      diagnostics = {
        -- make the language server recognize "vim" global
        globals = { "vim" },
        disable = { "incomplete-signature-doc", "trailing-space", 'missing-fields' },
        -- enable = false,
        groupSeverity = {
          strong = "Warning",
          strict = "Warning",
        },
        groupFileStatus = {
          ["ambiguity"] = "Opened",
          ["await"] = "Opened",
          ["codestyle"] = "None",
          ["duplicate"] = "Opened",
          ["global"] = "Opened",
          ["luadoc"] = "Opened",
          ["redefined"] = "Opened",
          ["strict"] = "Opened",
          ["strong"] = "Opened",
          ["type-check"] = "Opened",
          ["unbalanced"] = "Opened",
          ["unused"] = "Opened",
        },
        unusedLocalExclude = { "_*" },
      },
      format = {
        enable = false,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          continuation_indent_size = "2",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
