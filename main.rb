# main.rb file

require_relative 'app'
def main
  app = App.new
  app.load_genres_json
  app.load_albums_json
  app.run
end

main
