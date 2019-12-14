" Remaps <CR> in command mode to run `nohlsearch` after accepting the command.
function! s:AddMapping()
	cnoremap <expr> <silent> <CR> <SID>CRAndNohlsearch()
endfunction

" Removes the Nohai <CR> cmap.
function! s:RemoveMapping()
	silent! cunmap <CR>
endfunction

" Deactivates the Nohai <CR> cmap and turns off the augroup.
function! s:Deactivate()
	call s:RemoveMapping()
	call s:AutocmdOff()
endfunction

" Expr mapping function that runs the `nohlsearch` command after pressing <CR>.
function! s:CRAndNohlsearch()
	return "\<CR>:nohlsearch\<CR>"
endfunction

" Turn on Nohai autocmds.
function! s:AutocmdOn()
	augroup nohai
		autocmd!

		autocmd CmdlineEnter [/\?] call s:AddMapping()
		autocmd CmdlineLeave [/\?] call s:Deactivate()
	augroup END
endfunction

" Removes the Nohai augroup.
function! s:AutocmdOff()
	autocmd! nohai
endfunction

" Expr mapping function that turns on Nohai and starts the search command
" specified by `command`, either '/' or '?'.
function! nohai#Search(command)
	call s:AutocmdOn()

	return a:command
endfunction
