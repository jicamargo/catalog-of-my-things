require 'json'
require_relative 'class_game'
require_relative 'class_authors_handler'
require_relative 'date_validator'

class GameHandler
  include DateValidator

  def initialize
    @games = []
    @filename = 'json_data/games.json'
  end

  def load_games()
    return [] unless File.exist?(@filename)
  
    json_data = File.read(@filename)
    data = JSON.parse(json_data, symbolize_names: true)
  
    # Return empty array if the json file is empty or is null
    return [] if data.nil? || data.empty?
  
    games = data.map do |game_data|
      author_data = game_data[:author]
      author_first_name = author_data[:first_name]
      author_last_name = author_data[:last_name]
      
      Game.new(
        game_data[:genre],
        Author.new(author_first_name, author_last_name),
        game_data[:label],
        Date.parse(game_data[:publish_date]),
        game_data[:multiplayer],
        Date.parse(game_data[:last_played_at])
      ).tap { |game| game.archived = game_data[:archived] }
    end
  end
  
  def save_games(games)
    return if games.nil? || games.empty?

    game_data = games.map do |game|
      {
        id: game.id,
        genre: game.genre,
        author: { first_name: game.author.first_name, last_name: game.author.last_name },
        label: game.label,
        publish_date: game.publish_date.to_s,
        multiplayer: game.multiplayer,
        last_played_at: game.last_played_at.to_s,
        archived: game.archived
      }
    end

    File.open(@filename, 'w') do |file|
      file.write(JSON.pretty_generate(game_data))
    end
  end

  def input_new_game
    puts "### ADDING A NEW GAME ###\n"
    puts "Enter the following information:\n"
    print 'Genre:'
    genre = gets.chomp

    print 'Author (FirstName LastName):'
    author = gets.chomp

    print 'Label:'
    label = gets.chomp

    print 'Publish date:'
    publish_date = gets.chomp

    print 'Multiplayer (Y/N)?:'
    multiplayer = gets.chomp

    print 'Last played date:'
    last_played_at = gets.chomp

    # split author name into first and last name
    author = author.split(' ')
    author_first_name = author[0] 
    author_last_name = author[1] || ''

    #validate entry data
    if genre.empty? || author_first_name.empty? || label.empty?
      puts 'Genre, author and label are mandatory fields!'
      puts 'Game not added!'
      return
    end

    # look if authors exits, otherwise create a new one
    author_handler = AuthorHandler.new
    author = author_handler.find_create_author(author_first_name, author_last_name)

    # validate publish_date and last_pleyed_date, if not valid, set to today
    publish_date = Date.today.to_s unless valid_date?(publish_date)
    last_played_at = Date.today.to_s unless valid_date?(last_played_at)

    # create new game
    game = Game.new(genre, author, label, publish_date, multiplayer == 'Y', last_played_at)

    save_game(game)
  end 
  
  def save_game(game)
    games = load_games()
    games << game
    save_games(games)
    puts '\nGame added successfully!'
  end
    
  def list_games()
    games = load_games()
    puts "--------------------- LIST OF GAMES ---------------------"
    games.each do |game|
      puts "ID: #{game.id}"
      puts "Genre: #{game.genre}"
      puts "Author: #{game.author.first_name} #{game.author.last_name}"
      puts "Label: #{game.label}"
      puts "Publish Date: #{game.publish_date}"
      puts "Archived: #{game.archived}"
      puts "Multiplayer: #{game.multiplayer}"
      puts "Last Played Date: #{game.last_played_at}"
      puts "---------------------------------------------------------"
    end
  end
end
