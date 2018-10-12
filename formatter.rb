class Formatter

  attr_reader :unknown_formats, :correct_formats

  def initialize(params)
    @format_param = params[0]
    @time_formats = params[1].split("%2C").uniq
    @unknown_formats = []
    @correct_formats = []
  end

  TIME_FORMATS = { "year" => " %Y year",
                   "month" => "%m month",
                   "day" => " %e day ",
                   "hour" => " %H hour(s)",
                   "minute" => " %M minute(s)",
                   "second" => " %S second(s)" }

  def call
    @time_formats.each do |format|
      valid?(format) ? @correct_formats << format : @unknown_formats << format
    end
  end

  def output
    result = []
    if @unknown_formats.any?
      ["Unknown time format(s): #{@unknown_formats}\n"]
    elsif @format_param == 'format'
      @correct_formats.each { |f| result << Time.now.strftime(TIME_FORMATS[f]) }
      result << "\n"
    else
      ["Bad request. Wrong params. \n"]
    end
  end

  def valid?(format)
    TIME_FORMATS.key?(format)
  end

end