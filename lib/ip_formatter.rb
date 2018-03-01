require 'concerns/utitlity_methods.rb'
class IpFormatter
  include UtilityMethods
  attr_reader :data, :file_name, :result

  def initialize(file)
    @file_name = file
    @result = {}
  end

  def prepare_file
    data = File.open(@file_name, 'rb', &:read)
    @data = data.split("\n")
  end

  def format_data
    @data.each do |data|
      ip_data = data.split(':')
      if @result[ip_data[0]].nil?
        create_ip_key(data)
      else
        append_ip_data(data)
      end
    end
  end

  def display_result
    prepare_file
    format_data
    @result.values
  end
end
