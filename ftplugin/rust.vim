" Rust specific config
"---------------------

" Auto format on save
"let g:rustfmt_autosave = 1

" Rust style formatting
"let g:rust_recommended_style = 1

" (un)comment line(s)
:map <buffer> <Leader>// :s:^://:<CR>:noh<CR>
:map <buffer> <Leader>?? :s:^\s*//::<CR>:noh<CR>

"command! -nargs=* Cbuild call cargo#build(<q-args>)
"command! -nargs=* Ctest call cargo#test(<q-args>)
"command! -nargs=* Crun call cargo#run(<q-args>)
"command! -nargs=* Cclean call cargo#clean(<q-args>)

:nmap <Leader>b :!cargo build<CR>
:nmap <Leader>t :!cargo test<CR>
:nmap <Leader>r :!cargo run<CR>
:nmap <Leader>cc :!cargo clean<CR>
":nmap <Leader>t :RustTest<CR>
":nmap <Leader>rt :RustTest<CR>
":nmap <Leader>ta :Ctest<CR>
