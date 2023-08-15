require 'json'
require_relative 'class_game'
require_relative 'authors_handler'
require_relative 'date_validator'

class GameHandler
  include DateValidator

  def initialize
    @games = []
    @filename = 'json_data/games.json'
  end

  def save_game(game)
    load_games(@filename)
    @games << game
    save_games(@filename)
  end

  def load_games()
    return unless File.exist?(@filename)

    json_data = File.read(@filename)
    game_data = JSON.parse(json_data, symbolize_names: true)

    @games = game_data.map do |data|
      Game.new(data[:genre], data[:author], data[:label], Date.parse(data[:publish_date]), data[:multiplayer], Date.parse(data[:last_played_at]))
        .tap { |game| game.archived = data[:archived] }
    end
  end

  def save_games()
    game_data = @games.map do |game|
      {
        id: game.id,
        genre: game.genre,
        author: "#{game.author.first_name} #{game.author.last_name}",
        label: game.label,
        publish_date: game.publish_date.to_s,
        archived: game.archived,
        multiplayer: game.multiplayer,
        last_played_at: game.last_played_at.to_s
      }
    end

    File.open(@filename, 'w') do |file|
      file.write(JSON.pretty_generate(game_data))
    end
  end

  def list_games
    @games.each do |game|
      puts "ID: #{game.id}"
      puts "Genre: #{game.genre}"
      puts "Author: #{game.author.first_name} #{game.author.last_name}"
      puts "Label: #{game.label}"
      puts "Publish Date: #{game.publish_date}"
      puts "Archived: #{game.archived}"
      puts "Multiplayer: #{game.multiplayer}"
      puts "Last Played Date: #{game.last_played_at}"
      puts "---------------------------------"
    end
  end

  def input_new_game
    puts 'What is the genre of the game?'
    genre = gets.chomp

    puts 'What is the author of the game (FirstName LastName)?'
    author = gets.chomp

    puts 'What is the label of the game?'
    label = gets.chomp

    puts 'What is the publish date of the game?'
    publish_date = gets.chomp

    puts 'Is the game multiplayer (Y/N)?'
    multiplayer = gets.chomp

    puts 'What is the last played date of the game?'
    last_played_at = gets.chomp

    # split author name into first and last name
    author = author.split(' ')
    author_first_name = author[0] 
    author_last_name = author[1] || ''
    
    # look if authors exits, otherwise create a new one
    author_handler = AuthorHandler.new
    author = author_handler.find_create_author(author_first_name, author_last_name)

    # validate publish_date and last_pleyed_date, if not valid, set to today
    publish_date = Date.today.to_s unless valid_date?(publish_date)
    last_played_at = Date.today.to_s unless valid_date?(last_played_at)

       # create new game
    game = Game.new(genre, author, label, publish_date, multiplayer == 'Y', last_played_at)
    game    
  end  
end
