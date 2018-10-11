class App

  def call(env)
    @env = env
    formatter_caller
    [status, headers, body]
  end

  private

  def status
    @formatter.unknown_formats.any? ? 400 : @env['REQUEST_PATH'] == "/time" ? 200 : 404
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    result = []
    string_format = @env['QUERY_STRING'].split('=')

    if @formatter.unknown_formats.any?
      return ["Unknown time format(s): #{@formatter.unknown_formats}\n"]
    elsif string_format[0] == 'format' && status != 404
      @formatter.correct_formats.each { |f| result << Formatter.time_formats[f] }
      return result
    else
      return ["Bad request \n"]
    end
  end

  def formatter_caller
    string_format = @env['QUERY_STRING'].split('=')
    time_formats = string_format[1].split("%2C").uniq
    @formatter = Formatter.new(time_formats)
    @formatter.call
  end

end
