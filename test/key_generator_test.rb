require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative '../lib/key_generator'
require_relative 'test_helper'
require 'pry'

class KeyGeneratorTest < Minitest::Test
  def test_it_is_part_of_the_key_generator_class
    initial_keys = KeyGenerator.new
    assert_equal KeyGenerator, initial_keys.class
  end

  def test_it_randomly_generates_a_five_digit_number
    initial_keys = KeyGenerator.new
    assert_equal 5, initial_keys.random_number_generator.length
  end

  def test_it_stores_the_five_digit_number_as_the_current_key
    initial_keys = KeyGenerator.new
    keys = initial_keys.initial_key_values
    assert_equal keys, initial_keys.current_key
  end

  def test_it_creates_a_new_array_of_four_one_or_two_digit_numbers
    initial_keys = KeyGenerator.new
    initial_keys.initial_key_values
    assert_equal 4, initial_keys.initial_key_values.length
  end

  def test_it_returns_the_last_four_integers_of_the_current_date_squared
    initial_keys = KeyGenerator.new
    current_date = Time.now.strftime("%d%m%y")
    current_date = current_date.to_i ** 2
    current_date = current_date.to_s[-4..-1].chars
    current_date = current_date.map { |num| num.to_i }
    assert_equal current_date, initial_keys.offset
    assert_equal 4, initial_keys.offset.length
  end

  def test_it_combines_the_offset_and_the_initial_key_values_into_an_array
    initial_keys = KeyGenerator.new
    initial_keys.initial_key_values
    assert_equal 4, initial_keys.key_generation.length
  end

  def test_the_current_key_instance_begins_at_nil
    initial_keys = KeyGenerator.new
    assert_equal nil, initial_keys.current_key
  end

  def test_the_current_key_obtains_a_value_and_is_stored_as_soon_as_the_initial_key_values_method_is_called
    initial_keys = KeyGenerator.new
    the_present_key = initial_keys.initial_key_values
    assert_equal the_present_key, initial_keys.current_key
  end

  def test_a_key_can_be_passed_instead_of_randomly_generated
    initial_keys = KeyGenerator.new
    initial_keys.initial_key_values(12345)
    assert_equal [12, 23, 34, 45], initial_keys.current_key
  end

  def test_it_stores_the_key_plus_offset_once_key_generation_is_called
    initial_keys = KeyGenerator.new
    key_plus_offset = initial_keys.key_generation
    assert_equal key_plus_offset, initial_keys.offset_key
  end

  def test_an_offset_key_will_not_exist_until_the_key_generatin_method_is_called
    initial_keys = KeyGenerator.new
    assert_equal nil, initial_keys.offset_key
    the_new_offset_key = initial_keys.key_generation
    assert_equal the_new_offset_key, initial_keys.offset_key
  end

  def test_when_the_key_generator_method_is_called_it_uses_the_same_key_as_the_current_key
    initial_keys = KeyGenerator.new
    the_present_key = initial_keys.initial_key_values
    difference = initial_keys.key_generation.zip(initial_keys.offset).map do |key|
      key.reduce do |dif, num|
        dif - num
      end
    end
    assert_equal difference, initial_keys.current_key
  end

  def test_the_key_generator_calls_the_initial_key_values_method_if_current_key_is_nil
    initial_keys = KeyGenerator.new
    assert_equal nil, initial_keys.current_key
    initial_keys.key_generation
    refute initial_keys.current_key == nil
  end
end
