require 'enigma'
require_relative 'test_helper'

class EnigmaTest < Minitest::Test
  def test_it_makes_an_enigma_object
    enigma = Enigma.new
    assert Enigma, enigma.class
  end

  def test_the_encrypt_method_takes_three_arguments_but_only_needs_one
    enigma = Enigma.new
    assert enigma.encrypt("jones", "12345", 171082)
    assert_equal 5, enigma.encrypt("jones").length
    assert_equal String, enigma.encrypt("jones", 12345).class
  end

  def test_the_encrypt_method_defaults_to_a_random_key_and_current_date_if_not_provided
    enigma = Enigma.new
    assert enigma.encrypt("jones")
  end

  def test_the_encrypt_method_encrypts_a_message_based_on_the_date_and_key
    enigma = Enigma.new
    assert_equal "1;fk rok5a2z6rlnwrkz6!*", enigma.encrypt("Jones went to the store", 12345, 191215)
  end

  def test_the_decrypt_method_takes_three_arguments_it_defualts_to_the_current_date
    enigma = Enigma.new
    assert enigma.decrypt("adklfjadklf", 12345, 180293)
    assert enigma.decrypt("dfjasl;fk")
  end

  def test_the_decrypt_method_decrypts_a_message_based_on_the_key_and_date
    enigma = Enigma.new
    assert_equal "jones went to the store 5 times", enigma.decrypt("7j2w!5.w.oh.,58z257.,mtkl580 _7", 67953, 23183)
  end
end
