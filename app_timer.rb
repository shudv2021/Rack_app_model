require_relative 'time_convertor'
class AppTimer

  def call(env)
    request_handler(Rack::Request.new(env))
  end

  private

  def request_handler(request)
    return response(404, 'Check path you input') unless request.path_info == '/time'
    converted_time = TimeConvertor.new(request.params)
    converted_time.call
    response(400,"Unknown format #{ converted_time.format_error}") unless converted_time.success?
    response(200, "#{converted_time.time_by_pattern}" ) if converted_time.success?
  end

  def response(status, body)
    Rack::Response.new([body], status, { 'Content-Type' => 'text/plain' }).finish
  end

end
  
