require_relative '../config/environment.rb'


class Filter

    attr_accessor :data, :my_interface, :article

    def initialize(data_in_json)
        @data = data_in_json
    end


    def create_headlines_array
        headlines_array = []
        self.data['results'].each do |article|
            headlines_array.push(article['title'])
        end
        headlines_array
    end

    def enumerate_results(array)
        array.map do |element|
            element = [array.index(element) + 1, element]
        end
    end

    def num_headlines
        create_headlines_array.length
    end


    def headlines_array_enumerated_puts(range)
        headlines_array_enumerated = self.enumerate_results(self.create_headlines_array)
        headlines_array_enumerated[range].each do |headline|
            puts "#{headline[0]}. #{headline[1]}"
        end
    end

    def article
        self.data['results'][self.my_interface.article_selection_index]
    end

    def author
        self.article['byline'].gsub("By ", "")
    end





end

