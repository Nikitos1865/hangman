require('./lib/hangman')
require('json')

puts "Welcome to hangman!"
puts "Please choose a saved game below or print new to start a new game"

system('ls ./save_files')

input = gets.chomp

if input == "new"
    hang = Hangman.new()
else
    begin
    file = File.open("./save_files/#{input}", 'r')
    data_hash = JSON.parse(file)
    puts data_hash
    rescue 
        puts 'file does not exist, try again and be careful with spelling'
    end 
end 





