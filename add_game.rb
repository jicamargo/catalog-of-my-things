require_relative 'Game'  # Adjust the path as needed
require 'date'  # For working with dates
require 'games_handler' # For saving games into JSON file

# Collect input from the user
puts "Enter game details:"
print "Genre: "
genre = gets.chomp
print "Author Fisrt Name: "
author_first_name = gets.chomp
print "Author Last Name: "
author_last_name = gets.chomp
print "Label: "
label = gets.chomp
print "Publish Date (YYYY-MM-DD): "
publish_date = Date.parse(gets.chomp)
print "Multiplayer (true/false): "
multiplayer = gets.chomp.downcase == 'true'
print "Last Played Date (YYYY-MM-DD): "
last_played_at = Date.parse(gets.chomp)


# look if authors exits, otherwise create a new one
 
# Create a new Game instance
new_game = Game.new(genre, author_first_name, author_last_name, label, publish_date, multiplayer, last_played_at)

# Save the new game into JSON file
filename = 'games.json'
games_handler.save_games(games, filename)
games_handler.list_games(games)



puts "New game added successfully!"
