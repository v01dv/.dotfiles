return {
  -- formatCommand = 'prettier --find-config-path --stdin-filepath ${INPUT}',
  formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

-- tsserver/web javascript react, vue, json, html, css, yaml
-- local prettier = {
--     formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
-- --    formatCommand = "prettier --stdin-filepath ${INPUT}",
--     formatStdin = true
-- }
