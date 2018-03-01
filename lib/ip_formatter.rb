require_relative './concerns/utitlity_methods.rb'
class IpFormatter
  include UtilityMethods
  attr_reader :data, :file_path, :result

  def initialize(file)
    @file_path = file
    @result = {}
  end

  def prepare_file
    if File.exist?(@file_path)
      data = File.open(@file_path, 'rb', &:read)
      result[:errors] = 'Invalid File format' if contain_letters?(data)
      @data = data.split("\n")
    else
      result[:errors] = 'File does not exist'
    end
  end

  def format_data
    return unless result[:errors].nil?
    @data.each do |ip|
      next if invalid_ip?(ip)
      ip_data = ip.split(':')

      if @result[ip_data[0]].nil?
        create_ip_key(ip)
      else
        append_ip_data(ip)
      end
    end
  end

  def display_result
    prepare_file
    format_data
    @result.values.sort
  end
end

unless ARGV[0].nil?
  formatter = IpFormatter.new(ARGV[0])
  p formatter.display_result
end
