require_relative 'cryptographer.rb'

message = File.read(ARGV[0]).chomp
key = rand(99999)
date = Time.new.strftime("%d""%m""%y")

encrypted = Cryptographer.new(message, key, date).encryptor(message, key, date)

File.write(ARGV[1], encrypted)

puts "Created #{ARGV[2]} with the key #{key} and date #{date}"
