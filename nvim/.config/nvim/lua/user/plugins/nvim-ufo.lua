-- Based on:
--    [Code Folding in Neovim - YouTube](https://www.youtube.com/watch?v=f_f08KnAJOQ&t=24s)
--    https://github.com/exosyphon/nvim/blob/main/lua/plugins/nvim-ufo.lua

return {
  "kevinhwang91/nvim-ufo",
  event = "BufRead",
  dependencies = "kevinhwang91/promise-async",
  config = function()

    -- USe "za" to toggle fold, and "zf" to fold selected text
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zK", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })

    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })
  end,
}
