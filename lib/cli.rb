require_relative '../config/environment.rb'


class UserInterface

    attr_accessor :section, :my_filter, :my_json, :article_selection_index

 
    SECTIONS = ['u.s.', 'world', 'opinion', 'politics', 'arts', 'automobiles', 'books', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'NY Region', 'obituaries', 'Real Estate', 'science', 'sports', 'Sunday Review', 'technology', 'theater', 't-magazine', 'travel', 'upshot']

    def initialize
    end
        
    def greeting
        t = Time.now
        today_date = [t.year, t.month, t.day]
        morning_cutoff = Time.new(*today_date, 12, 0, 0)
        evening_cutoff = Time.new(*today_date, 18, 0, 0)
        if t < morning_cutoff
            print "\n\n\nGood morning. "
        elsif t > evening_cutoff
            print "\n\n\nGood evening. "
        else
            print "\n\n\nGood afternoon. "
        end
        puts "Let's get started with today's headlines.\n\n"
    end

    def display_section_choices
        puts "Which section would you like to view? (Input number of your choice)\n\n"
        puts "Popular Sections:\n\n\n"
        i = 1
        SECTIONS[0..3].each do |sec|
            puts "#{i}. #{sec.capitalize}"
            i += 1
        end
        puts "\n\nOther Sections:\n"
        j = 5
        SECTIONS[4..SECTIONS.length - 1].each do |sec|
            puts "#{j}. #{sec.capitalize}"
            j += 1
        end
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

    def headlines
        range_min = 0
        range_max = 9
        puts "\n\nHere are today's top 10 headlines in #{self.section.capitalize}: \n\n"
        self.my_filter.headlines_array_enumerated_puts(range_min..range_max)
        puts "\n\nEnter the article number you'd like to explore, or type 'more' for more headlines"
        while !self.article_selection_index
            choice = gets.chomp
            if choice == 'more' && self.my_filter.num_headlines > range_max + 10
                range_min += 10
                range_max += 10
                self.my_filter.headlines_array_enumerated_puts(range_min..range_max)
                puts "\n\nEnter the article number you'd like to explore, or type 'more' for more headlines"
            elsif choice == 'more' && self.my_filter.num_headlines <= range_max + 10
                range_min += ((num_headlines - 1) - range_max)
                range_max = num_headlines - 1
                self.my_filter.headlines_array_enumerated_puts(range_min..range_max)
            else
                self.article_selection_index = choice.to_i - 1
            end
        end

    end

    def display_article_details
        article = my_filter.article
        puts "\n\nAlright. Here are some details on that article:\n\n"
        puts "Title: #{article['title']}"
        puts "Author: #{self.my_filter.author}"
        puts "Link: #{article['url']}"
        puts "Date published: #{article['published_date'][0..9]}"
        puts "Date updated: #{article['updated_date'][0..9]}"
    end

    def ask_to_link
        puts "Would you like to link to this article? (y/n)"
        choice = gets.chomp.downcase
        if choice == 'y'
            Launchy.open(my_filter.article['url'])
        else
            self.display_article_details
        end
    end

    def user_experience
        self.greeting
        self.make_section_choice
        self.my_json = GetRequester.new(self.section).parse_json
        self.my_filter = Filter.new(self.my_json)
        self.my_filter.my_interface = self
        self.headlines
        self.display_article_details
        self.ask_to_link

    end

    





end




