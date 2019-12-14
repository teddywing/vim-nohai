" augroup nohai
" 	autocmd!
"
" 	" autocmd CmdlineLeave * call s:Nohai(expand('<afile>'))
" 	autocmd CmdlineEnter [/?] call s:Nohai(expand('<afile>'))
" augroup END

function! s:Nohai(cmdwin_char)
	echom 'called ' . a:cmdwin_char
	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
		" nohlsearch
		" ^ doesn't work because the autocommand executes before leaving the
		" command line window

		call s:AddMapping(a:cmdwin_char)
	" else
	" 	call s:RemoveMapping()
	endif

	call s:AutocmdOff()
endfunction

function! s:AddMapping(cmdwin_char)
	" silent! cnoremap <CR> <CR>:nohlsearch<CR>
	" silent! cnoremap <expr> <CR> s:CR(a:cmdwin_char)
	" silent! cnoremap <expr> <CR> <SID>CR(a:cmdwin_char)
	" silent! cnoremap <expr> <CR> <SID>CR('/')

	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
		silent! cnoremap <expr> <CR> <SID>CR()
	endif
endfunction

function! s:RemoveMapping()
	silent! cunmap <CR>
endfunction

" function! s:CR(cmdwin_char)
" 	if a:cmdwin_char == '/' || a:cmdwin_char == '?'
" 		return "\<CR>:nohlsearch\<CR>"
" 		" ... and unmap
" 	else
" 		return "\<CR>"
" 	endif
" endfunction

function! s:CR()
	" return "\<CR>:nohlsearch\<CR>"

	" let expr = ''
	" let expr .= "\<CR>:nohlsearch\<CR>"
	" let expr .= ":call s:RemoveMapping()\<CR>"
    "
	" return expr

	" TODO: Use CmdlineLeave instead for e.g. <C-c>
	call s:RemoveMapping()

	return "\<CR>:nohlsearch\<CR>"
endfunction

function! s:AutocmdOn()
	echom 'Turning on autocmd'
	augroup nohai
		autocmd!

		autocmd CmdlineEnter [/\?] call s:Nohai(expand('<afile>'))
	augroup END
endfunction

function! s:AutocmdOff()
	autocmd! nohai
endfunction

function! s:Search(command)
	echom 'Searching with ' . a:command
	" let s:on = 1

	" 1. Turn on autocmd
	" 2. Search (find out if this is blocked by function-search-undo)
	" 2.a. Search automatically disables autocmd

	call s:AutocmdOn()

	return a:command

	" let expr = ''
    "
	" let expr .= ":call s:AutocmdOn()\<CR>"
	" let expr .= a:command
    "
	" return expr
endfunction

" Impl idea 2
" autocmd is activated on init
" Search() from g/? mapping sets a script-local flag and exprs to /?
" s:Nohai() 

nnoremap <expr> <Plug>(nohai-search-backward) <SID>Search('?')
nnoremap <expr> <Plug>(nohai-search) <SID>Search('/')

nmap g? <Plug>(nohai-search-backward)
nmap g/ <Plug>(nohai-search)

" Using SID outside of script context?
" nnoremap <expr> g? <SID>Search('?')
" nnoremap <expr> g/ <SID>Search('/')
