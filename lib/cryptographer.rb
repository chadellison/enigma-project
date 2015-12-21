require_relative 'wheel'
require_relative 'key_generator'

class Cryptographer
  attr_reader :wheel

  def initialize
    @wheel = Wheel.new
  end

  def encrypt(message, key = nil, date = nil)
    rotate = KeyGenerator.new(key, date).rotator
    message = message.to_s.downcase.chars
    rotations = []
    while message.first != nil
      rotate.map do |key|
        rotations << (key + wheel.wheel.index(message.shift))
        break if message.length == 0
      end
    end
    encryption(rotations)
  end

  def decrypt(message, key = nil, date = nil)
    rotate = KeyGenerator.new(key, date).rotator
    message = message.to_s.downcase.chars
    rotations = []
    while message.first != nil
      rotate.map do |key|
        rotations << (key + wheel.wheel.reverse.index(message.shift))
        break if message.length == 0
      end
    end
    decryption(rotations)
  end

  def encryption(rotations)
    encryption = rotations.map do |index|
      wheel.wheel[index % 44]
    end
    encryption.join
  end

  def decryption(rotations)
    decryption = rotations.map do |index|
      wheel.wheel.reverse[index % 44]
    end
    decryption.join
  end
end
