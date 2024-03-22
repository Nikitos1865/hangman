require 'json'
require 'date'
class Hangman
    attr_accessor :word_choice, :board, :lives_left

    def initialize(*args)
        if args.length == 0 
            @word_choice = choose_word
            @board = make_board(word_choice)
            @lives_left = 8
            show_board
            show_lives
            play
        elsif args.length == 3
            @word_choice = args[0]
            @board = args[1]
            @lives_left = args[2]
            show_board
            show_lives
            play
        end 
    end

    def make_board(word) 
        board = ''
        word.length.times {board << "_"}
        board
    end 

    def show_board
        string = 'Here are the letters: '
        board.split('').each do |letter|
            string << letter+' '
        end
        puts string
    end 

    def show_lives
        lives = ''
        lives_left.times do
            lives << '* '
        end 
        puts "Lives left: #{lives}"
    end 


    def choose_word
        dict_array = []
        valid = false
        while valid == false 
            File.read('google-10000-english-no-swears.txt').lines().each do |word|
                dict_array << word.chomp 
            end 
            word_choice = dict_array[rand(1..10000)]
            if word_choice.length >= 5 && word_choice.length <= 12 
                valid = true
            end 
        end 
        word_choice
    end

    def turn
        valid = false 
        while !valid
            letter = gets.downcase.chomp
            if letter.length != 1
                puts "Guess exactly 1 letter"
            elsif letter == "1"
                puts save_game
            elsif letter == "2"
                exit! 
            else
                valid = true
                mark_board(letter)
            end 
        end
    end
    
    def mark_board(letter)
        good_guess = false
        word_choice.split('').each_with_index do |char, index|
            if letter == char
                board[index] = letter
                good_guess = true
            end
        end
        if good_guess == false
            @lives_left -= 1
        end
    end

    def play  
        while board.include?("_") && lives_left > 0
            turn
            show_board
            show_lives
        end 
        if lives_left == 0 
            puts "You have lost"
        else puts "You won!"    
        end 
    end 

    def save_game
        Dir.mkdir('save_files') if !Dir.exist?('save_files')
        game = {word: word_choice, board: board, lives: lives_left}
        json = JSON.generate(game)
        date = DateTime.now()
        filename = "./save_files/saved_game_#{date.strftime('%m-%d-%Y_%I:%M%p')}"
        File.open(filename, 'w') do |file|
            file.puts(json)
        end
    end 

end 



