require_relative '../config/environment.rb'



class GetRequester
    
    attr_reader :url

    def initialize
        @url = URL
    end

    def url_generator(section)
        url = 'https://api.nytimes.com/svc/topstories/v2/#{section}.json?api-key=sH1eLe6haGnCuuLewjFLQsgAZFXDetDo'
    end

    def get_response_body
        uri = URI.parse(self.url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def parse_json
        JSON.parse(get_response_body)
    end


end
