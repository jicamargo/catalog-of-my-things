require 'date' # Make sure to require the date library

module DateValidator
  # verify if the date is valid, if not return false
  def valid_date?(date_string)
    Date.parse(date_string)
    true
  rescue ArgumentError
    false
  end

  # verify if the date is valid, if not return today's date
  def invalid_date_then_today(date_string)
    if valid_date?(date_string)
      Date.parse(date_string)
    else
      Date.today
    end
  end
end
