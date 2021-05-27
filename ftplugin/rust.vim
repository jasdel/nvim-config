" Rust specific config
"---------------------

" Auto format on save
let g:rustfmt_autosave = 1

" Rust style formating
"let g:rust_recommended_style = 1

" (un)comment line(s)
:map <buffer> <Leader>// :s:^://:<CR>:noh<CR>
:map <buffer> <Leader>?? :s:^\s*//::<CR>:noh<CR>

:nmap <Leader>rt :RustTest<CR>
:nmap <Leader>t :RustTest<CR>
:nmap <Leader>b :Cbuild<CR>
:nmap <Leader>c :Cclean<CR>
:nmap <Leader>ta :Ctest<CR>
