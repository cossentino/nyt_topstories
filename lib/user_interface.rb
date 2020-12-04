require_relative '../config/environment.rb'


class UserInterface

    POP_SECTIONS =
    SECTIONS = ['us', 'world', 'opinion', 'politics', 'arts', 'automobiles', 'books', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'nyregion', 'obituaries', 'realestate', 'science', 'sports', 'sundayreview', 'technology', 'theater', 't-magazine', 'travel', 'upshot']

    def initialize
    end
        
    def greeting
        t = Time.now
        today_date = [t.year, t.month, t.day]
        morning_cutoff = Time.new(*today_date, 12, 0, 0)
        evening_cutoff = Time.new(*today_date, 18, 0, 0)
        if t < morning_cutoff
            print "Good morning."
        elsif t > evening_cutoff
            print "Good evening."
        else
            print "Good afternoon."
        end
        puts "Let's get started with today's headlines.\n\n"
    end

    def display_section_choices
        puts "Which section would you like to view? (Input number of your choice)\n\n"
        puts "Popular Sections:\n\n\n"
        puts "1. U.S."
        i = 2
        SECTIONS[1..3].each do |sec|
            puts "#{i}. #{sec.capitalize}"
            i += 1
        end
        puts "Other Sections:\n\n\n"
        j = 5
        SECTIONS[4..SECTIONS.length - 1].each do |sec|
            puts "#{j}. #{sec.capitalize}"
            j += 1
        end
    end

    def make_section_choice
        self.display_section_choices
        []



end
