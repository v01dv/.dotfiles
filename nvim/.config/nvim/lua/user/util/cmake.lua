local M = {}

M.cmake_presets = 'Debug'
function M.set_preset()
  local presets = { 'Debug', 'Release', 'RelWithDebInfo', 'MinSizeRel' }
  -- local presets = vim.fn.systemlist 'cmake --list-presets=configure'

  vim.ui.select(presets, {
    prompt = 'Select CMake preset:',
  }, function(choice)
    if not choice then
      return -- користувач скасував вибір
    end

    print('Selected: ' .. choice)
    M.cmake_presets = choice
    return choice
  end)
end

return M
