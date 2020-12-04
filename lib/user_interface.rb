require_relative '../config/environment.rb'


class UserInterface

    attr_accessor :section, :my_filter, :my_json

 
    SECTIONS = ['U.S.', 'world', 'opinion', 'politics', 'arts', 'automobiles', 'books', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'NY Region', 'obituaries', 'Real Estate', 'science', 'sports', 'Sunday Review', 'technology', 'theater', 't-magazine', 'travel', 'upshot']

    def initialize
    end
        
    def greeting
        t = Time.now
        today_date = [t.year, t.month, t.day]
        morning_cutoff = Time.new(*today_date, 12, 0, 0)
        evening_cutoff = Time.new(*today_date, 18, 0, 0)
        if t < morning_cutoff
            print "Good morning. "
        elsif t > evening_cutoff
            print "Good evening. "
        else
            print "Good afternoon. "
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
        when "U.s."
            self.section = 'us'
        when "NY Region"
            self.section = 'nyregion'
        when "Real Estate"
            self.section = 'realestate'
        when "Sunday Review"
            self.section = 'sundayreview'
        end
    end

    def user_experience
        self.greeting
        self.make_section_choice
        self.my_json = GetRequester(self.section)
        self.my_filter = Filter.new(self.my_json)
        self.headlines

    end

    def headlines
        puts "Here are today's headlines in #{self.section.capitalize}"
        self.my_filter.return_section_headlines

    end



end

