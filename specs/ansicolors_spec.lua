local ansicolors = require 'ansicolors'

local c27 = string.char(27)

describe('ansicolors', function()
  
  describe('.colorize', function()
    
    it('should do nothing with no options', function()
      assert_equal(ansicolors.colorize('foo'), 'foo')
    end)
    
    it('should add red color to text', function()
      assert_equal(ansicolors.colorize('foo', 'red'), c27 .. '[31mfoo' .. c27 .. '[0m')
    end)
    
    it('should add red color to text with uppercase', function()
      assert_equal(ansicolors.colorize('foo', 'Red'), c27 .. '[31mfoo' .. c27 .. '[0m')
    end)
    
    it('should add red underlined text', function()
      assert_equal(ansicolors.colorize('foo', 'UnderlineRed'), c27 .. '[31m' .. c27 .. '[4mfoo' .. c27 .. '[0m')
    end)
    
    it('should parse the red background before the red foreground', function()
      assert_equal(ansicolors.colorize('foo', 'RedBG'), c27 .. '[41mfoo' .. c27 .. '[0m')
    end)
    
    it('should allow multiple attributes and spureous chars', function()
      assert_equal(ansicolors.colorize('foo', 'underline_redbg_yellow_dim'),  c27 .. '[41m' .. c27 .. '[33m' .. c27 .. '[4m' .. c27 .. '[2mfoo' .. c27 .. '[0m')
    end)
    
    it('should ignore order', function()
      assert_equal(ansicolors.colorize('foo', 'underline_redbg_yellow'), ansicolors.colorize('foo', 'yellowRedBGUnderline'))
    end)

  end)
  
  
end)
