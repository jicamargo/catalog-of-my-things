require 'json'
require_relative 'class_author'
require_relative 'file_validator'

class AuthorHandler
  include FileValidator

  def initialize
    @filename = 'json_data/authors.json'
  end

  def load_authors()
    data = read_json_file(@filename)
    data.map { |author_data| Author.new(author_data[:first_name], author_data[:last_name]) }
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

    File.write(@filename, JSON.pretty_generate(author_data))
  end

  def list_authors()
    authors = load_authors
    puts '------------------ LIST OF AUTHORS ------------------'
    authors.each do |author|
      puts "First Name: #{author.first_name} Last Name: #{author.last_name}"
    end
    puts '------------------------------------------------------'
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
