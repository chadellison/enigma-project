require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative '../lib/enigma'
require_relative 'test_helper'
require 'pry'

class EnigmaTest < Minitest::Test
  def test_it_initiates
    enigma = Enigma.new
    assert_equal Enigma, enigma.class
  end

  def test_it_can_encrypt_any_string_with_or_without_a_provided_key
    enigma = Enigma.new
    assert_equal 5, enigma.encrypt("jones").length
    assert_equal String, enigma.encrypt("jones", 46834).class
  end

  def test_it_can_encrypt_any_string_with_a_key_given_as_an_integer_or_number
    enigma = Enigma.new
    assert_equal 10, enigma.encrypt("this is it", "34672").length
    assert_equal 10, enigma.encrypt("this is it", 36754).length
  end

  def test_the_encrypt_method_validly_encrypts_a_message_whether_a_key_is_passed_to_it_or_not
    enigma = Enigma.new
    assert_equal "this is a valid encryption ..end..", enigma.crack("2.shg,2zj152u,nznemg7g3 xeh0h8x5h2")
    assert_equal "this is a valid encryption ..end..", enigma.decrypt(".6f3p7piswsl37aiw,,2dbqt6,7jq3koqx", 12345)
  end

  def test_the_decrypt_method_decrypts_any_valid_message_with_a_provided_key
    enigma = Enigma.new
    assert_equal "here is a message to decrypt", enigma.decrypt("81b4y5cx1u94gcx65udby012fi,g", 99999)
  end

  def test_it_will_crack_any_validly_encrypted_message_that_ends_with_dot_dot_end_dot_dot
    enigma = Enigma.new
    assert_equal "here is a message that must be cracked ..end..", enigma.crack("b90u4a1n72vumkjw.22x7lg2ok2n89gsl5l0.8go59wt53")
    assert_equal "this one had a key passed in ..end..", enigma.crack("sy0d95529ys19rp8dcpa,9 2co0.9pq2muqw")
  end
end
