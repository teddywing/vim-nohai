augroup nohai
	autocmd!

	" autocmd CmdlineLeave * call s:Nohai(expand('<afile>'))
	autocmd CmdlineEnter [/?] call s:Nohai(expand('<afile>'))
augroup END

function! s:Nohai(cmdwin_char)
	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
		" nohlsearch
		" ^ doesn't work because the autocommand executes before leaving the
		" command line window

		call s:AddMapping(a:cmdwin_char)
	else
		call s:RemoveMapping()
	endif
endfunction

function! s:AddMapping(cmdwin_char)
	" silent! cnoremap <CR> <CR>:nohlsearch<CR>
	silent! cnoremap <expr> <CR> s:CR(a:cmdwin_char)
endfunction

function! s:RemoveMapping()
	silent! cunmap <CR>
endfunction

function! s:CR(cmdwin_char)
	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
		return '<CR>:nohlsearch<CR>'
		" ... and unmap
	else
		return '<CR>'
	endif
endfunction

function! s:Search()
	" let s:on = 1

	" 1. Turn on autocmd
	" 2. Search (find out if this is blocked by function-search-undo)
	" 2.a. Search automatically disables autocmd
endfunction


nnoremap <Plug>(nohai-search-backward) :call s:Search()<CR>
nnoremap <Plug>(nohai-search) :call s:Search()<CR>

nmap g? <Plug>(nohai-search-backward)
nmap g/ <Plug>(nohai-search)
