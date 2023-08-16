
# module to validate JSON Files
module FileValidator

  # check if the file exist, if is not empty and if is a valid JSON file.
  # if all the check are ok, return the data in a hash, unless return an empty array
  def read_json_file(filename)
    return [] unless File.exist?(@filename)

    json_data = File.read(@filename)
    return [] if json_data.nil? || json_data.empty?
    
    data = JSON.parse(json_data, symbolize_names: true)
    return [] if data.nil? || data.empty?
      
    data
  end
end