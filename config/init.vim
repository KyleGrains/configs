" Set the leader before plugins and mappings.
let mapleader = ","

" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'tomasr/molokai'

" NERDTree
Plug 'preservim/nerdtree'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vista
Plug 'liuchengxu/vista.vim'

" Airline status bar
Plug 'vim-airline/vim-airline'

" Automatic pairs
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" CMake
Plug 'cdelledonne/vim-cmake'
Plug 'antoinemadec/FixCursorHold.nvim'

" Floating terminal
Plug 'voldikss/vim-floaterm'

" AI CLI integration (Codex, Claude Code, and others)
Plug 'folke/sidekick.nvim'

" C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Repeat
Plug 'tpope/vim-repeat'

" Indent
Plug 'yggdroot/indentline'

" Start page
Plug 'mhinz/vim-startify'

" Nerd commenter
Plug 'scrooloose/nerdcommenter'

" QuickScope
Plug 'unblevable/quick-scope'

Plug 'christoomey/vim-tmux-navigator'
call plug#end()

lua << EOF
local ok, sidekick = pcall(require, "sidekick")
if ok then
  sidekick.setup({
    nes = { enabled = false },
    copilot = { status = { enabled = false } },
    cli = {
      win = {
        layout = "float",
        keys = {
          hide_ctrl_dot = false,
          hide_ctrl_z = false,
          hide_ctrl_n = false,
          hide_ctrl_x = { "<c-x>", "hide", mode = { "n", "t" } },
        },
      },
      mux = { enabled = false },
      tools = {
        -- Do not offer already-running tmux sessions in the picker.
        codex = { is_proc = function() return false end },
        claude = { is_proc = function() return false end },
      },
    },
  })
end
EOF

let g:loaded_matchit = 1

if has('nvim')
    nmap <BS> :<C-u>TmuxNavigateLeft<CR>
else
    nmap <C-h> <C-w>h
endif

" General editor options
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

highlight CursorLine cterm=bold ctermbg=236 guibg=#333344

" Fold config
set foldmethod=syntax
set nofoldenable
set foldlevel=99

silent! colorscheme molokai
set termguicolors
let g:rehash256 = 1
hi Normal guibg=#000000 ctermbg=NONE

" NERDTree
nmap <c-t> :NERDTreeToggle<cr>

" Switch directly to tab pages with Space + 1..9
nnoremap <space>1 1gt
nnoremap <space>2 2gt
nnoremap <space>3 3gt
nnoremap <space>4 4gt
nnoremap <space>5 5gt
nnoremap <space>6 6gt
nnoremap <space>7 7gt
nnoremap <space>8 8gt
nnoremap <space>9 9gt

" Vista
let g:vista#renderer#enable_icon = 1 
let g:vista_sidebar_position = "vertical topleft"
let g:vista_default_executive = 'coc'
let g:vista_finder_alternative_executives = 'ctags'
nmap <leader>v :Vista toggle<cr>

" Save on Ctrl-S
nmap <c-s> :wa<CR>
imap <c-s> <Esc>:wa<CR>

" fzf config
nnoremap <space>f :Files <Cr>
nnoremap <space>b :Buffers <Cr>
nnoremap <space>m :Marks <Cr>
nnoremap <space>l :BLines <Cr>

nnoremap <silent><space>h :CocCommand clangd.switchSourceHeader<cr>

" Jump between Git diff hunks
nmap <silent> <space>k <Plug>(GitGutterPrevHunk)
nmap <silent> <space>j <Plug>(GitGutterNextHunk)
nmap <silent> <space>c <Plug>(GitGutterPreviewHunk)

" Terminal toggles
nnoremap <silent> <C-n> :FloatermToggle<CR>
tnoremap <silent><expr> <C-n> &filetype ==# 'floaterm' ? "\<C-\>\<C-n>:FloatermToggle\<CR>" : "\<C-n>"
nnoremap <silent> <C-x> :Sidekick cli toggle<CR>

" Toggle the active AI CLI; use Space+A to choose or start another one.
nnoremap <silent> <space>a :Sidekick cli select<CR>

" vim-cmake config
" set CMAKE_EXPORT_COMPILE_COMMANDS
let g:cmake_link_compile_commands = 1
nmap <leader>cg :CMakeGenerate<cr>
nmap <leader>cb :CMakeBuild<cr>

" CoC config
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

function! s:RefsPlusUrlDecode(str) abort
  return substitute(a:str, '%\(\x\x\)', '\=nr2char(str2nr(submatch(1), 16))', 'g')
endfunction

function! s:RefsPlusUriToPath(uri) abort
  let l:path = substitute(a:uri, '^file://', '', '')
  return fnamemodify(s:RefsPlusUrlDecode(l:path), ':p')
endfunction

function! s:RefsPlusLocInfo(loc) abort
  let l:uri = get(a:loc, 'uri', get(a:loc, 'targetUri', ''))
  let l:range = get(a:loc, 'range', get(a:loc, 'targetSelectionRange', get(a:loc, 'targetRange', {})))
  let l:start = get(l:range, 'start', {})
  if empty(l:uri) || empty(l:start)
    return {}
  endif
  return {
        \ 'path': s:RefsPlusUriToPath(l:uri),
        \ 'lnum': get(l:start, 'line', 0) + 1,
        \ 'col': get(l:start, 'character', 0) + 1
        \ }
endfunction

function! s:RefsPlusCleanSignature(text) abort
  let l:text = substitute(a:text, '\s*{\s*$', '', '')
  let l:text = substitute(l:text, '\s\+', ' ', 'g')
  return trim(l:text)
endfunction

function! s:RefsPlusLooksLikeFunction(text) abort
  let l:text = s:RefsPlusCleanSignature(a:text)
  if l:text !~# ')' || l:text =~# ';\s*$'
    return 0
  endif
  if l:text =~# '^\s*}\?\s*\(else\s\+if\|else\|if\|for\|while\|switch\|catch\|do\)\>'
    return 0
  endif
  return 1
endfunction

function! s:RefsPlusSignature(lines, lnum) abort
  let l:current = get(a:lines, a:lnum - 1, '')
  if s:RefsPlusLooksLikeFunction(l:current)
    let l:next = a:lnum + 1
    while l:next <= len(a:lines) && get(a:lines, l:next - 1, '') =~# '^\s*$'
      let l:next += 1
    endwhile
    if l:next <= len(a:lines) && get(a:lines, l:next - 1, '') =~# '^\s*{\s*$'
      return s:RefsPlusCleanSignature(l:current)
    endif
  endif

  let l:stop = max([1, a:lnum - 250])
  for l:i in range(a:lnum, l:stop, -1)
    let l:line = get(a:lines, l:i - 1, '')
    if l:line !~# '{'
      continue
    endif
    let l:head = s:RefsPlusCleanSignature(l:line)
    if l:head =~# '^}\?\s*\(else\s\+if\|else\|if\|for\|while\|switch\|catch\|do\)\>'
      continue
    endif
    let l:parts = []
    let l:j = l:i
    while l:j >= l:stop && len(l:parts) < 8
      let l:part = get(a:lines, l:j - 1, '')
      call insert(l:parts, l:part)
      if l:j < l:i && l:part =~# '^\s*$'
        break
      endif
      if l:j < l:i && l:part =~# ';\s*$'
        break
      endif
      let l:candidate = join(l:parts, ' ')
      if s:RefsPlusLooksLikeFunction(l:candidate)
        return s:RefsPlusCleanSignature(l:candidate)
      endif
      let l:j -= 1
    endwhile
  endfor
  return '(enclosing function not found)'
endfunction

function! s:RefsPlusOpenAt(mode) abort
  let l:item = get(get(b:, 'coc_refs_plus_line_items', []), line('.') - 1, {})
  if empty(l:item)
    return
  endif
  if a:mode ==# 'preview'
    execute 'pedit +' . l:item.lnum . ' ' . fnameescape(l:item.path)
    wincmd P
    call cursor(l:item.lnum, l:item.col)
    wincmd p
    return
  endif
  if a:mode ==# 'split'
    execute 'split +' . l:item.lnum . ' ' . fnameescape(l:item.path)
  elseif a:mode ==# 'vsplit'
    execute 'vsplit +' . l:item.lnum . ' ' . fnameescape(l:item.path)
  else
    execute 'edit +' . l:item.lnum . ' ' . fnameescape(l:item.path)
  endif
  call cursor(l:item.lnum, l:item.col)
  normal! zv
endfunction

function! s:CocReferencesPlus() abort
  let l:refs = CocAction('references')
  if empty(l:refs)
    echohl WarningMsg | echom 'No references found' | echohl None
    return
  endif

  let l:groups = []
  let l:group_by_key = {}
  let l:file_cache = {}
  let l:count = 0

  for l:loc in l:refs
    let l:item = s:RefsPlusLocInfo(l:loc)
    if empty(l:item) || !filereadable(l:item.path)
      continue
    endif
    if !has_key(l:file_cache, l:item.path)
      let l:file_cache[l:item.path] = readfile(l:item.path)
    endif
    let l:file_lines = l:file_cache[l:item.path]
    let l:func = s:RefsPlusSignature(l:file_lines, l:item.lnum)
    let l:key = l:item.path . "\t" . l:func
    if !has_key(l:group_by_key, l:key)
      let l:group_by_key[l:key] = len(l:groups)
      call add(l:groups, {
            \ 'path': l:item.path,
            \ 'rel': fnamemodify(l:item.path, ':~:.'),
            \ 'func': l:func,
            \ 'items': []
            \ })
    endif

    let l:first = max([1, l:item.lnum - 2])
    let l:last = min([len(l:file_lines), l:item.lnum + 2])
    let l:context = []
    for l:n in range(l:first, l:last)
      let l:mark = l:n == l:item.lnum ? '>' : ' '
      call add(l:context, printf('%s %5d  %s', l:mark, l:n, get(l:file_lines, l:n - 1, '')))
    endfor

    call add(l:groups[l:group_by_key[l:key]].items, {
          \ 'target': l:item,
          \ 'context': l:context
          \ })
    let l:count += 1
  endfor

  if l:count == 0
    echohl WarningMsg | echom 'No readable file references found' | echohl None
    return
  endif

  let l:lines = ['Coc References+ grouped by caller  <CR>:open  p:preview  s:split  v:vsplit  q:close', '']
  let l:line_items = [{}, {}]
  let l:group_no = 1

  for l:group in l:groups
    call add(l:lines, printf('%d. [%d call site%s] %s', l:group_no, len(l:group.items), len(l:group.items) > 1 ? 's' : '', l:group.func))
    call add(l:line_items, {})
    call add(l:lines, '   ' . l:group.rel)
    call add(l:line_items, {})
    let l:group_no += 1

    for l:entry in l:group.items
      let l:item = l:entry.target
      call add(l:lines, printf('   @ %s:%d:%d', fnamemodify(l:item.path, ':~:.'), l:item.lnum, l:item.col))
      call add(l:line_items, l:item)
      for l:ctx in l:entry.context
        call add(l:lines, l:ctx)
        call add(l:line_items, l:item)
      endfor
      call add(l:lines, '')
      call add(l:line_items, {})
    endfor
  endfor

  botright 18new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonumber norelativenumber
  file Coc\ References+
  call setline(1, l:lines)
  syntax match RefsPlusTitle /^Coc References+.*/
  syntax match RefsPlusGroup /^\d\+\. \[.*\].*/
  syntax match RefsPlusLocation /^   @ .*/
  syntax match RefsPlusHit /^> .*/
  highlight default link RefsPlusTitle Title
  highlight default link RefsPlusGroup Function
  highlight default link RefsPlusLocation Directory
  highlight default link RefsPlusHit Search
  let b:coc_refs_plus_line_items = l:line_items
  nnoremap <silent><buffer> <CR> :call <SID>RefsPlusOpenAt('edit')<CR>
  nnoremap <silent><buffer> p :call <SID>RefsPlusOpenAt('preview')<CR>
  nnoremap <silent><buffer> s :call <SID>RefsPlusOpenAt('split')<CR>
  nnoremap <silent><buffer> v :call <SID>RefsPlusOpenAt('vsplit')<CR>
  nnoremap <silent><buffer> q :close<CR>
  normal! gg
endfunction


" Keep function-aware statusline fresh after search jumps.
nnoremap <silent> * *:redrawstatus<CR>
nnoremap <silent> # #:redrawstatus<CR>
nnoremap <silent> n n:redrawstatus<CR>
nnoremap <silent> N N:redrawstatus<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gX :call <SID>CocReferencesPlus()<CR>
" Coc call hierarchy: shows references grouped by caller function
nmap <silent> gR :call CocAction('showIncomingCalls')<CR>

" caller
nn <silent> zc :call CocAction('showIncomingCalls')<cr>
" callee
nn <silent> zC :call CocAction('showOutgoingCalls')<cr>

nmap <silent> zt <Plug>(coc-type-definition)<cr>

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
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

function! s:RenameCallback(err, result) abort
	if empty(a:err)
		silent wa
	endif
endfunction

function! s:RenameAndWrite() abort
	call CocActionAsync('rename', function('s:RenameCallback'))
endfunction


nnoremap <silent> <leader>rn :call <SID>RenameAndWrite()<CR>


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

" Airline statusline
let g:airline_powerline_fonts = 1
let g:airline_context_mode = 'function'
let g:airline_section_warning=''
let g:airline_section_error=''
let g:airline_section_a=''
let g:airline_section_b=''
let g:airline_section_x=''
let g:airline_section_y=''
let g:airline_section_z=''
let g:airline_detect_whitespace=0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#searchcount#enabled = 0
let g:airline#extensions#default#section_truncate_width = {}

function! AirlineStatusContext(symbol, name) abort
  if g:airline_context_mode ==# 'filename' || empty(a:symbol)
    return a:name
  endif
  return a:symbol
endfunction

function! ToggleAirlineContext() abort
  let g:airline_context_mode = g:airline_context_mode ==# 'function'
        \ ? 'filename'
        \ : 'function'
  silent! call RefreshCocPreviewStatusline()
  redrawstatus!
  echo 'Statusline: ' . g:airline_context_mode
endfunction

function! AirlineNearestCppSymbol()
  if &filetype !~# 'cpp\|c'
    return ''
  endif

  let l:lnum = line('.')
  while l:lnum > 0
    let l:text = getline(l:lnum)
    let l:trimmed = substitute(l:text, '^\s*', '', '')

    if l:trimmed =~# '^\%(if\|for\|while\|switch\|catch\|else\|do\)\>'
      let l:lnum -= 1
      continue
    endif

    if l:trimmed =~# '(' && l:trimmed =~# ')\s*\%(const\s*\)\?{\s*$'
      let l:trimmed = substitute(l:trimmed, '\s*{\s*$', '', '')
      return l:trimmed
    endif

    if l:trimmed =~# '(' && l:trimmed =~# ')\s*\%(const\s*\)\?$'
      let l:next = nextnonblank(l:lnum + 1)
      if l:next > 0 && getline(l:next) =~# '^\s*{\s*$'
        return l:trimmed
      endif
    endif

    let l:lnum -= 1
  endwhile

  return ''
endfunction

function! AirlineFileAndSymbol()
  let l:symbol = get(b:, 'vista_nearest_method_or_function', '')
  if empty(l:symbol)
    let l:symbol = get(b:, 'coc_current_function', '')
  endif
  if empty(l:symbol)
    let l:symbol = AirlineNearestCppSymbol()
  endif

  let l:name = expand('%:t')
  if empty(l:name)
    let l:name = '[No Name]'
  endif

  return AirlineStatusContext(l:symbol, l:name)
endfunction

if !empty(globpath(&runtimepath, 'autoload/airline.vim'))
  call airline#parts#define_function('file_and_symbol', 'AirlineFileAndSymbol')
  let g:airline_section_c = airline#section#create(['file_and_symbol'])
endif
nnoremap <silent> <space>e :call ToggleAirlineContext()<CR>

function! AirlineNearestCppSymbolInBuffer(bufnr, lnum) abort
  let l:lnum = a:lnum
  while l:lnum > 0
    let l:text = get(getbufline(a:bufnr, l:lnum), 0, '')
    let l:trimmed = substitute(l:text, '^\s*', '', '')

    if l:trimmed =~# '^}\?\s*\(else\s\+if\|else\|if\|for\|while\|switch\|catch\|do\)\>'
      let l:lnum -= 1
      continue
    endif

    if l:trimmed =~# '(' && l:trimmed =~# ')\s*\%(const\s*\)\?{\s*$'
      return substitute(l:trimmed, '\s*{\s*$', '', '')
    endif

    if l:trimmed =~# '(' && l:trimmed =~# ')\s*\%(const\s*\)\?$'
      let l:next = l:lnum + 1
      while !empty(getbufline(a:bufnr, l:next)) && get(getbufline(a:bufnr, l:next), 0, '') =~# '^\s*$'
        let l:next += 1
      endwhile
      if get(getbufline(a:bufnr, l:next), 0, '') =~# '^\s*{\s*$'
        return l:trimmed
      endif
    endif

    let l:lnum -= 1
  endwhile
  return ''
endfunction

function! AirlineFileAndSymbolForWindow(winnr, bufnr) abort
  let l:name = fnamemodify(bufname(a:bufnr), ':t')
  if empty(l:name)
    let l:name = '[No Name]'
  endif

  let l:pos = getcurpos(a:winnr)
  let l:lnum = get(l:pos, 1, 1)
  let l:symbol = AirlineNearestCppSymbolInBuffer(a:bufnr, l:lnum)
  return AirlineStatusContext(l:symbol, l:name)
endfunction

function! SelectedCocLocationFromListLine() abort
  let l:line = getline('.')
  let l:match = matchlist(l:line, '|\%([^|]* \)\?\(\d\+\) Col \(\d\+\)|')
  if empty(l:match)
    return {}
  endif
  let l:lnum = str2nr(l:match[1])
  let l:col = str2nr(l:match[2])
  for l:loc in get(g:, 'coc_jump_locations', [])
    if get(l:loc, 'lnum', -1) == l:lnum && get(l:loc, 'col', -1) == l:col
      return l:loc
    endif
  endfor
  return {}
endfunction

function! AirlineFileAndSymbolForLocation(loc) abort
  let l:path = get(a:loc, 'filename', '')
  if empty(l:path) || !filereadable(l:path)
    return ''
  endif
  let l:lines = readfile(l:path)
  let l:lnum = get(a:loc, 'lnum', 1)
  let l:symbol = s:RefsPlusSignature(l:lines, l:lnum)
  let l:name = fnamemodify(l:path, ':t')
  if l:symbol ==# '(enclosing function not found)'
    let l:symbol = ''
  endif
  return AirlineStatusContext(l:symbol, l:name)
endfunction

function! RefreshCocPreviewStatusline() abort
  let l:preview_win = coc#list#get_preview(0)
  if l:preview_win <= 0
    return
  endif
  let l:winnr = win_id2win(l:preview_win)
  if l:winnr <= 0
    return
  endif
  let l:bufnr = winbufnr(l:winnr)
  let l:selected_loc = SelectedCocLocationFromListLine()
  let l:section_c = AirlineFileAndSymbolForLocation(l:selected_loc)
  if empty(l:section_c)
    let l:section_c = AirlineFileAndSymbolForWindow(l:winnr, l:bufnr)
  endif
  call setwinvar(l:winnr, 'airline_section_a', 'Preview')
  call setwinvar(l:winnr, 'airline_section_b', '')
  call setwinvar(l:winnr, 'airline_section_c', l:section_c)
  call setwinvar(l:winnr, 'airline_section_x', '')
  call setwinvar(l:winnr, 'airline_section_y', '')
  silent! call airline#update_statusline_inactive([l:winnr])
  redrawstatus
endfunction

function! AirlinePreviewSymbolStatusline(...) abort
  if getwinvar(a:2.winnr, '&previewwindow')
    call setwinvar(a:2.winnr, 'airline_section_a', 'Preview')
    call setwinvar(a:2.winnr, 'airline_section_b', '')
    call setwinvar(a:2.winnr, 'airline_section_c', AirlineFileAndSymbolForWindow(a:2.winnr, a:2.bufnr))
    call setwinvar(a:2.winnr, 'airline_section_x', '')
    call setwinvar(a:2.winnr, 'airline_section_y', '')
    return 1
  endif
endfunction
if !empty(globpath(&runtimepath, 'autoload/airline.vim'))
  call airline#add_inactive_statusline_func('AirlinePreviewSymbolStatusline')
endif

autocmd VimEnter * silent! call vista#RunForNearestMethodOrFunction()
autocmd CursorHold,CursorHoldI,CursorMoved,BufEnter * redrawstatus
autocmd User CocListMoved call RefreshCocPreviewStatusline()

" Mappings for CoCList
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" NERDCommenter
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

hi MatchParenCur ctermbg=red
hi MatchParen ctermbg=lightblue

set mouse=

" QuickScope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Editing shortcuts
inoremap <C-j> {}<Left>
inoremap <C-k> []<Left>
inoremap <C-l> ()<Left>
inoremap <C-e> =
inoremap <C-d> -

nnoremap <C-u> %
vnoremap <C-u> %

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>


function! ToggleWindowZoom()
    if exists('t:zoom_restore')
        execute t:zoom_restore
        unlet t:zoom_restore
    else
        let t:zoom_restore = winrestcmd()
        wincmd _
        wincmd |
    endif
endfunction

nnoremap <silent> <space>z :call ToggleWindowZoom()<CR>

" Show open buffers across the top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
set showtabline=2

" Move through displayed buffers
nnoremap <silent> <space>w :bnext<CR>
nnoremap <silent> <space>q :bprevious<CR>
