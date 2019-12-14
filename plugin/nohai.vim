function! s:Nohai(cmdwin_char)
	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
		call s:AddMapping(a:cmdwin_char)
	endif
endfunction

function! s:AddMapping(cmdwin_char)
	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
		silent! cnoremap <expr> <CR> <SID>CR()
	endif
endfunction

function! s:RemoveMapping()
	silent! cunmap <CR>
endfunction

function! s:Deactivate()
	call s:RemoveMapping()
	call s:AutocmdOff()
endfunction

function! s:CR()
	return "\<CR>:nohlsearch\<CR>"
endfunction

function! s:AutocmdOn()
	augroup nohai
		autocmd!

		autocmd CmdlineEnter [/\?] call s:Nohai(expand('<afile>'))
		autocmd CmdlineLeave [/\?] call s:Deactivate()
	augroup END
endfunction

function! s:AutocmdOff()
	autocmd! nohai
endfunction

function! s:Search(command)
	call s:AutocmdOn()

	return a:command
endfunction

nnoremap <expr> <Plug>(nohai-search-backward) <SID>Search('?')
nnoremap <expr> <Plug>(nohai-search) <SID>Search('/')

nmap g? <Plug>(nohai-search-backward)
nmap g/ <Plug>(nohai-search)
