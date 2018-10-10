class App

  TIME_FORMATS = { "year" => Time.now.strftime(" %Y year"),
                   "month" => Time.now.strftime("%m month"),
                   "day" => Time.now.strftime(" %e day "),
                   "hour" => Time.now.strftime(" %H hour(s)"),
                   "minute" => Time.now.strftime(" %M minute(s)"),
                   "second" => Time.now.strftime(" %S second(s)") }.freeze

  def call(env)
    @env = env
    [status, headers, body]
  end

  private

  def status
    @env['REQUEST_PATH'] == "/time" ? 200 : 404
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    string_format = @env['QUERY_STRING'].split('=')
    time_formats = string_format[1].split("%2C").uniq
    unknown = []
    result = []

    time_formats.each do |format|
      if string_format[0] == 'format' && status != 404
         TIME_FORMATS.key?(format) ? result << TIME_FORMATS[format] : unknown << format
      else
        return ["Bad request \n"]
      end
    end
    unknown.empty? ? result << "\n" : ["Unknown time format(s): #{unknown}\n"]
  end

end
