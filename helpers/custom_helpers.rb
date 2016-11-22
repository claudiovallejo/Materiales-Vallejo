module CustomHelpers
  # Pretty URL: Transforms 'José Martí' -> 'jose-marti'
  def pretty_url string
    url = I18n.transliterate(string).downcase.strip.gsub(' ', '-')
  end
  # Pretty Number: Transforms '(81) 8363 2324' -> '8183632324'
  def pretty_number telephone
    number = telephone.gsub(' ', '').gsub('(', '').gsub(')', '')
  end
  # Pretty Hour: Transforms '8' -> '8:00am' and '18.25' a '6:15pm'
  def pretty_hour number
    time = "Cómprate un reloj!"
    hour = number.floor
    minutes = number - hour
    time_zone = "am"
    if hour > 12
      hour -= 12
      time_zone = "pm"
    end
    time = "#{hour}:"
    minutes *= 60
    if (minutes.floor) == 0
      time += "00"
    elsif 0 < minutes && minutes < 10
      time += "0#{minutes}"
    else
      time += "#{minutes.floor}"
    end
    time += "#{time_zone}"
  end
end
