get_env_switch = (name) ->
  val = tostring os.getenv name
  switch val\lower!
    when '1', 'true', 't', 'yes', 'y'
      return true
    when '0', 'false', 'f', 'no', 'nil', 'n'
      return false
    else
      error "Unknown value for environment variable #{name}: #{val}"

DEBUG = get_env_switch 'PRA_PDC_CLASS_DEBUG'
DO_MD = get_env_switch 'PRA_PDC_CLASS_DO_MD'

if FORMAT\match'markdown' or
    FORMAT\match'gfm' and
      not DO_MD
  -- a minimal no-op filter
  return {
    { Pandoc: -> nil }
  }

_assert = (msg, val, lvl=0) ->
  if DEBUG
    assert val, msg
  elseif val
    return val
  else
    error msg, lvl+2

pdc = _assert "Couldn't find pandoc library.
  Are you running this as a Pandoc Lua filter?", pandoc
ptext = _assert "Couldn't find the pandoc.text library", pdc.text

stringy = => tostring @ or ""

reverse_array = =>
  n = tonumber(@n) or #@
  [@[i] for i=n,1,-1]

-- Syntactic sugar for HTML opening/closing tags
hopen = (tag) -> pdc.RawInline 'html', "<#{tag}>"
hclose = (tag) -> pdc.RawInline 'html', "</#{tag}>"

-- "Wrap" an inline element in a LaTeX command.
-- Arguments:
-- 1.  The element
-- 2.  The command 'begin', optionally just a string
--     of letters for the command name
-- 3.  The 'close' of the command, by default '}'
-- Returns: a Span element containing the wrapped element
latex_command (elem, cmd, post='}') ->
  cmd = stringy cmd
  post = stringy post
  if cmd\match '^%a+$'
    cmd = "\\#{cmd}{"
  pdc.Span {
    pdc.RawInline('latex',cmd),
    elem,
    pdc.RawInline('latex', post),
  }

inline2span = =>
  switch @tag
    when 'Span', nil
      return @
    else
      switch type @content
        when 'table'
          return pdc.Span @content
        else
          return pdc.Span {@}

-- Create a closure which "wraps" its argument
-- (an inline element) in a "canned" LaTeX command:
-- ltc(command, close='}')
ltc = (cmd, post) ->
  => latex_command inline2span(@), cmd, post

ncc = (pre,post=pre) ->
  pre = "\\NoCaseChange{" .. stringy(pre)
  post = stringy(post) .. '}'
  return ltc pre, post

-- "Wrap" an inline element in one or two strings,
-- "removing" any "style" on the element
-- Arguments:
-- 1.  The element
-- 2.  The string before the element
-- 3.  The string after the element, by default same as #2
string_wrap = (elem, pre, post=pre) ->
  return pdc.Span {
    pdc.Str(stringy pre),
    inline2span(elem),
    pdc.Str(stringy post),
  }

-- Returns a closure with a canned string_wrap
strw = (pre, post) ->
  => string_wrap inline2span(@), pre, post

-- Filter to turn all Str elements uppercase
uc_str = Str: =>
  pdc.Str ptext.upper @text

-- Usage:
-- html_inline(elem, 'u')
-- > `<u>...</u>`
-- DWIM:
-- html_inline(elem, 'u class="double"')
-- Explicit closing tag:
-- html_inline(elem, 'u class="double"', 'u')
html_inline (elem, open, close) ->
  if nil == close
    close = open\match '^%a+'
  return pdc.Span {
    hopen(open),
    elem,
    hclose(close),
  }

-- Filter to turn (sequences of) uppercase letters in Str elements into SmallCaps.
-- Limitation: only works on ASCII letters (use `.sc` otherwise).
-- For (Xe)LaTeX we use a command `textusc` which should be defined like this:
--
-- \newcommand{\textusc}[1]{%
--   {\addfontfeature{Letters=UppercaseSmallCaps}{#1}}
-- }

pdc_usc = {
  Str: =>
    rv = {}
    for lc, uc in @text\gmatch '(%U*)(%u*)'
      if #lc > 0
        rv[#rv+1] = pdc.Str lc
      if #uc > 0
        uc = ptext.lower uc
        rv[#rv+1] = pdc.SmallCaps pdc.Str uc
    return rv
}

inline_class = {
  sc: {
      latex: ),
      plain: (=> pdc.walk_inline inline2span(@), uc_str),
    },
  usc: {
      latex: ltc'textusc',
      plain: false,
      other: (=> pdc.walk_inline @, pdc_usc),
    },
  pra: {
      any: strw('⟪', '⟫'),
      latex: ncc('⟪', '⟫'),
      plain: strw('«', '»'),
    },
  gr: {
      other: strw('⟨', '⟩'),
      latex: ncc('⟨', '⟩'),
      plain: strw(,'‹', '›')
    },
  ipt: {
      any: strw('[', ']'),
      latex: ncc('[', ']'),
    },
  ipm: {
      any: strw'/'
      latex: ncc'/'
    }
}

inline_tag = {
  Emph: {
      latex: ltc'uline'
      plain: strw'_'
    },
  Strong: {
      latex: ltc'uuline'
      plain: strw'__'
    }
  Strikeout: {
      latex: ltc'textsc'
      plain: => inline_class.sc.plain
    },
}

for disps in *{inline_class, inline_tag}
  for name, disp in pairs disps
    if nil == disp.markdown
      disp.markdown = disp.plain



inline_style = =>
  rv = @
  if @classes
    classes = reverse_array @classes
    for cls in *classes
      if ic = inline_class[cls][FORMAT] or
          inline_class[cls].other
        rv = ic rv
  elseif it = inline_tag[@tag][FORMAT] or
      inline_tag[@tag].other
    rv = it rv
  return rv

-- replace a span with its content if it has no attributes
strip_bare_span = =>
  for a in *{@identifier, @classes, @attributes}
    unless a -- has no attrs?
      return @
    -- fortunately # works on both strings and arrays
    if #a > 0 then return @
  return @content


return {
  { Inline: inline_style }
  { Span: strip_bare_span }
}
