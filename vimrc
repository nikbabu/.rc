"if !empty($DISPLAY)
"if !empty($WINDOWID)
  source ~babun/setup_vim.vimrc
  let mapleader="," " leader is comma 

  ""### Movements using keyboard
  ""move across visual lines
""nnoremap j gj
""nnoremap k gk
""xnoremap j gj
""xnoremap k gk
"""" move a bigger step
""nmap J 5j
""nmap K 5k
""xmap J 5j
""xmap K 5k

"Plug 'mattn/vim-lsp-settings'

"lsp-settings
" let g:lsp_async_completion = 1
" let g:lsp_semantic_enabled = 1
" let g:lsp_experimental_workspace_folders = 1
" let g:lsp_settings_root_markers =['.icmconfig','verible.filelist']
" "let g:lsp_settings = {
" "      \  'verible-verilog-ls':{server_info->['verible-verilog-ls']},
""        \ 'cmd': {server_info->['verible-verilog-ls']},
""        \ 'initialization_options':['--column_limit 130'],
" "      \}
" if executable('verible-verilog-ls')
"   au User lsp_setup call lsp#register_server({
"         \ 'cmd': {server_info->['verible-verilog-ls']},
"        \ 'name': 'verible-verilog-ls',
"        \ 'allowlist': ['verilog', 'systemverilog','verilog_systemverilog'],
"        \ })
" endif
" function! s:on_lsp_buffer_enabled() abort
"    setlocal omnifunc=lsp#complete
"    setlocal signcolumn=yes
"    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"    nmap <buffer> gd <plug>(lsp-definition)
"    nmap <buffer> gs <plug>(lsp-document-symbol-search)
"    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"    nmap <buffer> gr <plug>(lsp-references)
"    nmap <buffer> gi <plug>(lsp-implementation)
"    nmap <buffer> gt <plug>(lsp-type-definition)
"    nmap <buffer> <leader>rn <plug>(lsp-rename)
"    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"    nmap <buffer> K <plug>(lsp-hover)
"    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
"    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
"
"    let g:lsp_format_sync_timeout = 1000
"    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
"" refer to doc to add more commands
"endfunction

"augroup lsp_install
"    au!
"    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END
"
"call LspAddServer([#{
"    \   name: 'verible-verilog-ls',
"    \   filetype: ['systemverilog', 'verilog'],
"    \   path: 'verible-verilog-ls',
"    \   args: [' --rules_config_search']
"    \ }])
"let lspOpts = #{autoHighlightDiags: v:true}
"autocmd User LspSetup call LspOptionsSet(lspOpts)
"autocmd User LspSetup call LspAddServer(lspServers)


"endif 
        \ 'cmd': {[server_info->['verible-verilog-ls'],' ─rules+=line-length=length:150,-no-tabs']},
        \" 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'verible.filelist'))},
        \ 'root_uri':{server_info->lsp_settings#get('verible-verilog-ls', 'root_uri', lsp_settings#root_uri('verible-verilog-ls'))},
