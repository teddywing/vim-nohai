if exists('g:loaded_nohai')
		\ || !exists('##CmdlineEnter')
		\ || !exists('##CmdlineLeave')
	finish
endif
let g:loaded_nohai = 1

nnoremap <expr> <Plug>(nohai-search-backward) nohai#Search('?')
nnoremap <expr> <Plug>(nohai-search) nohai#Search('/')

nmap g? <Plug>(nohai-search-backward)
nmap g/ <Plug>(nohai-search)
