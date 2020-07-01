local get_env_switch
get_env_switch = function(name)
  local val = tostring(os.getenv(name))
  local _exp_0 = val:lower()
  if '1' == _exp_0 or 'true' == _exp_0 or 't' == _exp_0 or 'yes' == _exp_0 or 'y' == _exp_0 then
    return true
  elseif '0' == _exp_0 or 'false' == _exp_0 or 'f' == _exp_0 or 'no' == _exp_0 or 'nil' == _exp_0 or 'n' == _exp_0 then
    return false
  else
    return error("Unknown value for environment variable " .. tostring(name) .. ": " .. tostring(val))
  end
end
local DEBUG = get_env_switch('PRA_PDC_CLASS_DEBUG')
local DO_MD = get_env_switch('PRA_PDC_CLASS_DO_MD')
if FORMAT:match('markdown') or FORMAT:match('gfm') and not DO_MD then
  return {
    {
      Pandoc = function()
        return nil
      end
    }
  }
end
local _assert
_assert = function(msg, val, lvl)
  if lvl == nil then
    lvl = 0
  end
  if DEBUG then
    return assert(val, msg)
  elseif val then
    return val
  else
    return error(msg, lvl + 2)
  end
end
local pdc = _assert("Couldn't find pandoc library.\n  Are you running this as a Pandoc Lua filter?", pandoc)
local ptext = _assert("Couldn't find the pandoc.text library", pdc.text)
local stringy
stringy = function(self)
  return tostring(self or "")
end
local reverse_array
reverse_array = function(self)
  local n = tonumber(self.n) or #self
  local _accum_0 = { }
  local _len_0 = 1
  for i = n, 1, -1 do
    _accum_0[_len_0] = self[i]
    _len_0 = _len_0 + 1
  end
  return _accum_0
end
latex_command(function(elem, cmd, post)
  if post == nil then
    post = '}'
  end
  cmd = stringy(cmd)
  post = stringy(post)
  if cmd:match('^%a+$') then
    cmd = "\\" .. tostring(cmd) .. "{"
  end
  return pdc.Span({
    pdc.RawInline('latex', cmd),
    elem,
    pdc.RawInline('latex', post)
  })
end)
local inline2span
inline2span = function(self)
  local _exp_0 = self.tag
  if 'Span' == _exp_0 or nil == _exp_0 then
    return self
  else
    local _exp_1 = type(self.content)
    if 'table' == _exp_1 then
      return pdc.Span(self.content)
    else
      return pdc.Span({
        self
      })
    end
  end
end
local ltc
ltc = function(cmd, post)
  return function(self)
    return latex_command(inline2span(self), cmd, post)
  end
end
local string_wrap
string_wrap = function(elem, pre, post)
  if post == nil then
    post = pre
  end
  return pdc.Span({
    pdc.Str(stringy(pre)),
    inline2span(elem),
    pdc.Str(stringy(post))
  })
end
local strw
strw = function(pre, post)
  return function(self)
    return string_wrap(inline2span(self), pre, post)
  end
end
local uc_str = {
  Str = function(self)
    return pdc.Str(ptext.upper(self.text))
  end
}
html_inline(function(elem, tag, close)
  if close == nil then
    close = tag
  end
  local open = "<" .. tostring(tag) .. ">"
  close = "</" .. tostring(close) .. ">"
  return pdc.Span({
    pdc.RawInline('html', open),
    elem,
    pdc.RawInline('html', close)
  })
end)
local pdc_usc = {
  Str = function(self)
    local rv = { }
    for lc, uc in self.text:gmatch('(%U*)(%u*)') do
      if #lc > 0 then
        rv[#rv + 1] = pdc.Str(lc)
      end
      if #uc > 0 then
        uc = ptext.lower(uc)
        rv[#rv + 1] = pdc.SmallCaps(pdc.Str(uc))
      end
    end
    return rv
  end
}
local inline_class = {
  sc = {
    latex = (function(self)
      return pdc.SmallCaps(self.content)
    end),
    plain = (function(self)
      return pdc.walk_inline(self, uc_str)
    end)
  },
  usc = {
    latex = ltc('textusc'),
    other = (function(self)
      return pdc.walk_inline(self, pdc_usc)
    end)
  },
  pra = {
    latex = ltc('\\textbf{\\textit{', '}}'),
    plain = strw('«', '»')
  }
}
local inline_tag = {
  Emph = {
    latex = ltc('uline'),
    plain = strw('_')
  },
  Strong = {
    latex = ltc('uuline'),
    plain = strw('__')
  },
  Strikeout = {
    latex = ltc('textsc'),
    plain = function(self)
      return inline_class.sc.plain
    end
  }
}
local _list_0 = {
  inline_class,
  inline_tag
}
for _index_0 = 1, #_list_0 do
  local disps = _list_0[_index_0]
  for name, disp in pairs(disps) do
    if nil == disp.markdown then
      disp.markdown = disp.plain
    end
  end
end
local inline_style
inline_style = function(self)
  local rv = self
  if self.classes then
    local classes = reverse_array(self.classes)
    for _index_0 = 1, #classes do
      local cls = classes[_index_0]
      do
        local ic = inline_class[cls][FORMAT] or inline_class[cls].other
        if ic then
          rv = ic(rv)
        end
      end
    end
  else
    do
      local it = inline_tag[self.tag][FORMAT] or inline_tag[self.tag].other
      if it then
        rv = it(rv)
      end
    end
  end
  return rv
end
local strip_bare_span
strip_bare_span = function(self)
  local _list_1 = {
    self.identifier,
    self.classes,
    self.attributes
  }
  for _index_0 = 1, #_list_1 do
    local a = _list_1[_index_0]
    if not (a) then
      return self
    end
    if #a > 0 then
      return self
    end
  end
  return self.content
end
return {
  {
    Inline = inline_style
  },
  {
    Span = strip_bare_span
  }
}
