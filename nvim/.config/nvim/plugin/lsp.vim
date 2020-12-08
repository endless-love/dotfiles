" This disables the fairly slow loading of server installation 
" commands, which we don't really use anyway
let g:nvim_lsp = 1

packadd nvim-lspconfig
packadd completion-nvim
packadd lsp-status.nvim
packadd completion-buffers

highlight link LspReferenceText CursorColumn
highlight link LspReferenceRead CursorColumn
highlight link LspReferenceWrite CursorColumn

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" map <c-space> to manually trigger completion
inoremap <silent><expr> <c-space> completion#trigger_completion() 

imap <expr> <CR> pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

let g:completion_enable_snippet = 'snippets.nvim'

let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1

" possible value: "length", "alphabet" (default), "none"
let g:completion_sorting = "none"

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 1

" Respect language server's trigger character by default
" let g:completion_trigger_character = ['.', '::']  

let g:completion_trigger_keyword_length = 1
let g:completion_trigger_on_delete = 1

let g:completion_timer_cycle = 100 " default = 80

let g:completion_chain_complete_list = [
    \      {'complete_items': ['lsp', 'snippet']},
    \      {'complete_items': ['path'], 'triggered_only': ['/']},
    \      {'complete_items': ['buffers']},
    \      {'mode': '<c-p>'},
    \      {'mode': '<c-n>'}
    \]

let g:completion_auto_change_source = 1

imap <expr> <Tab>   pumvisible() ? "<Plug>(completion_next_source)" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "<Plug>(completion_prev_source)" : "\<S-Tab>"

autocmd BufEnter * lua require'completion'.on_attach()


let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = '■ '

call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "ﯧ", "texthl" : "LspDiagnosticsHint"})


lua require('lsp')
