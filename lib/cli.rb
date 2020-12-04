require_relative '../config/environment.rb'


class UserInterface

    attr_accessor :section, :filter, :json, :article_index

 
    SECTIONS = ['u.s.', 'world', 'opinion', 'politics', 'arts', 'automobiles', 'books', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'NY Region', 'obituaries', 'Real Estate', 'science', 'sports', 'Sunday Review', 'technology', 'theater', 't-magazine', 'travel', 'upshot']

        
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
        puts "Which section would you like to view? (Input number of your choice)\n\n"; sleep(2)
        i, j = 1, 5
        puts "Popular Sections:\n\n"
        SECTIONS[0..3].each { |sec| puts "#{i}. #{sec.capitalize}"; i += 1 }
        puts "\n\nOther Sections:\n\n"
        SECTIONS[4..SECTIONS.length - 1].each { |sec| puts "#{j}. #{sec.capitalize}"; j += 1 }
    end

    def make_section_choice
        self.display_section_choices
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

    def first_ten_headlines
        puts "\n\nHere are today's top 10 headlines in #{self.section.capitalize}: \n\n"
        self.filter.headlines_array_enumerated_puts(0..9)
        puts "\n\nEnter the article number you'd like to explore, or type 'more' for more headlines"

    def see_more_headlines
        range_min, range_max = 0, 9
        while !self.article_index
            choice = gets.chomp
            if choice == 'more' && self.filter.num_headlines > range_max + 10
                range_min += 10; range_max += 10
                self.filter.headlines_array_enumerated_puts(range_min..range_max)
                puts "\n\nEnter the article number you'd like to explore, or type 'more' for more headlines"
            elsif choice == 'more' && self.filter.num_headlines <= range_max + 10
                range_min += ((num_headlines - 1) - range_max)
                range_max = num_headlines - 1
                self.filter.headlines_array_enumerated_puts(range_min..range_max)
            else
                self.article_index = choice.to_i - 1
            end
        end
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
        puts "Would you like to link to this article? (y/n). Press e to exit"
        choice = gets.chomp.downcase
        if choice == 'y'
            Launchy.open(self.filter.article['url'])
        elsif choice == 'e'
            self.program_exit
        else
            self.display_article_details
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




