require 'json'
require_relative 'author'

class AuthorHandler
  def initialize
    @authors = []
    @filename = 'json_data/authors.json'
  end

  def save_author(author)
    load_authors(@filename)
    @authors << author
    save_authors(@filename)
  end

  def load_authors()
    return unless File.exist?(@filename)

    json_data = File.read(@filename)
    author_data = JSON.parse(json_data, symbolize_names: true)

    @authors = author_data.map do |data|
      Author.new(data[:first_name], data[:last_name])
    end
  end

  def save_authors(authors)
    author_data = authors.map do |author|
      {
        first_name: author.first_name.strip.capitalize,
        last_name: author.last_name.strip.capitalize
      }
    end

    File.open(@filename, 'w') do |file|
      file.write(JSON.pretty_generate(author_data))
    end
  end

  def list_authors
    authors.each do |author|
      puts "First Name: #{author.first_name}"
      puts "Last Name: #{author.last_name}"
      puts "---------------------------------"
    end
  end

  # find if the author exits, otherwise create a new one
  def find_create_author(first_name, last_name)
    trimmed_first_name = first_name.strip.capitalize
    trimmed_last_name = last_name.strip.capitalize
  
    authors = load_authors() #load authors from json file
    
    existing_author = authors.find do |author|
      author_first_name = author.first_name.strip.capitalize
      author_last_name = author.last_name.strip.capitalize
      author_first_name == trimmed_first_name && author_last_name == trimmed_last_name
    end
  
    if existing_author.nil?
      author = Author.new(trimmed_first_name, trimmed_last_name)
      authors << author
      save_author(authors)
      author
    else
      existing_author
    end
  end

end
