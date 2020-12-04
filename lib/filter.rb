require_relative '../config/environment.rb'


class Filter

    attr_accessor :data, :interface, :article

    def initialize(data)
        @data = data
    end


    def create_headlines_array
        headlines_array = []
        self.data['results'].each { |article| headlines_array.push(article['title'])}
        headlines_array
    end

    def enumerate(array)
        array.map { |element| element = [array.index(element) + 1, element] }
    end

    def num_headlines
        create_headlines_array.length
    end


    def headlines_array_enumerated_puts(range)
        headlines_array_enumerated = self.enumerate(self.create_headlines_array)
        headlines_array_enumerated[range].each { |headline| puts "#{headline[0]}. #{headline[1]}"}
    end

    def article
        self.data['results'][self.interface.article_index]
    end

    def author
        self.article['byline'].gsub("By ", "")
    end

end

