local ansicolors = require 'ansicolors'

local c27 = string.char(27)

describe('ansicolors', function()
  
  describe('.colorize', function()
    
    it('should do nothing with no options', function()
      assert_equal(ansicolors.colorize(nil, 'foo'), 'foo')
    end)
    
    it('should add red color to text', function()
      assert_equal(ansicolors.colorize('red', 'foo'), c27 .. '[31mfoo' .. c27 .. '[0m')
    end)
    
    it('should add red color to text with uppercase', function()
      assert_equal(ansicolors.colorize('Red', 'foo'), c27 .. '[31mfoo' .. c27 .. '[0m')
    end)
    
    it('should add red underlined text', function()
      assert_equal(ansicolors.colorize('UnderlineRed', 'foo'), c27 .. '[31m' .. c27 .. '[4mfoo' .. c27 .. '[0m')
    end)
    
    it('should parse the red background before the red foreground', function()
      assert_equal(ansicolors.colorize('RedBG', 'foo'), c27 .. '[41mfoo' .. c27 .. '[0m')
    end)
    
    it('should allow multiple attributes and spureous chars', function()
      assert_equal(ansicolors.colorize('underline_redbg_yellow_dim', 'foo'),  c27 .. '[41m' .. c27 .. '[33m' .. c27 .. '[4m' .. c27 .. '[2mfoo' .. c27 .. '[0m')
    end)
    
    it('should ignore order', function()
      assert_equal(ansicolors.colorize('underline_redbg_yellow', 'foo'), ansicolors.colorize('yellowRedBGUnderline', 'foo'))
    end)

  end)

  describe('__call', function()
   
    it('should work with any method, throwing no errors', function()
      assert_not_error(function() ansicolors.foo('foo') end)
      assert_not_error(function() ansicolors.red('foo') end)
    end)

    it('should work just like colorize', function()
      assert_equal(ansicolors.red('foo'), ansicolors.colorize('red', 'foo') )
      assert_equal(ansicolors.underline_redbg_yellow('foo'), ansicolors.colorize('yellowRedBGUnderline', 'foo'))
    end)

  end)
  
  
end)
