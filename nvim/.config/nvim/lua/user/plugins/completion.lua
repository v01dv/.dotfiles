return {
  {
    "hrsh7th/nvim-cmp",
    -- "InsertEnter" means when you open up a buffer and press 'i'
    -- and you're in insert mode that's when all the stuff is going to load.
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- For autocomletion

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      -- "petertriho/cmp-git",

      -- { "jcdickinson/codeium.nvim", config = true, enabled = false },
    },
    opts = function()
      local cmp = require "cmp"
      local icons = require "user.config.icons"
      local luasnip = require "luasnip"
      local neogen = require "neogen"

      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert {
          -- These mappings are useless. I already use C-n  and C-p correctly.
          -- This simple overrides them and makes them do bad things in other buffers.
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  THos will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,  -- :h cmp.confirm
          },
          { "i", "c" }
          ),
          -- Manually trigger a completion from nvim-cmp
          ["<C-space>"] = cmp.mapping {
            i = cmp.mapping.complete(),
            c = function(
              _ --[[fallback]]
              )
              if cmp.visible() then
                if not cmp.confirm { select = true } then
                  return
                end
              else
                cmp.complete()
              end
            end,
          },
          -- If you have a snippet that's like:
          -- function $name($args)
          --   $body
          -- end
          --
          -- <c-l> will move you to the right of each of the expension locations.
          -- <c-h> is similar, except movving you backwards.
          ["<c-l>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif neogen.jumpable() then
              neogen.jump_next()
            end
          end, { "i", "s" }),
          ["<c-h>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            end
          end, { "i", "s" }),
          ["<Tab>"] = cmp.config.disable,
          ["<S-Tab>"] = cmp.config.disable,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = icons.kind[vim_item.kind]
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              codeium = "[Codeium]",
              nvim_lua = "[LUA]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              emoji = "",
            })[entry.source.name]
            --if entry.source.name == "copilot" then
            --vim_item.kind = icons.git.Octoface
            --vim_item.kind_hl_group = "CmpItemKindCopilot"
            --end

            -- if entry.source.name == "cmp_tabnine" then
            --   vim_item.kind = icons.misc.Robot
            --   vim_item.kind_hl_group = "CmpItemKindTabnine"
            -- end

            -- if entry.source.name == "crates" then
            --   vim_item.kind = icons.misc.Package
            --   vim_item.kind_hl_group = "CmpItemKindCrate"
            -- end

            --if entry.source.name == "lab.quick_data" then
            --  vim_item.kind = icons.misc.CircuitBoard
            --  vim_item.kind_hl_group = "CmpItemKindConstant"
            -- end

            -- Set up our own source name called emoji
            if entry.source.name == "emoji" then
              vim_item.kind = icons.misc.Smiley
              vim_item.kind_hl_group = "CmpItemKindEmoji"
            end

            return vim_item
          end,
        },
        sources = cmp.config.sources {
          --{ name = "copilot" },
          { name = "nvim_lsp" },
          { name = "codeium" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "emoji" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
          },
        },
        -- window = {
        --   completion = {
        --     border = "rounded",
        --     --winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
        --     --col_offset = -3,
        --     --side_padding = 1,
        --     scrollbar = false,
        --     --scrolloff = 8,
        --   },
        --   documentation = {
        --     border = "rounded",
        --     --winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
        --   },
        -- },
        experimental = {
          ghost_text = false,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)
    end
  },
  -- FIXME: Not completlyy configured yet
  {
    "L3MON4D3/LuaSnip", -- Snippet engine
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      {
        -- Adds a number of user-friendly snippets
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "honza/vim-snippets",
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load()

          -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
          -- are stored in `ls.snippets._`.
          -- We need to tell luasnip that "_" contains global snippets:
          require("luasnip").filetype_extend("all", { "_" })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
    end
  },
}
