require_relative 'games_handler'
require_relative 'authors_handler'
require 'date'  

# Example usage:
game_handler = GameHandler.new
author_handler = AuthorHandler.new


game_handler.input_new_game()
game_handler.load_games()
game_handler.list_games
