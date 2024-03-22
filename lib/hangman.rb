class Hangman
    attr_accessor :word_choice, :board

    def initialize
        @word_choice = choose_word
        @board = make_board(word_choice)
    end 

    def make_board(word) 
        board = ''
        word.length.times {board << "_"}
        board
    end 

    def show_board
        string = ''
        board.split('').each do |letter|
            string << letter+' '
        end
        puts string
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



    
end 

hang = Hangman.new

puts hang.word_choice
puts hang.board


hang.show_board