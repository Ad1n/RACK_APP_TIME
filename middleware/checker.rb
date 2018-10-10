# Now is only for check status code
class Checker

  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env
    string_format = @env['QUERY_STRING'].split('=')
    time_formats = string_format[1].split("%2C").uniq
    unknown_formats = time_formats - App::TIME_FORMATS.keys

    status, headers, body = @app.call(env)
    status = 400 unless unknown_formats.empty?
    [status, headers, body]
  end

end
