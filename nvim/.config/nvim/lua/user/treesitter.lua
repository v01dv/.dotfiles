local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help' },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable_virtual_text = true,
    disable = { "html" }, -- optional, list of language that will be disabled
    -- include_match_words = false
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "css", "markdown" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  autopairs = {
		enable = true,
	},
  indent = { enable = true, disable = { "yaml", "python", "css", "rust"} },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
     config = {
      -- Languages that have a single comment style
      typescript = "// %s",
      css = "/* %s */",
      scss = "/* %s */",
      html = "<!-- %s -->",
      svelte = "<!-- %s -->",
      vue = "<!-- %s -->",
      json = "",
    },
  },
  autotag = {
    enable = true,
    disable = { "xml", "markdown" },
  },
}
