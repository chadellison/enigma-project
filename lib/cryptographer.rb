require_relative 'key_generator'
require_relative 'wheel'

class Cryptographer
  attr_reader :key, :key_generator, :the_wheel, :rotations, :decrypt_rotations, :encrypted_message, :decrypted_message

  def initialize
    @key_generator = KeyGenerator.new
    @the_wheel = Wheel.new
    @rotations = []
    @decrypt_rotations = []
    @encrypted_message = encrypted_message
    @decrypted_message = decrypted_message
  end

  def encryptor(message)
    #key_generator
    #the_wheel
    message = message.to_s.downcase.chars
    while message.first != nil
      key_generator.key_generation.map do |key|
        @rotations << (key + the_wheel.wheel.index(message.shift))
        break if message.length == 0
      end
    end
    @rotations #not sure if you need to return this
  end

  def decryptor(message, key = key_generator.current_key)
    key_generator.initial_key_values(key.to_i)
    #the_wheel
    message = message.to_s.downcase.chars
    while message.first != nil
      key_generator.key_generation.map do |key|
        @decrypt_rotations << (key + the_wheel.wheel.reverse.index(message.shift))
        break if message.length == 0
      end
    end
    @decrypt_rotations #not sure if you need to return this
  end

  def encryption
    encryption = @rotations.map do |index|
      the_wheel.wheel[index % 39]
    end
    @encrypted_message = encryption.join
  end

  def decryption
    decryption = @decrypt_rotations.map do |index|
      the_wheel.wheel.reverse[index % 39]
    end
    @decrypted_message = decryption.join
  end
end

a = Cryptographer.new
a.encryptor("some refactoring action is on the way..end..")
puts a.key_generator.current_key
puts "--"
# #
puts a.encryption
puts a.encrypted_message
#
# puts a.decryptor("k.56ac6zpslbhm62j.m0hhr0b", "73123")
# puts a.decryption
# puts a.decrypted_message
