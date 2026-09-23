local M = {}

-- function M.on_attach(on_attach)
--   vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--       local bufnr = args.buf ---@type number
--       local client = vim.lsp.get_client_by_id(args.data.client_id)
--       on_attach(client, bufnr)
--     end,
--   })
-- end

-- local callbacks = {}
--
-- function M.on_attach(fn, name)
--   table.insert(callbacks, { fn = fn, name = name })
-- end
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('MyLspOnAttach', { clear = true }),
--   callback = function(args)
--     local buffer = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then
--       return
--     end
--     for _, cb in ipairs(callbacks) do
--       if not cb.name or cb.name == client.name then
--         cb.fn(client, buffer)
--       end
--     end
--   end,
-- })

---@param on_attach fun(client:vim.lsp.Client, buffer)
---@param name? string
function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

---@param opts LspCommand
function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  if opts.open then
    require('trouble').open {
      mode = 'lsp_command',
      params = params,
    }
  else
    return vim.lsp.buf_request(0, 'workspace/executeCommand', params, opts.handler)
  end
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      }
    end
  end,
})

return M
