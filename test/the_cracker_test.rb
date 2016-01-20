require 'the_cracker'
require 'test_helper'

class TheCrackerTest < Minitest::Test

  def test_it_is_a_part_of_the_cracker_class
    crack = TheCracker.new
    assert_equal TheCracker, crack.class
  end

  def test_it_creates_a_wheel_object_when_it_is_initialized
    crack = TheCracker.new
    assert_equal Wheel, crack.the_wheel.class
  end

  def test_the_crack_rotator_method_loads_the_rotator_with_the_last_seven_encrypted_message_index_rumbers
    message_cracker = TheCracker.new
    assert_equal Fixnum, message_cracker.crack_rotator("fdakfjd").sample.class
    crack = TheCracker.new
    assert_equal [42, 41, 40, 39, 38, 37, 36], crack.crack_rotator("abcdefgh")
  end

  def test_the_end_of_message_array_is_properly_indexed
    message_cracker = TheCracker.new
    assert_equal [6, 6, 39, 30, 40, 6, 6], message_cracker.end_of_message
  end

  def test_the_compute_rotator_method_stores_the_difference_between_the_encrypted_characters_and_end
    message_cracker = TheCracker.new
    assert_equal [42, 41, 40, 39, 38, 37, 36], message_cracker.crack_rotator("abcdefgh")
    assert_equal [6, 6, 39, 30, 40, 6, 6], message_cracker.end_of_message
    assert_equal [36, 35, 1, 9, 42, 31, 30], message_cracker.compute_rotator
  end

  def test_the_crack_indices_store_the_numeric_values_of_the_encrypted_message_minus_the_end
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

  def test_print_cracked_message_cracks_any_message_with_a_valid_key_and_ending
    the_cracker = TheCracker.new
    assert_equal "here is another message about jones ..end..",
    the_cracker.crack("z3jkk7k!s,gzz3j!43kys5*!s0g0.rbu53k!ls*tvs3")
  end
end
