if &modifiable
  finish
endif

" Push and Create merge request in Gitlab
nnoremap <buffer> gm :execute 'Git push -u origin HEAD -o merge_request.create -o merge_request.assign="" -o merge_request.title="' . FugitiveHead() . '"'<CR>
nnoremap <buffer> gh :execute 'Git push -u origin HEAD -o merge_request.create -o merge_request.target="master" -o merge_request.assign="" -o merge_request.title="' . FugitiveHead() . '"'<CR>
nnoremap <buffer> gp :Git push -u origin HEAD<CR>
nnoremap <buffer> gu :Git pull<CR>
