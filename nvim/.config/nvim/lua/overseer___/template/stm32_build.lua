local overseer = require 'overseer'

overseer.register_template {
  name = 'Build Project',
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand '%:p'
    local out = vim.fn.system 'cmake --list-presets'
    print(out)

    return {
      -- name = 'Greet',
      cmd = { 'cmake', '--build', '--preset', 'Debug', '-j' .. vim.uv.available_parallelism() },
      -- attach a component to the task that will pipe the output to the quickfix.
      -- components customize the behavior of a task.
      -- see :help overseer-components for a list of all components.
      components = { { 'open_output', on_start = 'always' }, 'default' },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Optional description of task',

  -- provide a condition so the task will only be available when you are in a c++ file
  condition = {
    filetype = { 'c' },
  },
}

overseer.register_template {
  name = 'Build Project 2',
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand '%:p'
    local out = vim.fn.system 'cmake --list-presets'
    print(out)

    return {
      -- name = 'Greet',
      cmd = { 'cmake', '--build', '--preset', 'Debug', '-j' .. vim.uv.available_parallelism() },
      -- attach a component to the task that will pipe the output to the quickfix.
      -- components customize the behavior of a task.
      -- see :help overseer-components for a list of all components.
      components = { { 'open_output', on_start = 'always' }, 'default' },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Optional description of task',

  -- provide a condition so the task will only be available when you are in a c++ file
  condition = {
    filetype = { 'c' },
  },
}
