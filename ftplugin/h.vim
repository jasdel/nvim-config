" C Header specific config
"
" C Header settings
"------------------
setlocal tabstop=2 shiftwidth=2 smarttab expandtab
"setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd BufWritePre *.h normal m`:%s/\s\+$//e

" (un)comment line(s)
:map <buffer> <Leader>// :s:^://:<CR>:noh<CR>
:map <buffer> <Leader>?? :s:^\s*//::<CR>:noh<CR>
