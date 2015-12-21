require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative '../lib/key_generator'
require_relative 'test_helper'
require 'pry'


class KeyGeneratorTest < Minitest::Test

  def random_number
    12345
  end

  def date
    181215
  end

  def test_it_is_part_of_the_key_generator_class
    key = KeyGenerator.new
    assert_equal KeyGenerator, key.class
  end

  def test_it_produces_a_random_five_digit_number
    key = KeyGenerator.new
    assert_equal 5, key.key.to_s.length
  end

  def test_it_returns_the_day_month_and_year_as_a_six_digit_integer
    key = KeyGenerator.new
    assert_equal 181215, date
  end

  def test_the_date_offset_method_returns_an_array_of_the_integers_of_the_date_sqaured
    key = KeyGenerator.new
    assert_equal [6, 2, 2, 5], key.date_offset
  end

  def test_the_initial_key_values_method_returns_an_array_of_4_2_digit_numbers
    key = KeyGenerator.new(12345)
    assert_equal [12, 23, 34, 45], key.initial_key_values
  end

  def test_the_initial_key_values_method_will_randomly_generate_a_key_if_one_is_not_given
    key = KeyGenerator.new(73246)
    assert_equal [73, 32, 24, 46], key.initial_key_values
    rand_key = KeyGenerator.new
    assert_equal 4, rand_key.initial_key_values.length
  end

  def test_the_rotator_method_fuses_the_key_with_the_date_offset
    key = KeyGenerator.new(12345)
    assert_equal [18, 25, 36, 50], key.rotator
    key = KeyGenerator.new
    assert_equal 4, key.rotator.length
  end
end
