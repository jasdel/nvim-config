" Go specific key bindings
"------------------------

set autowrite

au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

"inoremap { {<CR>}<ESC>ko
"inoremap ( ()<ESC>ha

" Go related mappings
:nmap <Leader>gi :GoInfo<CR>
:nmap <Leader>gd :GoDef<CR>
:nmap <Leader>gr :GoReferrers<CR>

":nmap <Leader>gre :GoRename<CR>

:nmap <Leader>gc :GoCoverageToggle<CR>

:nmap <Leader>t :GoTest<CR>
:nmap <Leader>tf :GoTestFunc<CR>
:nmap <Leader>b :GoBuild<CR>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoDeclsDir<cr>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>


" (un)comment line(s)
:map <buffer> <Leader>// :s:^://:<CR>:noh<CR>
:map <buffer> <Leader>?? :s:^\s*//::<CR>:noh<CR>

" Template Partials
" -----------------
command! -nargs=0 JoTestErrorAs read ~/.vim/templates/go/testErrorAs.tmpl
command! -nargs=0 JoTestEqual read ~/.vim/templates/go/testEqual.tmpl
command! -nargs=0 JoTestContains read ~/.vim/templates/go/testContains.tmpl
command! -nargs=0 JoTestNoError read ~/.vim/templates/go/testNoError.tmpl
command! -nargs=0 JoTestTable read ~/.vim/templates/go/testTable.tmpl
command! -nargs=0 JoTestFuncError read ~/.vim/templates/go/testFuncError.tmpl
command! -nargs=0 JoTestExpectError read ~/.vim/templates/go/testExpectError.tmpl
command! -nargs=0 JoTestFunc read ~/.vim/templates/go/testFunc.tmpl

command! -nargs=0 JoClientWithV2SDK read ~/.vim/templates/go/clientWithV2SDK.tmpl

" Enable auto completion
"setlocal omnifunc=go#complete#Complete
