lvim.autocommands.custom_groups = {
  -- Be in normal mode after a new line
  { "FileType", "text,norg,markdown,conf,vim", "noremap <buffer> o o<Esc>" },
  { "FileType", "text,norg,markdown,conf,vim", "noremap <buffer> O O<Esc>" },

  -- If no filetype/filename then set filetype to text(for above binding)
  { "BufEnter", "*", "if expand('%') ==# '' | setfiletype text | endif" },
  { "BufEnter", "*", "if &filetype ==# '' | setlocal filetype=text | endif" },
}
