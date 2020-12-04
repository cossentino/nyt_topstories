require_relative '../config/environment.rb'


class UserInterface

    attr_accessor :section, :filter, :json, :article_index, :range_min, :range_max

 
    SECTIONS = ['u.s.', 'world', 'opinion', 'politics', 'arts', 'automobiles', 'books', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'NY Region', 'obituaries', 'Real Estate', 'science', 'sports', 'Sunday Review', 'technology', 'theater', 't-magazine', 'travel', 'upshot']
        
    def initialize
        @range_min, @range_max = 0, 9
    end
    
    def greeting
        t = Time.now
        today_date = [t.year, t.month, t.day]
        morn_end, eve_end = Time.new(*today_date, 12, 0, 0), Time.new(*today_date, 18, 0, 0)
        print "\n\n\n"
        if t < morn_end
            print "Good morning. "
        elsif t > eve_end
            print "Good evening. "
        else
            print "Good afternoon. "
        end
        puts "Let's get started with today's headlines.\n\n"; sleep(2)
    end

    def display_section_choices
        i, j = 1, 5
        puts "Popular Sections:\n\n"
        SECTIONS[0..3].each { |sec| puts "#{i}. #{sec.capitalize}"; i += 1 }
        puts "\n\nOther Sections:\n\n"
        SECTIONS[4..SECTIONS.length - 1].each { |sec| puts "#{j}. #{sec.capitalize}"; j += 1 }
        puts "Which section would you like to view? (Input number of your choice)\n\n"; sleep(2)
    end

    def make_section_choice
        input = gets.to_i
        self.section = SECTIONS[input - 1]
        self.section_corrector
    end

    def section_corrector
        case @section
        when "u.s."
            self.section = 'us'
        when "NY Region"
            self.section = 'nyregion'
        when "Real Estate"
            self.section = 'realestate'
        when "Sunday Review"
            self.section = 'sundayreview'
        end
    end

    def json_data
        GetRequester.new(self.section).parse_json
    end


    def puts_headlines
        hl_enum = self.filter.enumerate(self.filter.create_headlines_array)
        hl_enum[range_min..range_max].each { |hl| puts "#{hl[0]}. #{hl[1]}"}
    end

    def display_first_headlines
        puts "\n\nHere are today's top 10 headlines in #{self.section.capitalize}: \n\n"
        self.puts_headlines
        puts "\n\nEnter the article number you'd like to explore, or type 'more' for more articles"
    end

    def headlines_decision_tree
        choice = gets.chomp
        if choice.to_i == 'more'

        elsif choice.to_i != 0
            self.filter.index = choice.to_i - 1
        else
            puts "I didn't understand your answer."
            range_min == 0 ? self.display_first_headlines : self.display_additional_headlines
        end
    end

    def display_additional_headlines
        puts "\n\nHere are the next ten headlines in #{self.section.capitalize}: \n\n"
        self.puts_headlines
        puts "\n\nEnter the article number you'd like to explore, or type 'more' for more articles"
    end


    def display_article_details
        article = self.filter.article
        puts "\n\nAlright. Here are some details on that article:\n\n"
        puts "Title: #{article['title']}"
        puts "Author: #{self.filter.author}"
        puts "Link: #{article['url']}"
        puts "Date published: #{article['published_date'][0..9]}"
        puts "Date updated: #{article['updated_date'][0..9]}"
    end

    def ask_to_link
        puts "Press l to link to article. Press e to exit. Press b to go back."
        choice = gets.chomp.downcase
        if choice == 'l'
            Launchy.open(self.filter.article['url'])
        elsif choice == 'e'
            self.program_exit
        elsif choice == 'b'
            self.first_ten_headlines
        end
    end

    def user_experience
        self.greeting
        self.make_section_choice
        self.json = GetRequester.new(self.section).parse_json
        self.filter = Filter.new(self.json)
        self.filter.interface = self
        self.headlines
        self.display_article_details
        self.ask_to_link
    end
    
    def program_exit
        puts "Goodbye."; sleep(1)
        exit
    end
end




