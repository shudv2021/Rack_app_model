require_relative 'time_convertor'

class AppTimer

  def call(env)
    @request = Rack::Request.new(env)
    response
    [status, headers, body]
  end

  private

  def response
    return path_error if @request.path_info != '/time'

    @converted_time = TimeConvertor.new(@request.params).call
    return errors_in_request unless @converted_time.success?

    success_request
  end

  def status
    @status
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{@message}"]
  end

  def path_error
    @status = 404
    @message = 'Check path you input'
  end

  def errors_in_request
    @status_code = 400
    @message = "Unknown format #{ @converted_time.format_error}"
  end

  def success_request
    @status_code = 200
    @message = @converted_time.time
  end



end
