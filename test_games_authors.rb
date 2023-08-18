# temporal main file to test the classes

require_relative 'class_games_handler'
require_relative 'class_author'

author_handler = AuthorHandler.new
game_handler = GameHandler.new
game_handler.input_new_game
game_handler.list_games
author_handler.list_authors
