augroup nohai
	autocmd!

	" autocmd CmdlineLeave * call s:Nohai(expand('<afile>'))
	autocmd CmdlineEnter [/?] call s:Nohai(expand('<afile>'))
augroup END

function! s:Nohai(cmdwin_char)
	if a:cmdwin_char == '/'
		" nohlsearch
		" ^ doesn't work because the autocommand executes before leaving the
		" command line window

		call s:AddMapping()
	else
		call s:RemoveMapping()
	endif
endfunction

function! s:AddMapping()
	silent! cnoremap <CR> <CR>:nohlsearch<CR>
endfunction

function! s:RemoveMapping()
	silent! cunmap <CR>
endfunction
