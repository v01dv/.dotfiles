local status_ok, fidget = pcall(require, "rainbow-delimiters")
if not status_ok then
  return
end

rainbow-delimiters.setup {
   -- strategy = {
   --      -- ...
   --  },
   --  query = {
   --      -- ...
   --  },
   --  highlight = {
   --      -- ...
   --  },
}
