module IOHelpers
  def self.prompt(message)
    print "#{message} "
    gets.strip
  end

  def self.yes_no(message)
    yn = prompt(message)
    yn =~ /^y/i
  end
end
