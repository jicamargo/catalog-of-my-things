require 'json'
require_relative 'class_author'

class AuthorHandler
  def initialize
    @authors = []
    @filename = 'json_data/authors.json'
  end

  def load_authors()
    puts "passing 0"
    return [] unless File.exist?(@filename)

    json_data = File.read(@filename)
    puts "passing 1"

    author_data = JSON.parse(json_data, symbolize_names: true)
    # return empty array if the json file is empty or is null

    puts "passing 2"
    return [] if author_data.nil? || author_data.empty?
    
    puts "passing 3"

    @authors = author_data.map do |data|
      Author.new(data[:first_name], data[:last_name])
    end
  end

  def save_authors(authors)
    author_data = authors.map do |author|
      {
        id: author.id,
        first_name: author.first_name.strip.capitalize,
        last_name: author.last_name.strip.capitalize
      }
    end

    puts "author data: #{author_data}"
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
    puts("first name: #{first_name}, last name: #{last_name}"
    )
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
      puts "new author: #{author}"
      puts "authors:" 
      print authors
      save_authors(authors)
      author
    else
      puts "existing author:"
      print existing_author
      existing_author
    end
  end

end
