require_relative 'time_convertor'

class AppTimer

  attr_reader :response

  def call(env)
    request_handler(Rack::Request.new(env))
    @response
  end


  private

  def request_handler(request)

    if request.path_info != '/time'
      response(404, 'Check path you input')
    else
      @converted_time = TimeConvertor.new(request.params)
      @converted_time.call
      if @converted_time.success?
        response(200, @converted_time.time_by_pattern )
      else
        response(400, "Unknown format #{ @converted_time.format_error}")
      end
    end

  end

  def response(status, body)
    @response = [status, { 'Content-Type' => 'text/plain' } , [body]]
  end

end
