require_relative 'Game'  # Adjust the path as needed
require 'date'  # For working with dates
require 'games_handler' # For saving games into JSON file

# Create a new Game instance
new_game = Game.new(genre, author_first_name, author_last_name, label, publish_date, multiplayer, last_played_at)

# Save the new game into JSON file
filename = 'games.json'
games_handler.save_games(games, filename)
games_handler.list_games(games)


puts "New game added successfully!"
