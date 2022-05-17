local virtual_text = {}

virtual_text.show = true

virtual_text.toggle = function()
    virtual_text.show = not virtual_text.show
    vim.lsp.diagnostic.display(
        vim.lsp.diagnostic.get(0, 1),
        0,
        1,
        {virtual_text = virtual_text.show}
    )
end

local function get_size(tabl)
    local size = 0
    for _ in pairs(tabl) do size = size + 1 end
    return size
end

virtual_text.show = function()
    local buffer = vim.fn.bufnr()
    local clients = vim.lsp.get_active_clients()
    local size = get_size(clients)
    for i = 1, size, 1 do
        vim.lsp.diagnostic.display(vim.lsp.diagnostic.get(buffer, i), buffer, i,
                                   {virtual_text = true, underline = false})
    end
end

virtual_text.hide = function()
    local buffer = vim.fn.bufnr()
    local clients = vim.lsp.get_active_clients()
    local size = get_size(clients)
    for i = 1, size, 1 do
        vim.lsp.diagnostic.display(vim.lsp.diagnostic.get(buffer, i), buffer, i,
                                   {virtual_text = false, underline = false})
    end
end

return virtual_text
