require_relative '../config/environment.rb'



class GetRequester
    
    attr_accessor :url, :section

    def initialize(section)
        @section = section
        @url = "https://api.nytimes.com/svc/topstories/v2/#{self.section}.json?api-key=sH1eLe6haGnCuuLewjFLQsgAZFXDetDo"
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

