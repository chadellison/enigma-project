require_relative 'cryptographer.rb'

message = File.read(ARGV[0]).chomp
key = rand(0..99999)
date = Time.new.strftime("%d%m%y").to_i

encrypted = Cryptographer.new.encrypt(message, key, date)

File.write(ARGV[1], encrypted)

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
