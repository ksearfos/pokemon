module IOHelpers
  def self.prompt(message)
    print "#{message} "
    gets.strip
  end

  def self.yes_no(message)
    yn = prompt(message)
    yn =~ /^y/i
  end

  class Menu
    def initialize(message, options)
      @message = message
      @options = options
    end

    def display
      puts @message
      @options.each_with_index do |option, index|
        puts "#{index + 1} - #{option}"
      end
    end

    def choose
      display

      option = IOHelpers.prompt("Pick one:")
      @options.fetch(option.to_i - 1)
    end
  end
end
