require 'wheel'
require 'test_helper'

class WheelTest < Minitest::Test
  def test_it_is_part_of_the_wheel_class
    wheel = Wheel.new
    assert_equal Wheel, wheel.class
  end

  def test_the_wheel_method_creates_an_array_of_58_string_characters
    wheel = Wheel.new
    assert_equal Array, wheel.wheel.class
    assert_equal String, wheel.wheel.sample.class
    assert_equal 44, wheel.wheel.length
  end

  def test_it_returns_the_characters_a_z_0_9_and_some_other_characters
    the_wheel = Wheel.new
      assert_equal ["a",
     "b",
     "c",
     "d",
     "e",
     "f",
     "g",
     "h",
     "i",
     "j",
     "k",
     "l",
     "m",
     "n",
     "o",
     "p",
     "q",
     "r",
     "s",
     "t",
     "u",
     "v",
     "w",
     "x",
     "y",
     "z",
     "0",
     "1",
     "2",
     "3",
     "4",
     "5",
     "6",
     "7",
     "8",
     "9",
     " ",
     ".",
     ",",
     ";",
     "*",
     "@",
     "!",
     "_"],
     the_wheel.wheel
  end
end
