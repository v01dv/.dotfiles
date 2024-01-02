return {
    -- npm install -g eslint_d
    -- Details https://github.com/mantoni/eslint_d.js/
    lintCommand = 'eslint_d --stdin --stdin-filename ${INPUT} -f unix',
    lintStdin = true,
    lintIgnoreExitCode = true
}

-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

-- local eslint = {
--     lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
--     lintIgnoreExitCode = true,
--     lintStdin = true,
--     lintFormats = {"%f:%l:%c: %m"}
--     -- formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--     -- formatStdin = true
-- }

-- return {
--     lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
--     lintIgnoreExitCode = true,
--     lintStdin = true,
--     lintFormats = {
--         "%f(%l,%c): %tarning %m",
--         "%f(%l,%c): %rror %m"
--     },
--     lintSource = "eslint"
-- }

