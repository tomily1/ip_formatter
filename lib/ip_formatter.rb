require 'pry'
require 'concerns/utitlity_methods.rb'
class IpFormatter
  include UtilityMethods
  attr_reader :data, :file_path, :result

  def initialize(file)
    @file_path = file
    @result = {}
  end

  def prepare_file
    if File.exists?(@file_path)
      data = File.open(@file_path, 'rb', &:read)
      result[:errors] = 'Invalid File format' if contain_letters?(data)
      @data = data.split("\n")
    else
      result[:errors] = 'File does not exist'
    end
  end

  def format_data
    return unless result[:errors].nil?
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
