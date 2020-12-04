require_relative '../config/environment.rb'


class Filter

    attr_accessor :data

    def initialize(data_in_json)
        @data = data_in_json
    end

    def return_section_headlines
        self.data['results'].each do |article|
            puts article['title']
        end
    end



end

