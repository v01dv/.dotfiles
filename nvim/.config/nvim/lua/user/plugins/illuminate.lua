return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure {
      delay = 200,
      -- To get the type of the current window in vim:
      -- https://stackoverflow.com/questions/36039517/how-to-get-the-type-of-the-current-window-in-vim
      -- :echo &ft
      filetypes_denylist = {
        "mason",
        "harpoon",
        "DressingInput",
        "NeogitCommitMessage",
        "qf",
        "dirvish",
        "oil",
        "minifiles",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "NeogitStatus",
        "Trouble",
        "netrw",
        "lir",
        "DiffviewFiles",
        "Outline",
        "Jaq",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
        "null-ls-info",
      },
    }
  end
}

