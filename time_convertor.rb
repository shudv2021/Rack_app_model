class TimeConvertor

  TRANSFORMATION_PATTERN = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H', 'minute' => '%m',
                             'second' => '%S' }.freeze

  attr_reader :format_errors

  def initialize(params)
    @params = params
    @format_errors = []
    @valid_params = []
  end

  def call
    @params.each do |param|
     TRANSFORMATION_PATTERN.key?(param) ? @valid_params << TRANSFORMATION_PATTERN[param] : @format_errors << param
    end
  end

  def success?
    @format_errors.empty?
  end

  def time_by_pattern
    Time.now.strftime(@valid_params.join('-'))
  end

  def format_error
    @format_errors
  end

end
