These diagnostic keymaps are created unconditionally when Nvim starts:
]d jumps to the next diagnostic in the buffer. ]d-default
[d jumps to the previous diagnostic in the buffer. [d-default
]D jumps to the last diagnostic in the buffer. ]D-default
[D jumps to the first diagnostic in the buffer. [D-default
<C-w>d shows diagnostic at cursor in a floating window. CTRL-W_d-default

gra gri grn grr grt i_CTRL-S v_an v_in These GLOBAL keymaps are created unconditionally when Nvim starts:
"gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
"gri" is mapped in Normal mode to vim.lsp.buf.implementation()
"grn" is mapped in Normal mode to vim.lsp.buf.rename()
"grr" is mapped in Normal mode to vim.lsp.buf.references()
"grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
"gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
"an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()

K is mapped to vim.lsp.buf.hover() unless 'keywordprg' is customized or a custom keymap for K exists.
