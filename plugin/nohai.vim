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

if exists('g:loaded_nohai')
		\ || !exists('##CmdlineEnter')
		\ || !exists('##CmdlineLeave')
	finish
endif
let g:loaded_nohai = 1

nnoremap <expr> <Plug>(nohai-search-backward) nohai#Search('?', 'n')
nnoremap <expr> <Plug>(nohai-search) nohai#Search('/', 'n')

xnoremap <expr> <Plug>(nohai-search-backward) nohai#Search('?', 'v')
xnoremap <expr> <Plug>(nohai-search) nohai#Search('/', 'v')

onoremap <expr> <Plug>(nohai-search-backward) nohai#Search('?', 'o')
onoremap <expr> <Plug>(nohai-search) nohai#Search('/', 'o')

if exists('g:nohai_no_maps') && g:nohai_no_maps
	finish
endif

if !hasmapto('<Plug>(nohai-search-backward)', 'nov') && !maparg('g?', 'nox')
	nmap g? <Plug>(nohai-search-backward)
	xmap g? <Plug>(nohai-search-backward)
	omap g? <Plug>(nohai-search-backward)
endif

if !hasmapto('<Plug>(nohai-search)', 'nov') && !maparg('g/', 'nox')
	nmap g/ <Plug>(nohai-search)
	xmap g/ <Plug>(nohai-search)
	omap g/ <Plug>(nohai-search)
endif
