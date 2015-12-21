require_relative 'wheel'
require_relative 'key_generator'

class TheCracker
  attr_reader :encrypted_message, :the_wheel, :crack_rotator, :cracked_message, :crack_indices, :key_location, :end_of_message

  def initialize
    @encrypted_message = encrypted_message
    @the_wheel = Wheel.new
    @crack_rotator = []
    @crack_indices = []
    @cracked_message = cracked_message
    @key_location = key_location
    @end_of_message = [6, 6, 39, 30, 40, 6, 6]
  end

  def crack(encrypted_message)
    @key_location = encrypted_message.length
    crack_rotator(encrypted_message)
    compute_rotator
    find_key_position
    print_cracked_message
  end

  def crack_rotator(encrypted_message)
    @encrypted_message = encrypted_message.chars
    7.times { @crack_rotator << @encrypted_message.pop }
    @crack_rotator.reverse!.map! { |char| the_wheel.wheel.reverse.index(char) }
  end

  def compute_rotator
    difference = @crack_rotator.zip(end_of_message).map do |combined|
      combined.reduce do |rot, end_rot|
        (rot - end_rot) % 44
      end
    end
    @crack_rotator = difference
  end

  def find_key_position
    if key_location % 4 == 0
      @crack_rotator = @crack_rotator[-4..-1]
    elsif key_location % 4 == 1
      @crack_rotator = @crack_rotator[-5..-2]
    elsif key_location % 4 == 2
      @crack_rotator = @crack_rotator[-6..-3]
    else
      @crack_rotator = @crack_rotator[-7..-4]
    end
  end

  def print_cracked_message
    while encrypted_message.first != nil
      @crack_rotator.map do |key|
        @crack_indices << (key + the_wheel.wheel.index(encrypted_message.shift))
        break if encrypted_message.length == 0
      end
    end
    crack = @crack_indices.map do |index|
      the_wheel.wheel[index % 44]
    end
    @cracked_message = crack.join + '..end..'
  end
end
