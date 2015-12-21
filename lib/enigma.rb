require_relative '../lib/cryptographer'
require_relative '../lib/the_cracker'

class Enigma
  def encrypt(message, key = nil, date = nil)
    Cryptographer.new.encrypt(message, key, date)
  end

  def decrypt(message, key = nil, date = nil)
    Cryptographer.new.decrypt(message, key, date)
  end

  def crack(message)
    TheCracker.new.crack(message)
  end
end
