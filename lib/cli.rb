require_relative '../config/environment.rb'


class UserInterface

    attr_accessor :section, :filter, :range_min, :range_max, :morn_end, :aft_end, :t

 
    SECTIONS = ['u.s.', 'world', 'opinion', 'politics', 'arts', 'automobiles', 'books', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'NY Region', 'obituaries', 'Real Estate', 'science', 'sports', 'Sunday Review', 'technology', 'theater', 't-magazine', 'travel', 'upshot']
        
    def initialize
        @range_min, @range_max = 0, 9
    end

    def time
        @t = Time.now
        today_date = [t.year, t.month, t.day]
        @morn_end, @aft_end = Time.new(*today_date, 12, 0, 0), Time.new(*today_date, 18, 0, 0)
    end
    
    def greeting
        self.time
        print "\n\n\n"
        if @t < @morn_end
            print "Good morning. "
        elsif @t > @aft_end
            print "Good evening. "
        else
            print "Good afternoon. "
        end
        puts "Let's get started with today's headlines.\n\n"; sleep(2)
        self.display_section_choices
    end

    def display_section_choices
        i = 1
        puts "Popular Sections:\n\n"
        SECTIONS[0..3].each { |sec| puts "#{i}. #{sec.capitalize}"; i += 1 }
        puts "\n\nOther Sections:\n\n"
        SECTIONS[4..SECTIONS.length - 1].each { |sec| puts "#{i}. #{sec.capitalize}"; i += 1 }
        puts "\n\nWhich section would you like to view? (Input number of your choice)\n\n"; sleep(2)
        self.make_section_choice
    end

    def make_section_choice
        input = gets.to_i
        self.section_corrected(input)
        self.create_filter_object
        self.display_headlines
    end

    def section_corrected(input)
        self.section = SECTIONS[input - 1]
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

    def create_filter_object
        json = GetRequester.new(self.section).parse_json
        self.filter = Filter.new(json)
        self.filter.interface = self
    end


    def puts_headlines
        hl_enum = self.filter.enumerate(self.filter.create_headlines_array)
        hl_enum[range_min..range_max].each { |hl| puts "#{hl[0]}. #{hl[1]}"}
    end

    def display_headlines
        puts "\n\nHere are today's headlines in #{self.section.capitalize}: \n\n"
        self.puts_headlines
        puts "\n\nEnter an article number, or type 'more' for more articles. Type b to go back.\n\n"
        self.hl_decision_tree
    end

    def hl_decision_tree
        choice = gets.chomp
        if choice.downcase == 'more' && @range_max + 10 < self.filter.num_headlines
            @range_min += 10; @range_max += 10
            self.display_headlines
        elsif choice.downcase == 'more' && @range_max + 10 >= self.filter.num_headlines
            @range_min = self.filter.num_headlines - 10; @range_max = self.filter.num_headlines
            puts "\n\nThese are the last headlines."; sleep(1)
            self.display_headlines
        elsif choice.to_i != 0
            self.choose_article(choice)
        elsif choice.downcase == 'b'
            self.display_section_choices
        else
            self.invalid_choice('display_headlines')
        end
    end

    def choose_article(choice)
        self.filter.index = choice.to_i - 1
        self.display_article_details
    end

    def invalid_choice(call_this_method)
        puts "\n\nI couldn't understand your answer"; sleep(1)
        self.send(call_this_method)
    end

    def display_article_details
        article = self.filter.article
        puts "\n\nAlright. Here are some details on that article:\n\n"
        puts "Title: #{article['title']}"
        puts "Author: #{self.filter.author}"
        puts "Summary: #{article['abstract']}"
        puts "Date published: #{article['published_date'][0..9]}"
        puts "Link: #{article['url']}"
        self.link_decision_tree
    end

    def link_decision_tree
        puts "\n\nPress l to link to article. Press b to go back. Press e to exit."
        choice = gets.chomp.downcase
        if choice == 'l'
            Launchy.open(self.filter.article['url'])
            self.display_headlines
        elsif choice == 'b'
            self.display_headlines
        elsif choice == 'e'
            self.program_exit
        else
            self.invalid_choice('link_decision_tree')
        end
    end

    def run
        self.greeting
    end
    
    def program_exit
        puts "Goodbye."; sleep(1)
        exit
    end
end




