-- Copyright (c) 2009 Rob Hoelz <rob@hoelzro.net>
-- Copyright (c) 2011 Enrique García Cota <enrique.garcia.cota@gmail.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

local ansicolors = {}

local codes = {
  -- misc
  bright     = 1,
  dim        = 2,
  underline  = 4,
  blink      = 5,
  reverse    = 7,
  hidden     = 8,

  -- foreground colors
  black     = 30,
  red       = 31,
  green     = 32,
  yellow    = 33,
  blue      = 34,
  magenta   = 35,
  cyan      = 36,
  white     = 37,

  -- background colors
  blackbg   = 40,
  redbg     = 41,
  greenbg   = 42,
  yellowbg  = 43,
  bluebg    = 44,
  magentabg = 45,
  cyanbg    = 46,
  whitebg   = 47
}

local codeNames = {}
for name,_ in pairs(codes) do table.insert(codeNames, name) end
table.sort(codeNames, function(a,b) return codes[a] > codes[b] end)

local escapeString = string.char(27) .. '[%dm'
local function escapeNumber(number)
  return escapeString:format(number)
end

local function escapeNumbers(numbers)
  local buffer = {}
  for i=1, #numbers do
    table.insert(buffer, escapeNumber(numbers[i]))
  end
  return table.concat(buffer)
end

local reset = escapeNumber(0)

local function options2numbers(options)
  local numbers, substitutions, codeName = {}, 0
  for i = 1, #codeNames do
    codeName = codeNames[i]
    options, substitutions = options:gsub(codeName, '')
    if substitutions > 0 then
      table.insert(numbers, codes[codeName])
    end
  end
  return numbers
end

function ansicolors.colorize( text, options )
  options = string.lower(options or '')
  
  local numbers = options2numbers(options)

  if #numbers == 0 then return text end
  
  return escapeNumbers(numbers) .. text .. reset
end

return ansicolors
