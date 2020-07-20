call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'exitface/synthwave.vim'
Plug 'artanikin/vim-synthwave84'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'roxma/nvim-completion-manager'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'Sirver/ultisnips'
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wakatime/vim-wakatime'
"Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'slashmili/alchemist.vim'
Plug 'preservim/nerdcommenter'

call plug#end()

colorscheme gruvbox
set background=dark
"set background=dark
"color synthwave84

"if has('termguicolors')
"  set termguicolors " 24-bit terminal
"else
"  let g:synthwave_termcolors=256 " 256 color mode
"endif

set hidden
set number
set relativenumber
"set mouse=a
set inccommand=split

let mapleader="\<space>"
nnoremap <leader>; A;<esc>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" PLUGIN: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <c-f> :Files<cr>
nnoremap <silent> <Leader>f :Ag<cr>
"map <C-n> :NERDTreeToggle<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" ALE config
nmap <silent> <s-l> :ALEToggle<cr>
let g:ale_linters = { 'elixir': ['elixir-ls'] }
let g:ale_fixers = { 'elixir': ['mix_format'] }

" multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


" NERD_tree config
"let NERDTreeShowHidden=1 
"let g:NERDTreeMapActivateNode="<F3>"
"let g:NERDTreeMapPreview="<F4>"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" alchemist.vim config
let g:alchemist_iex_term_size = 15
let g:alchemist_iex_term_split = 'split'
let g:alchemist_tag_disable = 1
let g:alchemist_tag_map = '<C-]>'
let g:alchemist_tag_stack_map = '<C-T>'
let g:python3_host_prog='/usr/bin/python3'
autocmd BufWritePost *.exs,*.ex silent :!mix format %
