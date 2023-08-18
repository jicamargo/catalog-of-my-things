require 'json'
require_relative 'class_label'
require_relative 'file_validator'

class LabelHandler
  include FileValidator

  def initialize
    @filename = 'json_data/labels.json'
  end

  def load_labels()
    data = read_json_file(@filename)
    data.map { |label_data| Label.new(label_data[:title], label_data[:color]) }
  end

  def save_labels(labels)
    return if labels.nil? || labels.empty?

    label_data = labels.map do |label|
      {
        id: label.id,
        title: label.title.strip.capitalize,
        color: label.color.strip.capitalize
      }
    end

    File.write(@filename, JSON.pretty_generate(label_data))
  end

  def list_labels()
    labels = load_labels
    puts '------------------ LIST OF LABELS ------------------'
    labels.each do |label|
      title = label.title.strip.capitalize
      color = label.color.strip.capitalize
      puts "Title: #{title.ljust(20)}    Color: #{color}"
    end
    puts '-----------------------------------------------------'
  end

  # find if the label exits, otherwise create a new one
  def find_create_label(title = '', color = '')
    trimmed_title = title.strip.capitalize
    trimmed_color = color.strip.capitalize

    labels = load_labels # load labels from json file

    existing_label = labels.find do |label|
      label_title = label.title.strip.capitalize
      label_color = label.color.strip.capitalize
      label_title == trimmed_title && label_color == trimmed_color
    end

    if existing_label.nil?
      label = Label.new(trimmed_title, trimmed_color)
      labels << label
      save_labels(labels)
      label
    else
      existing_label
    end
  end
end
