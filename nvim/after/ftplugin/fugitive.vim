if &modifiable
  finish
endif

nnoremap <buffer> gp :Git push -u origin HEAD<CR>
nnoremap <buffer> gu :Git pull<CR>
