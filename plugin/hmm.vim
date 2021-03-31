if exists('g:loaded_hmm')
  finish
endif
let g:loaded_hmm = 1

function! s:format(type) abort
  if a:type == ','
    silent :%s/\v\n/, /
    silent :%s/\v, $//
  elseif a:type == ';'
    silent :%s/\v\n/; /
    silent :%s/\v; $//
  elseif a:type == '-'
    silent :%s/\v^/- /
  endif

  silent :nohlsearch
endfunction

function! s:new(bang, args) abort
  let cmd = 'hmm'

  if !empty(a:args)
    let cmd .= ' ' . a:args
  endif

  let output = systemlist(cmd)

  if a:bang == '!'
    %delete
  elseif !(empty(bufname('%')) && line('$') == 1 && getline(1) == '')
    new
  endif

  let bname = bufname('%')

  setlocal filetype=markdown
  setlocal spell

  nnoremap <silent><buffer> <localleader>, :call <SID>format(',')<CR>
  nnoremap <silent><buffer> <localleader>; :call <SID>format(';')<CR>
  nnoremap <silent><buffer> <localleader>- :call <SID>format('-')<CR>
  nnoremap <buffer> <localleader><localleader> :%yank +<CR>

  call appendbufline(bname, 0, output)
  call deletebufline(bname, line('$'))

  setlocal nomodified

  call cursor(1, 1)
endfunction

let s:flags = ['--max-depth', '--since']

function! s:complete(lead, ...) abort
  let flags = filter(copy(s:flags), 'strpart(v:val, 0, strlen(a:lead)) ==# a:lead')
  let paths = a:lead =~# '-' ? [] : glob(a:lead . '*/', 0, 1)
  return extend(flags, extend(paths, ['../']))
endfunction

command! -bang -nargs=* -complete=customlist,s:complete Hmm call s:new(<q-bang>, <q-args>)
