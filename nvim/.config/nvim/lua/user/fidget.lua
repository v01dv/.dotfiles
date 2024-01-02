local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  return
end

fidget.setup {
  progress = {
    display = {
      done_icon = "",
      progress_icon = { pattern = "line" },
    }
  },
  integration = {
    ["nvim-tree"] = {
      enable = true,              -- Integrate with nvim-tree/nvim-tree.lua (if installed)
    },
  },
}
