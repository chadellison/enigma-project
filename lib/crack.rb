require_relative 'the_cracker.rb'

encrypted_message = File.read(ARGV[0]).chomp
date = ARGV[2]

cracked_message = TheCracker.new.crack(encrypted_message)
File.write(ARGV[1], cracked_message)

puts "Created #{ARGV[1]} with a cracked message"
