class Formatter

  attr_reader :unknown_formats, :correct_formats

  def initialize(params)
    @format_params = params
    @unknown_formats = []
    @correct_formats = []
  end

  TIME_FORMATS = { "year" => " %Y year",
                   "month" => "%m month",
                   "day" => " %e day ",
                   "hour" => " %H hour(s)",
                   "minute" => " %M minute(s)",
                   "second" => " %S second(s)" }.freeze

  def call
    @format_params["format"]&.split(",")&.uniq&.each do |format|
      valid?(format) ? @correct_formats << format : @unknown_formats << format
    end
  end

  def output
    if @unknown_formats.any?
      ["Unknown time format(s): #{@unknown_formats}\n"]
    elsif @format_params.key?("format")
      @correct_formats.map { |f| Time.now.strftime(TIME_FORMATS[f]) }
    else
      ["Bad request. Wrong params. \n"]
    end
  end

  def valid?(format)
    TIME_FORMATS.key?(format)
  end

end
