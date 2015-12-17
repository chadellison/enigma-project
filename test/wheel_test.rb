require 'minitest/autorun'
require_relative '../lib/wheel'
require_relative 'test_helper'
require 'pry'

class WheelTest < Minitest::Test
  def test_it_is_part_of_the_wheel_class
    wheel = Wheel.new
    assert_equal Wheel, wheel.class
  end

  def test_it_returns_an_array_of_39_characters
    the_wheel = Wheel.new
    assert_equal 39, the_wheel.wheel.length
    assert_equal Array, the_wheel.wheel.class
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
   ","],
    the_wheel.wheel
  end
end
