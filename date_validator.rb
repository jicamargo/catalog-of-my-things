require 'date'  # Make sure to require the date library

module DateValidator
  def valid_date?(date_string)
    Date.parse(date_string)
    true
  rescue ArgumentError
    false
  end
end
