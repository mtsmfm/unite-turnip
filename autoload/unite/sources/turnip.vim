let s:unite_source = {'name': 'turnip'}

function! s:allsteps()
  let steps = []
  for file in split(glob('./**/steps/**/*.rb'),"\n")
    let lines = readfile(file)
    let line_num = 0
    for line in lines
      let line_num += 1
      if line =~ '^ *step [''"].*[''"] do'
        let steps += [{
              \ "word": matchstr(line,'\vstep [''"]\zs(.*)\ze[''"]'),
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

function! unite#sources#turnip#define()
  return [s:unite_source]
endfunction
