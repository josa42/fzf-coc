function! coc#fzf#commands()
  let items = []

  for line in s:align_pairs(CocAction('commands'), 'id', 'title')
    call add(items, line)
  endfor

  call fzf#run(fzf#wrap({ 'source': items, 'sink': function('s:run_command'), 'options': [ '--ansi' ] }))
endfunction

function! coc#fzf#codeActions()
  let items = []

  for line in s:align_pairs(CocAction('codeActions'), 'clientId', 'title')
    call add(items, line)
  endfor

  call fzf#run(fzf#wrap({ 'source': items, 'options': [ '--ansi' ] }))
endfunction

function! s:run_command(cmd)
  exec 'CocCommand ' . substitute(a:cmd, ' .*$', '', '')
endfunction

function! s:align_pairs(list, idKey, valueKey)
  let maxlen = 0
  let pairs = []
  for elem in a:list

    let k = elem[a:idKey]
    let v = elem[a:valueKey]
    " let match = matchlist(elem, '^\(\S*\)\s*\(.*\)$')
    " let [_, k, v] = match[0:2]
    let maxlen = max([maxlen, len(k)])
    call add(pairs, [k, substitute(v, '^\*\?[@ ]\?', '', '')])
  endfor
  let maxlen = min([maxlen, 35])
  return map(pairs, "printf('%-'.maxlen.'s', v:val[0]).' '.v:val[1]")
endfunction


