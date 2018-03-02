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
      create_ip(ip)
    end
  end

  def create_ip(ip)
    ip_data = ip.split(':')
    new_sub_address = ip_data[1]

    if @result[ip_data[0]].nil?
      create_ip_key(ip)
    else
      old_sub_address = @result[ip_data[0]].split(':')[1]
      append_ip_data(ip, new_sub_address, old_sub_address)
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
