let s:unite_source = {
  \ "name":   "turnip",
  \ "hooks":  {},
  \ "syntax": "uniteSource__Turnip",
  \}

function! s:allsteps()
  let steps = []
  for file in split(glob('./**/steps/**/*.rb'),"\n")
    let lines = readfile(file)
    let line_num = 0
    for line in lines
      let line_num += 1
      if line =~ '^ *step [''"].*[''"] do'
        let step_name = matchstr(line,'\vstep [''"]\zs(.*)\ze[''"]')
        let steps += [{
              \ "word": printf("%-50s -- (%s:%d)", step_name, file, line_num),
              \ "source": "lines",
              \ "kind": "jump_list",
              \ "action__path": file,
              \ "action__line": line_num
              \ }]
      endif
    endfor
  endfor
  return steps
endfunction

function! s:unite_source.gather_candidates(args, context)
  return s:allsteps()
endfunction

function! s:unite_source.hooks.on_syntax(args, context)
  syntax match uniteSource__TurnipDescriptionLine / -- .*$/
        \ contained containedin=uniteSource__Turnip
  syntax match uniteSource__TurnipDescription /.*$/
        \ contained containedin=uniteSource__TurnipDescriptionLine
  syntax match uniteSource__TurnipMarker / -- /
        \ contained containedin=uniteSource__TurnipDescriptionLine
  highlight default link uniteSource__TurnipMarker Special
endfunction

function! unite#sources#turnip#define()
  return [s:unite_source]
endfunction
