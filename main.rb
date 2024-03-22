#!/usr/bin/env ruby
require('./lib/hangman')
require('json')

save_files_arr = []

puts "Welcome to hangman!"
puts "Please choose a saved game below or print new to start a new game"


save_files_arr = []
File.open('save_files.txt', 'w+') {|file| file.write(`ls ./save_files`)}
File.open('save_files.txt', 'r') do |f|
    f.each_line do |line|
        save_files_arr << line
    end 
end 

save_files_arr.each_with_index {|save, index| puts "#{index+1}: #{save}"}



valid = false 
while valid == false 
    input = gets.chomp
    if input == "new"
        valid = true
        hang = Hangman.new()
    else
        begin
            data_string = '' 
            file = File.open("./save_files/#{save_files_arr[input.to_i-1]}".chomp).each {|line| data_string << line}
            data_hash = JSON.parse(data_string)
            File.delete(file)
            valid = true
            hang = Hangman.new(data_hash["word"], data_hash["board"], data_hash["lives"])
        rescue 
            puts 'file does not exist, try again and be careful with spelling' 
        end 
    end 
end 


