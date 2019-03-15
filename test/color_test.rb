require 'minitest/autorun'
require_relative '../rb/color.rb'

class ColorTest < Minitest::Test
  def test_to_hsl2rgb
    assert_equal Color.hsl2rgb(h: 0, s: 100, l: 50), r: 255, g: 0, b: 0
    assert_equal Color.hsl2rgb(h: 0, s: 0, l: 100), r: 255, g: 255, b: 255
    assert_equal Color.hsl2rgb(h: 60, s: 100, l: 50), r: 255, g: 255, b: 0
    assert_equal Color.hsl2rgb(h: 30, s: 100, l: 50), r: 255, g: 127, b: 0
    assert_equal Color.hsl2rgb(h: 90, s: 100, l: 50), r: 127, g: 255, b: 0
    assert_equal Color.hsl2rgb(h: 150, s: 100, l: 50), r: 0, g: 255, b: 127
    assert_equal Color.hsl2rgb(h: 210, s: 100, l: 50), r: 0, g: 127, b: 255
    assert_equal Color.hsl2rgb(h: 270, s: 100, l: 50), r: 127, g: 0, b: 255
    assert_equal Color.hsl2rgb(h: 330, s: 100, l: 50), r: 255, g: 0, b: 127
    assert_equal Color.hsl2rgb(h: 210, s: 20, l: 40), r: 82, g: 102, b: 122
    assert_equal Color.hsl2rgb(h: 0, s: 70, l: 20), r: 87, g: 15, b: 15
    assert_equal Color.hsl2rgb(h: 30, s: 70, l: 20), r: 87, g: 51, b: 15
    assert_equal Color.hsl2rgb(h: 90, s: 70, l: 20), r: 51, g: 87, b: 15
    assert_equal Color.hsl2rgb(h: 150, s: 70, l: 20), r: 15, g: 87, b: 51
    assert_equal Color.hsl2rgb(h: 210, s: 70, l: 20), r: 15, g: 51, b: 87
    assert_equal Color.hsl2rgb(h: 270, s: 70, l: 20), r: 51, g: 15, b: 87
    assert_equal Color.hsl2rgb(h: 330, s: 70, l: 20), r: 87, g: 15, b: 51
  end
end
