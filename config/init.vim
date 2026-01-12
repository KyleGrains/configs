" LanguageClient-neovim
" source % after change
call plug#begin('~/.local/share/nvim/plugged')

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Vim themes
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'rebelot/kanagawa.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'

" NERDTree ctrl-t
Plug 'preservim/nerdtree'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vista
Plug 'liuchengxu/vista.vim'

" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Snippets, using 'main' only now basically
" Plug 'SirVer/ultisnips'
" Plug 'KyleGrains/vim-snippets'

" auto pair
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround'

" Git
" Plug 'tpope/vim-fugitive'
" Plug 'lewis6991/gitsigns.nvim'
" Plug 'jesseduffield/lazygit'
Plug 'airblade/vim-gitgutter'

" fuzzy finder ctrl-p
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" NeoFormat
Plug 'sbdchd/neoformat'

" CMake
Plug 'cdelledonne/vim-cmake'
Plug 'antoinemadec/FixCursorHold.nvim'

" floaterm ctrl-n
Plug 'voldikss/vim-floaterm'

" Syntastic
"Plug 'vim-syntastic/syntastic'

" cpp syntax highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" Markdown
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown' 

" Repeat
Plug 'tpope/vim-repeat'

" Indent
Plug 'yggdroot/indentline'
" Plug 'nathanaelkane/vim-indent-guides'

" Multi-cursor
"Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" EasyMotion
"Plug 'easymotion/vim-easymotion'

" vim-dispatch
"Plug 'tpope/vim-dispatch'

" Start page
Plug 'mhinz/vim-startify'
Plug 'folke/which-key.nvim'

" Nerd commenter
Plug 'scrooloose/nerdcommenter'

" Matchup
" Plug 'andymass/vim-matchup' 

" CtrlP buffers
Plug 'ctrlpvim/ctrlp.vim'

" QuickScope
Plug 'unblevable/quick-scope'

Plug 'matze/vim-move'

Plug 'skamsie/vim-lineletters'

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
"Plug 'iamcco/markdown-preview.nvim'

Plug 'christoomey/vim-tmux-navigator'
"
"Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'ryanoasis/vim-devicons' "Icons without colours
"Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

"Plug 'neovim/nvim-lspconfig'
"Plug 'williamboman/mason.nvim'
"Plug 'williamboman/mason-lspconfig.nvim'
"Plug 'danymat/neogen'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'mcchrish/nnn.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'stevearc/aerial.nvim'

Plug 'folke/zen-mode.nvim'

Plug 'David-Kunz/gen.nvim'
call plug#end()

let g:loaded_matchit = 1

if has('nvim')
    nmap <BS> :<C-u>TmuxNavigateLeft<CR>
else
    nmap <C-h> <C-w>h
endif

" Syntax config
set number
filetype on
syntax on
set expandtab
set autoindent
set cindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set cursorline
set hlsearch
set completeopt=preview,menu
set tags=./tags,tags;$HOME
" set autochdir
" 

highlight CursorLine cterm=bold ctermbg=236 guibg=#333344

" set iskeyword-=_

" Fold config
set foldmethod=syntax
set nofoldenable
set foldlevel=99

colorscheme molokai
set termguicolors
"let ayucolor="dark"
let g:rehash256 = 1
hi Normal guibg=#000000 ctermbg=NONE

" Move between windows bindings
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/home/YOUR_USERNAME/.config/nvim/settings.json'
" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
"let g:LanguageClient_hasSnippetSupport = 0

" NERDTree
nmap <c-t> :NERDTreeToggle<cr>

let mapleader = ","

" Vista
let g:vista#renderer#enable_icon = 1 
let g:vista_sidebar_position = "vertical topleft"
let g:vista_default_executive = 'coc'
let g:vista_finder_alternative_executives = 'ctags'
nmap <leader>v :Vista toggle<cr>

" Save on Ctrl-S
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

"Ctrl P
"nnoremap <space>b :CtrlPBuffer<cr>
"let g:ctrlp_cmd = 'CtrlPBuffer'

" fzf config
nnoremap <space>f :Files <Cr>
nnoremap <space>b :Buffers <Cr>
nnoremap <space>m :Marks <Cr>
nnoremap <space>l :Lines <Cr>

nnoremap <space>h :ClangdSwitchSourceHeader<cr>

" Floaterm config
nnoremap   <C-n> :FloatermNew<CR>

" vim-cmake config
" set CMAKE_EXPORT_COMPILE_COMMANDS
let g:cmake_link_compile_commands = 1
nmap <leader>cg :CMakeGenerate<cr>
nmap <leader>cb :CMakeBuild<cr>

"Coc config
"hi CocFloating ctermbg=White


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
"set encoding=utf8
"set guifont=DroidSansM\ Nerd\ Font\ Mono\ Regular\ 14

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" bases
nn <silent> zb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> zB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> zd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> zD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> zc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> zC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" $ccls/member
" member variables / variables in a namespace
nn <silent> zm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> zf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> zs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nmap <silent> zt <Plug>(coc-type-definition)<cr>
nn <silent> zv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> zV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

nn <silent> zj :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
nn <silent> zh :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
nn <silent> zl :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
nn <silent> zk :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>

" Use D to show documentation in preview window.
nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

autocmd User CocStatusChange redrawstatus

let g:airline_powerline_fonts = 1

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_cpp_checkers = ['gcc']
" let g:syntastic_cpp_checkers = ['gcc', 'cppcheck', 'clang_tidy']

" BufferLine
" In your init.lua or init.vim
set termguicolors

let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

hi MatchParenCur ctermbg=red
hi MatchParen ctermbg=lightblue
"hi MatchWordCur cterm=underline
"

se mouse=

" QuickScope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"nmap <S-j> <Plug>MoveLineDown
"nmap <S-k> <Plug>MoveLineUp
"vmap <S-j> <Plug>MoveBlockDown
"vmap <S-k> <Plug>MoveBlockUp

"map <silent>L <Plug>LineLetters

"map <C-a> <ESC>^
"imap <C-a> <ESC>I
"map <C-e> <ESC>$
"imap <C-e> <ESC>A

nnoremap <space>q :q<cr>
nnoremap <space>e :e<cr>

nnoremap <space>p :sp<cr>
nnoremap <space>v :vs<cr>

nnoremap <c-h> :BufferLineCycleNext<CR>
nnoremap <c-l> :BufferLineCyclePrev<CR>

let g:airline_section_warning=''
let g:airline_section_a=''
let g:airline_section_b=''
let g:airline_section_y=''
let g:airline_section_z=''
let g:airline_detect_whitespace=0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#default#section_truncate_width = {}
