set scrolloff=3
set sidescrolloff=5
set lazyredraw
set ignorecase
set smartcase

set diffopt=internal,filler,closeoff,vertical,indent-heuristic,algorithm:patience

set mouse=a

set termguicolors

set number
set relativenumber
set signcolumn=yes

set splitright
set splitbelow

set hidden

set tabstop=4
set softtabstop=4
set shiftwidth=4

set colorcolumn=80

set inccommand=nosplit " live substitution

set title

set list
set listchars=tab:▸\ ,eol:¬,trail:·

set wildoptions=pum
set pumblend=20
set winblend=20
set updatetime=300

syntax enable

lua require('plugins')

packadd popup.nvim
packadd plenary.nvim
packadd telescope.nvim

nnoremap <C-p> :<C-u>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <M-g> :<C-u>lua require'telescope.builtin'.grep_string{}<CR>
nnoremap <M-G> :<C-u>lua require'telescope.builtin'.live_grep{}<CR>

packadd vim-signify

" vim: ts=2 sts=2 sw=2 et
