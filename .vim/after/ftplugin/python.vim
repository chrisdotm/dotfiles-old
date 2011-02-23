setlocal cursorcolumn
setlocal nocursorline
setlocal ts=4
setlocal expandtab
setlocal ai

"python autocomplete
let g:pydiction_location = '/home/cmccoy/.vim/ftplugin/pydiction/complete-dict'


" Delete trailing white space {
    func! DeleteTrailingWS()
      exe "normal mz"
      %s/\s\+$//e
      exe "normal `z"
    endfunc
    autocmd BufWritePre * call DeleteTrailingWS()
    " }


