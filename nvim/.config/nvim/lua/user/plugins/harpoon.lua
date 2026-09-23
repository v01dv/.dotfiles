return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  branch = 'harpoon2',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    local function toggle_fzflua(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('fzf-lua').fzf_exec(file_paths, {
        prompt = 'Harpoon❯ ',
        previewer = 'builtin',
        actions = {
          ['default'] = function(selected)
            local _, idx = harpoon:list():get_by_value(selected[1])
            if idx then
              harpoon:list():select(idx)
            else
              OhVim.warn 'File not found in Harpoon list'
            end
          end,
        },
      })
    end

    -- vim.keymap.set('n', '<C-e>', function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = 'Harpoon: Open harpoon window' })

    vim.keymap.set('n', '<C-e>', function()
      toggle_fzflua(harpoon:list())
    end, { desc = 'Harpoon: Open harpoon window' })

    vim.keymap.set('n', '<leader>m', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: File menu' })

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add File' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '[m', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', ']m', function()
      harpoon:list():next()
    end)

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<space>j%d', idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
