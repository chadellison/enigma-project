require 'minitest/autorun'
require 'cryptographer'
require 'test_helper'

class CryptographerTest < Minitest::Test
  def test_it_belongs_to_the_cryptographer_class
    crypto = Cryptographer.new
    assert_equal Cryptographer, crypto.class
  end

  def test_the_encrypt_method_takes_three_arguments_but_only_needs_one
    crypto = Cryptographer.new
    assert crypto.encrypt("jones", 12345, 181215)
    assert crypto.encrypt("james")
  end

  def test_the_encrypt_method_defaults_to_a_random_key_and_current_date_if_not_provided
    crypto = Cryptographer.new
    assert_equal String, crypto.encrypt("this message").class

  end

  def test_the_encrypt_method_returns_an_encrypted_string
    crypto = Cryptographer.new
    assert_equal 17, crypto.encrypt("take this message").length
    refute crypto.encrypt("jones") == "jones"
    assert_equal String, crypto.encrypt("jones").class
  end

  def test_the_encrypt_method_encrypts_a_message_based_on_the_date_and_key
    crypto = Cryptographer.new
    assert_equal "s0,j", crypto.encrypt("abcd", 12345, 191215)
    rand_crypto = Cryptographer.new
    assert_equal 5, rand_crypto.encrypt("Jones").length
    assert_equal String, rand_crypto.encrypt("abcdefg").class
  end

  def test_the_encrypt_method_can_also_rotate_according_to_non_current_dates
    crypto = Cryptographer.new
    assert_equal "r7!f", crypto.encrypt("abcd", 12345, 191219)
  end

  def test_the_decrypt_method_takes_three_arguments
    crypto = Cryptographer.new
    assert crypto.decrypt("ncaieaa daf", 35421, 191215)
    crypto = Cryptographer.new
    assert crypto.decrypt("dfajk;as")
  end

  def test_the_decrypt_method_returns_a_decrypted_string_according_to_the_key_and_date_sent
    crypto = Cryptographer.new
    assert_equal "the decrypt method works", crypto.decrypt(".6*!v3,x!*l!43ln62226!cy", 12345, 191215)
    assert_equal "here is another message to decrypt", crypto.decrypt("k.!r;@_fdc;6k.!fp._5d;3fwdrqh9!.si", 43257, 119290)
  end
end
