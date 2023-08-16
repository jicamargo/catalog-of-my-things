require 'json'
require_relative 'class_author'

class AuthorHandler
  def initialize
    @authors = []
    @filename = 'json_data/authors.json'
  end

  def load_authors()
    return [] unless File.exist?(@filename)

    json_data = File.read(@filename)
    author_data = JSON.parse(json_data, symbolize_names: true)

    # return empty array if the json file is empty or is null
    return [] if author_data.nil? || author_data.empty?
    
    authors = author_data.map do |data|
      Author.new(data[:first_name], data[:last_name])
    end
    authors
  end

  def save_authors(authors)
    return if authors.nil? || authors.empty?

    author_data = authors.map do |author|
      {
        id: author.id,
        first_name: author.first_name.strip.capitalize,
        last_name: author.last_name.strip.capitalize
      }
    end

    File.open(@filename, 'w') do |file|
      file.write(JSON.pretty_generate(author_data))
    end
  end

  def list_authors()
    authors = load_authors()
    puts "------------------ LIST OF AUTHORS ------------------"
    authors.each do |author|
      puts "First Name: #{author.first_name} Last Name: #{author.last_name}"
    end
    puts "------------------------------------------------------"
  end

  # find if the author exits, otherwise create a new one
  def find_create_author(first_name, last_name)
    trimmed_first_name = first_name.strip.capitalize
    trimmed_last_name = last_name.strip.capitalize

    authors = load_authors # load authors from json file

    existing_author = authors.find do |author|
      author_first_name = author.first_name.strip.capitalize
      author_last_name = author.last_name.strip.capitalize
      author_first_name == trimmed_first_name && author_last_name == trimmed_last_name
    end

    if existing_author.nil?
      author = Author.new(trimmed_first_name, trimmed_last_name)
      authors << author
      save_authors(authors)
      author
    else
      existing_author
    end
  end
end
