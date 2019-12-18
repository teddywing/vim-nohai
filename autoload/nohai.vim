" Copyright (c) 2019  Teddy Wing
"
" Nohai is free software: you can redistribute it and/or modify it
" under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" Nohai is distributed in the hope that it will be useful, but WITHOUT
" ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
" or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
" License for more details.
"
" You should have received a copy of the GNU General Public License
" along with Nohai. If not, see <https://www.gnu.org/licenses/>.

" Remaps <CR> in command mode to run `nohlsearch` after accepting the command.
function! s:AddMapping(mode)
	if a:mode ==# 'n'
		cnoremap <expr> <silent> <CR> <SID>CRAndNohlsearch()
	elseif a:mode ==# 'v' || a:mode ==# 'o'
		cnoremap <expr> <silent> <CR> <SID>CRAndNohlsearchV()
	endif
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

function! s:CRAndNohlsearchV()
	let expr = "\<CR>"
	let expr .= ":\<C-u>nohlsearch\<CR>"
	let expr .= 'gv'

	return expr
endfunction

" Turn on Nohai autocmds.
function! s:AutocmdOn(mode)
	augroup nohai
		autocmd!

		execute 'autocmd CmdlineEnter [/\?] call s:AddMapping("' . a:mode . '")'
		autocmd CmdlineLeave [/\?] call s:Deactivate()
	augroup END
endfunction

" Removes the Nohai augroup.
function! s:AutocmdOff()
	autocmd! nohai
endfunction

" Expr mapping function that turns on Nohai and starts the search command
" specified by `command`, either '/' or '?'.
function! nohai#Search(command, mode)
	call s:AutocmdOn(a:mode)

	return a:command
endfunction
