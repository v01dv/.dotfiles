local overseer = require 'overseer'

local build_dir_path = require('cmake-tools').get_build_directory() -- /home/oh/repos/stm32/test/./build/Debug
local target_name = require('cmake-tools').get_launch_target() -- test
local target_path = require('cmake-tools').get_launch_target_path() -- /home/oh/repos/stm32/test/./build/Debug/test.elf

local elf = target_path
-- local bin = elf:gsub('%.elf$', '.bin')

print(bin)

overseer.register_template {
  name = 'Build Project',
  builder = function()
    -- Full path to current file (see :help expand())
    -- local file = vim.fn.expand '%:p'

    return {
      name = 'Build Project',
      cmd = { 'cmake', '--build', '--preset', 'Debug', '-j' .. vim.uv.available_parallelism() },
      -- see :help overseer-components for a list of all components.
      components = {
        { 'on_complete_dispose', timeout = 10 }, -- This disposes all the tasks after 10 seconds.
        -- { 'open_output', on_complete = 'always', on_restart = 'always', on_start = 'always' },
        { 'on_output_parse', problem_matcher = '$gcc' },
        {
          'on_result_diagnostics_trouble',
          close = true,
        },
        'default',
      },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Build project',

  -- provide a condition so the task will only be available when you are in a c file
  -- condition = {
  --   filetype = { 'c' },
  -- },
}

overseer.register_template {
  name = 'Rebuild Project',
  builder = function()
    return {
      name = 'Rebuild Project',
      cmd = { 'cmake', '--build', '--preset', 'Debug', '--clean-first', '-v', '-j' .. vim.uv.available_parallelism() },
      components = {
        { 'on_complete_dispose', timeout = 10 },
        { 'on_output_parse', problem_matcher = '$gcc' },
        {
          'on_result_diagnostics_trouble',
          close = true,
        },
        'default',
      },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Rebuild project',
}

overseer.register_template {
  name = 'Clean Project',
  builder = function()
    return {
      name = 'Clean Project',
      cmd = { 'cmake', '--build', '--preset', 'Debug', '--target', 'clean' },
      components = {
        { 'on_complete_dispose', timeout = 10 },
        'default',
      },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Clean Project',
}

overseer.register_template {
  name = 'CubeProg: Flash project (SWD)',
  builder = function(params)
    return {
      name = 'CubeProg: Flash project (SWD)',
      cmd = {
        'STM32_Programmer_CLI',
        '-c',
        'port=SWD',
        '-w',
        'build/Debug/test.elf',
        '-v',
        '-rst',
      },
      components = {
        { 'on_complete_dispose', timeout = 10 },
        { 'open_output', on_start = 'never', on_complete = 'failure' },
        'default',
      },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Flash the project using the DEBUG preset',
  params = {
    -- my_var = {
    --   type = 'string',
    --   -- Optional fields that are available on any type
    --   name = 'More readable name',
    --   desc = 'A detailed description',
    --   order = 1, -- determines order of parameters in the UI
    --   validate = function(value)
    --     return true
    --   end,
    --   -- For component params only.
    --   -- When true, will default to the value in the task's default_component_params
    --   default_from_task = true,
    -- },
    preset = {
      type = 'enum',
      desc = 'A detailed description',
      choices = { 'Debug', 'Release' },
      delimiter = ' ',
      order = 1,
      optional = false,
      default = 'Debug',
    },
  },
}

-- arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
overseer.register_template {
  name = 'OpneOCD: Flash project (SWD)',
  builder = function(params)
    return {
      name = 'OpneOCD: Flash project (SWD)',
      cmd = {
        'openocd',
        '-f',
        'openocd.cfg',
        '-c',
        'program build/Debug/test.bin verify reset exit',
        -- 'openocd',
        -- '-f',
        -- 'interface/stlink.cfg',
        -- '-f',
        -- 'target/stm32f0x.cfg',
        -- '-c',
        -- 'program build/Debug/test.bin verify reset exit',
      },
      components = {
        { 'on_complete_dispose', timeout = 10 },
        { 'open_output', on_start = 'never', on_complete = 'failure' },
        'default',
      },
      cwd = vim.fs.root(0, {
        'CMakePresets.json',
        'CMakeLists.txt',
      }),
    }
  end,
  desc = 'Builds project, connects to the openOCD server and flashes new firmware.',
  params = {
    -- my_var = {
    --   type = 'string',
    --   -- Optional fields that are available on any type
    --   name = 'More readable name',
    --   desc = 'A detailed description',
    --   order = 1, -- determines order of parameters in the UI
    --   validate = function(value)
    --     return true
    --   end,
    --   -- For component params only.
    --   -- When true, will default to the value in the task's default_component_params
    --   default_from_task = true,
    -- },
    preset = {
      type = 'enum',
      desc = 'A detailed description',
      choices = { 'Debug', 'Release' },
      delimiter = ' ',
      order = 1,
      optional = false,
      default = 'Debug',
    },
  },
}

overseer.new_task {
  name = 'STM32 Clean Build Flash',
  strategy = {
    'orchestrator',
    tasks = {
      'Clean Project',
      'Build Project',
      'CubeProg: Flash project (SWD)',
    },
  },
}
