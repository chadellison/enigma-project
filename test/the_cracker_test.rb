require 'simplecov'
require 'minitest/autorun'
require_relative '../lib/the_cracker'
require_relative 'test_helper'
require 'pry'

class TheCrackerTest < Minitest::Test

  def test_it_creates_a_wheel_object_when_it_is_initialized
    crack = TheCracker.new
    assert_equal Wheel, crack.the_wheel.class
  end

  def test_the_crack_mathod_takes_a_string_as_an_argument_and_converts_it_to_an_array
    message_cracker = TheCracker.new
    message_cracker.crack("dkfsoeh")
    assert_equal Array, message_cracker.encrypted_message.class
  end

  def test_the_crack_method_loads_the_rotator_with_four_rumbers
    message_cracker = TheCracker.new
    message_cracker.crack("adsfiueefdasjkh")
    assert_equal 4, message_cracker.crack_rotator.length
    assert_equal Fixnum, message_cracker.crack_rotator.sample.class
  end

  def test_the_end_of_message_array_is_properly_indexed
    message_cracker = TheCracker.new
    assert_equal [1, 1, 34, 25, 35, 1, 1], message_cracker.end_of_message
  end

  def test_the_compute_rotator_method_stores_the_difference_between_the_encrypted_characters_and_end
    skip
    message_cracker = TheCracker.new
    assert_equal [38, 38, 5, 14, 4, 38, 38], message_cracker.crack_rotator
  end

  def test_it_stores_the_numeric_values_of_the_encrypted_message_minus_the_end
    message_cracker = TheCracker.new
    message_cracker.crack("dasfehkjhoiuvncm,z")
    assert message_cracker.crack_indices
    assert_equal 11, message_cracker.crack_indices.length
  end

  def test_the_find_rotator_position_method_finds_the_position_of_the_key_based_on_length
    the_cracker = TheCracker.new
    message_cracker = TheCracker.new
    cracker = TheCracker.new
    the_crack = TheCracker.new
    the_cracker.crack("abcdefghi")
    assert_equal 1, the_cracker.key_location % 4
    message_cracker.crack("abcdefghij")
    assert_equal 2, message_cracker.key_location % 4
    cracker.crack("abcdefghijk")
    assert_equal 3, cracker.key_location % 4
    the_crack.crack("abcdefghijkl")
    assert_equal 0, the_crack.key_location % 4
  end

  def test_print_cracked_message_cracks_any_message_with_a_valid_key_that_ends_with_dot_dot_end_dot_dot
    the_cracker = TheCracker.new
    the_cracker.crack("6a2nkb,5n3x,p 7okfyn560,l4yiq4s")
    assert_equal "this is a decent message..end..", the_cracker.print_cracked_message
  end
  # def test_it_lines the rotator up according to the length of the message
  # end


end
