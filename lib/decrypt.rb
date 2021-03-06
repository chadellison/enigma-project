require_relative 'cryptographer.rb'

encrypted_message = File.read(ARGV[0]).chomp
key = ARGV[2]
date = ARGV[3].to_i

decrypted_message = Cryptographer.new.decrypt(encrypted_message, key, date)
File.write(ARGV[1], decrypted_message)

puts "Created #{ARGV[1]} with the key #{key} and the date #{date}"
