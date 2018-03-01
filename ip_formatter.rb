class IpFormatter
  attr_accessor :data, :file, :result
  
  def initialize(file)
    @file = file
    @result = {}
  end
  
  def prepare_file
    data = File.open(@file, 'rb') {|io| io.read }
    @data = data.split("\n")
  end
  
  def format_data
    @data.each do |data|
      ip_data = data.split(":")
      if @result[ip_data[0]].nil?
        create_ip_key(data)
      else
        append_ip_data(data)
      end
    end
  end

  def get_result
    prepare_file
    format_data
    @result.values
  end
  
  private

  def create_ip_key(data)
    sub_address = sort_data(data.split(":")[1].split(","))
    @result[data.split(":")[0]] = data.split(":")[0] + ":" + sub_address
  end
  
  def append_ip_data(data)
    new_sub_address = data.split(":")[1]
    old_sub_address = @result[data.split(":")[0]].split(":")[1]
    append_sub_address = split_and_compare_data(old_sub_address, new_sub_address)
    sorted_sub_address = sort_data(append_sub_address)
    new_address = data.split(":")[0] + ":" + sorted_sub_address
    @result[data.split(":")[0]] = new_address
  end

  def sort_data(data)
    data.map(&:to_i).sort.join(",")
  end

  def split_and_compare_data(old_sub_address, new_sub_address)
    (old_sub_address.split(",") | new_sub_address.split(","))
  end
end

p 'IP FORMATTER'
formatter = IpFormatter.new(ARGV[0])
p formatter.get_result