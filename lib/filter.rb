require_relative '../config/environment.rb'


class Filter

    attr_accessor :data, :interface, :article, :index

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

    def article
        self.data['results'][self.index]
    end

    def author
        self.article['byline'].gsub("By ", "")
    end

    def clear_information
        self.index, self.article = nil, nil
    end

end

