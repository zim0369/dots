lvim.autocmds = {
  -- Be in normal mode after a new line
  { "FileType",
    {
      pattern = { "text", "norg", "markdown", "conf", "vim", "fish" },
      command = "noremap <buffer> o o<Esc>",
    },
  },
  { "FileType",
    {
      pattern = { "text", "norg", "markdown", "conf", "vim", "fish" },
      command = "noremap <buffer> O O<Esc>",
    },
  },

  -- If no filetype/filename then set filetype to text(for above binding)
  { "BufEnter",
    {
      pattern = "*",
      command = "if expand('%') ==# '' | setfiletype text | endif",
    },
  },

  { "BufEnter",
    {
      pattern = "*",
      command = "if &filetype ==# '' | setlocal filetype=text | endif"
    },
  },
}
