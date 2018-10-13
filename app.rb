class App

  def call(env)
    @request = Rack::Request.new(env)
    format_check
    [status, headers, body]
  end

  private

  def status
    @formatter.unknown_formats.any? ? 400 : @request.path == "/time" ? 200 : 404
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    case status
    when 404
      ["Wrong path \n"]
    else
      @formatter.output
    end
  end

  def format_check
    @formatter = Formatter.new(@request.params)
    @formatter.call
  end

end
