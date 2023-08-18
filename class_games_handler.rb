require 'json'
require_relative 'class_game'
require_relative 'class_authors_handler'
require_relative 'class_labels_handler'
require_relative 'class_genres_handler'
require_relative 'date_validator'
require_relative 'file_validator'

class GameHandler
  include DateValidator
  include FileValidator

  def initialize
    @games = []
    @filename = 'json_data/games.json'
  end

  def load_games()
    data = read_json_file(@filename)

    data.map do |game_data|
      genre = Genre.new(game_data[:genre][:name])
      genre.id = game_data[:genre][:id]
      label = Label.new(game_data[:label][:title], game_data[:label][:color])
      label.id = game_data[:label][:id]
      author = Author.new(game_data[:author][:first_name], game_data[:author][:last_name])
      author.id = game_data[:author][:id]

      game = Game.new(
        game_data[:genre],
        game_data[:author],
        game_data[:label],
        Date.parse(game_data[:publish_date])
      )
      game.id = game_data[:id]
      game.genre = genre
      game.label = label
      game.author = author
      game.multiplayer = game_data[:multiplayer]
      game.last_played_at = Date.parse(game_data[:last_played_at])
      game.archived = game_data[:archived]
      game
    end
  end

  def save_games(games)
    return if games.nil? || games.empty?

    game_data = games.map do |game|
      {
        id: game.id,
        genre: { id: game.genre.id, name: game.genre.name },
        label: { id: game.label.id, title: game.label.title, color: game.label.color },
        author: { id: game.author.id, first_name: game.author.first_name, last_name: game.author.last_name },
        publish_date: game.publish_date.to_s,
        multiplayer: game.multiplayer,
        last_played_at: game.last_played_at.to_s,
        archived: game.archived
      }
    end

    File.write(@filename, JSON.pretty_generate(game_data))
  end

  def input_new_game
    puts "### ADDING A NEW GAME ###\n"
    puts "Enter the following information:\n"

    genre_name = input_genre
    author_first_name, author_last_name = input_author
    title = input_label
    publish_date = invalid_date_then_today(input_publish_date)
    multiplayer = input_multiplayer
    last_played_at = invalid_date_then_today(input_last_played_date)

    if valid_input?(genre_name, author_first_name, title)
      genre = find_create_genre(genre_name)
      label = find_create_label(title, 'Game')
      author = find_create_author(author_first_name, author_last_name)
      game = create_game(genre, author, label, publish_date)
      game.multiplayer = %w[Y y].include?(multiplayer)
      game.last_played_at = last_played_at

      save_new_game(game)
    else
      puts 'Genre, author, and label are mandatory fields!'
      puts 'Game not added!'
    end
  end

  def input_genre
    print 'Genre:'
    gets.chomp
  end

  def input_author
    print 'Author (FirstName LastName):'
    author = gets.chomp.split
    [author[0], author[1] || '']
  end

  def input_label
    print 'Label / Title:'
    gets.chomp
  end

  def input_publish_date
    print 'Publish date:'
    gets.chomp
  end

  def input_multiplayer
    print 'Multiplayer (Y/N)?:'
    gets.chomp
  end

  def input_last_played_date
    print 'Last played date:'
    gets.chomp
  end

  def valid_input?(genre, author_first_name, label)
    !genre.empty? && !author_first_name.empty? && !label.empty?
  end

  def find_create_genre(name)
    genre_handler = GenreHandler.new
    genre_handler.find_create_genre(name)
  end

  def find_create_label(title, color)
    label_handler = LabelHandler.new
    label_handler.find_create_label(title, color)
  end

  def find_create_author(first_name, last_name)
    author_handler = AuthorHandler.new
    author_handler.find_create_author(first_name, last_name)
  end

  def create_game(genre, author, label, publish_date)
    Game.new(genre, author, label, publish_date)
  end

  def save_new_game(game)
    games = load_games
    games << game
    save_games(games)
    puts '\nGame added successfully!'
  end

  def list_games()
    games = load_games
    puts '------------------------------- LIST OF GAMES -------------------------------'
    puts 'ID  |        TITLE        |      GENRE      |  MULTIPLAYER  | PUBLISH DATE '
    games.each do |game|
      label_title = game.label.title.to_s
      genre = game.genre.name.to_s
      publish_date = game.publish_date.to_s
      multiplayer = game.multiplayer.to_s

      puts "#{game.id.to_s.ljust(4)}|#{label_title.ljust(20)} | #{genre.ljust(15)} |     #{multiplayer.ljust(5)}     | #{publish_date} "
    end
    puts '-----------------------------------------------------------------------------'
  end
end
