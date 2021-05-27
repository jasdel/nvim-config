" Python specific config

" Python settings
"------------------
setlocal tabstop=4 shiftwidth=4 smarttab expandtab
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd BufWritePre *.py normal m`:%s/\s\+$//e

