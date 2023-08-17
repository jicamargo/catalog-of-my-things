require 'colorize'

# This class represents the main application for the Catalog of my things App.
module MessageOutputs
  def greetings
    puts '________________________________________________'.colorize(color: :green)
    puts '    Welcome to our Catalog of my things App'.colorize(color: :green).bold
    puts '________________________________________________'.colorize(color: :green)
  end

  def options
    options = ['',
               '     1) - List all books',
               '     2) - List all music albums',
               '     3) - List all games',
               '     4) - List all genres',
               '     5) - List all labels',
               '     6) - List all authors',
               '     7) - Add a book',
               '     8) - Add a music album',
               '     9) - Add a game',
               '    10) - Exit'.colorize(color: :red).bold,
               '']
    puts "\nPlease choose an option by entering a number:".underline.colorize(color: :green)
    puts options
    print 'Option: '.colorize(color: :green)
    gets.chomp.to_i
  end

  def goodbye
    puts 'Goodbye and thanks for using Catalog of my things App!'
  end
end
