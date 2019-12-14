if exists('g:loaded_nohai')
		\ || !exists('##CmdlineEnter')
		\ || !exists('##CmdlineLeave')
	finish
endif
let g:loaded_nohai = 1

nnoremap <expr> <Plug>(nohai-search-backward) nohai#Search('?')
nnoremap <expr> <Plug>(nohai-search) nohai#Search('/')

if exists('g:nohai_no_maps') && g:nohai_no_maps
	finish
endif

if !hasmapto('<Plug>(nohai-search-backward)') && !maparg('g?', 'n')
	nmap g? <Plug>(nohai-search-backward)
endif

if !hasmapto('<Plug>(nohai-search)') && !maparg('g/', 'n')
	nmap g/ <Plug>(nohai-search)
endif
