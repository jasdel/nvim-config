" Vim-Go config
"------------------
let g:go_doc_popup_window = 0
let g:go_doc_keywordprg_enabled = 0

let g:go_fmt_command = "goimports"
"let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
"let g:go_disable_autoinstall = 0

" Highlight
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_structs = 0
"let g:go_highlight_interfaces = 0
"let g:go_highlight_operators = 0
"let g:go_highlight_build_constraints = 0
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Code Folding
"let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"set omnifunc=go#complete#Complete
