#require_relative '../config/environment.rb'



def hello
    choice = gets.chomp
    if choice == 'hi'
        puts 'hi'
    else
        hello
    end
end

hello