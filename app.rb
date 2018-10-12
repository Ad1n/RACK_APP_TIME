class App

  def call(env)
    @env = Rack::Request.new(env)
    format_check
    [status, headers, body]
  end

  private

  def status
    @formatter.unknown_formats.any? ? 400 : @env.path == "/time" ? 200 : 404
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    status == 404 ? ["Wrong path \n"] : @formatter.output
  end

  def format_check
    string_format = @env.query_string.split('=')
    @formatter = Formatter.new(string_format)
    @formatter.call
  end

end
