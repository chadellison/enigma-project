require 'simplecov'
require 'minitest/autorun'
require_relative '../lib/cryptographer'
require_relative 'test_helper'
require 'pry'

class CryptographerTest < Minitest::Test
  def test_it_is_part_of_the_encryptor_class
    encrypt = Cryptographer.new
    assert_equal Cryptographer, encrypt.class
  end

  def test_the_encryptor_class_creates_a_new_key_generator_object_when_it_is_initialized
    encrypt = Cryptographer.new
    assert_equal KeyGenerator, encrypt.the_key.class
  end

  def test_the_encrypter_class_creates_a_new_wheel_object_when_it_is_initialized
    encrypt = Cryptographer.new
    assert_equal Wheel, encrypt.the_wheel.class
  end

  def test_the_encryptor_method_takes_a_string_and_returns_an_array_of_numbers
    encrypt = Cryptographer.new
    assert_equal Array, encrypt.rotations.class
    encrypt.encryptor("jones")
    assert_equal true, encrypt.rotations.sample.class == Fixnum
  end

  def test_the_encryptor_method_can_encrypt_a_message_with_a_passed_in_key
    skip
    encrypt = Cryptographer.new
    encrypt.encryptor("jones", 12345)
    assert_equal [12, 23, 34, 45], encrypt.key_generator.current_key
  end

  def test_encrypted_message_starts_as_nil
    encrypt = Cryptographer.new
    assert_equal nil, encrypt.encrypted_message
  end

  def test_encryptor_stores_a_set_of_number_rotations_and_returns_a_string
    encrypt = Cryptographer.new
    assert_equal String, encrypt.encryption.class
    encrypted = encrypt.encryptor("a message")
    assert_equal Fixnum, encrypt.rotations.sample.class
    assert_equal 9, encrypt.encryption.length
  end

  def test_the_encryptor_takes_the_current_key_and_adds_the_index_number_to_the_rotations
    encrypt = Cryptographer.new
    encrypt.encryptor("hello")
    assert encrypt.rotations[0] == encrypt.the_key.offset_key[0] + 7
    assert encrypt.rotations[1] == encrypt.the_key.offset_key[1] + 4
    assert encrypt.rotations[2] == encrypt.the_key.offset_key[2] + 11
    assert encrypt.rotations[3] == encrypt.the_key.offset_key[3] + 11
    assert encrypt.rotations[4] == encrypt.the_key.offset_key[0] + 14
  end

  def test_the_encryption_method_indexes_the_correct_wheel_characters
    encrypt = Cryptographer.new
    encrypt.encryptor("message")
    assert encrypt.the_wheel.wheel.index("m") == 12
    assert encrypt.the_wheel.wheel.index("c") == 2
  end

  def test_the_encryptor_method_correctly_rotates_each_inputed_character
    encrypt = Cryptographer.new
    encrypt.encryptor("jones")
    assert_equal encrypt.rotations[0], encrypt.the_key.offset_key[0] + 9
    assert_equal encrypt.rotations[1], encrypt.the_key.offset_key[1] + 14
    assert_equal encrypt.rotations[2], encrypt.the_key.offset_key[2] + 13
    assert_equal encrypt.rotations[3], encrypt.the_key.offset_key[3] + 4
    assert_equal encrypt.rotations[4], encrypt.the_key.offset_key[0] + 18
  end

  def test_the_encryption_method_returns_an_encrypted_string_and_stores_it
    encrypt = Cryptographer.new
    encrypt.encryptor("jones went to the store")
    assert encrypt.encryption
    assert_equal 23, encrypt.encryption.length
    assert_equal encrypt.encryption, encrypt.encrypted_message
  end

  def test_the_decryptor_method_takes_a_key_and_correctly_rotates_the_wheel_backward
    decrypt = Cryptographer.new
    decrypt.decryptor("abcd", 12345)
    assert_equal 56, decrypt.decrypt_rotations[0]
    assert_equal 62, decrypt.decrypt_rotations[1]
    assert_equal 72, decrypt.decrypt_rotations[2]
    assert_equal 85, decrypt.decrypt_rotations[3]
  end

  def test_the_decryption_method_returns_the_original_message_from_a_scrambled_message
    decrypt = Cryptographer.new
    decrypt.encryptor("check and see if this message works")
    decrypt.decryptor("f7cznx. gxq1hxg2agf5vxk1vf.3hxu.u q", 36357)
    assert_equal decrypt.decryption, "check and see if this message works"
  end

  def test_if_a_key_is_not_passed_into_the_encrypt_method_one_will_be_randomely_generated
    skip
  end

  def test_if_no_key_is_passed_into_the_decryptor_method_it_will_use_the_current_key_by_default
    skip
  end

  def test_it_also_works_with_capital_letters_and_numbers
    decrypt = Cryptographer.new
    decrypt.encryptor("JONES WEnt to the STORE 5 times")
    decrypt.decryptor("wblv5xuv0g8 1xryrxq 1ecofxrzz4q", 46351)
    assert_equal decrypt.decryption, "jones went to the store 5 times"
  end

  def test_the_decryption_method_can_also_take_the_key_in_the_form_of_a_string
    decrypt = Cryptographer.new
    decrypt.encryptor("this is a decent message")
    decrypt.decryptor("aonnrpx5uei,wlsortjn,hl,", "14429")
    assert_equal "this is a decent message", decrypt.decryption
  end

  def test_the_decryption_method_also_stores_the_decrypted_string
    decrypt = Cryptographer.new
    decrypt.encryptor("here is my message..end..")
    decrypt.decryptor("i.56.c6znslbfm62h.m0fhr0,", 73123)
    decrypt.decryption
    assert_equal "here is my message..end..", decrypt.decrypted_message
  end
end
