class Formatter

  attr_reader :unknown_formats, :correct_formats

  def initialize(formats)
    @formats = formats
    @unknown_formats = []
    @correct_formats = []
  end

  def self.time_formats
    { "year" => Time.now.strftime(" %Y year"),
      "month" => Time.now.strftime("%m month"),
      "day" => Time.now.strftime(" %e day "),
      "hour" => Time.now.strftime(" %H hour(s)"),
      "minute" => Time.now.strftime(" %M minute(s)"),
      "second" => Time.now.strftime(" %S second(s)") }
  end

  def call
    @formats.each do |format|
      valid?(format) ? @correct_formats << format : @unknown_formats << format
    end
  end

  def valid?(format)
    Formatter.time_formats.key?(format)
  end

end