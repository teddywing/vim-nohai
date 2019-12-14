function! s:AddMapping()
	silent! cnoremap <expr> <CR> <SID>CR()
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

		autocmd CmdlineEnter [/\?] call s:AddMapping()
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
