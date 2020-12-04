require_relative '../config/environment.rb'



class Hello

    HELLO = [5, 6]


    def hi
        HELLO.each do |num|
            puts num.to_s
        end
    end

end


yo = Hello.new

yo.hi