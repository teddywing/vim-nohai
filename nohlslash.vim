let s:nohlslash = 0

function! s:setup_nohlslash()
	let s:nohlslash = !s:nohlslash
endfunction

nnoremap <silent> <leader>a :call <SID>setup_nohlslash()<cr>


augroup nohlslash
	autocmd!
	autocmd CmdwinLeave *
		\ if s:nohlslash |
		\	echom 'test'
		\	nohlsearch
		\ endif
augroup END
