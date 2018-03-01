module UtilityMethods
  def create_ip_key(ip)
    sub_address = sort_data(ip.split(":")[1].split(","))
    @result[ip.split(":")[0]] = ip.split(":")[0] + ":" + sub_address
  end
    
  def append_ip_data(ip)
    new_sub_address = ip.split(":")[1]
    old_sub_address = @result[ip.split(":")[0]].split(":")[1]
    append_sub_address = split_and_compare_data(old_sub_address, new_sub_address)
    sorted_sub_address = sort_data(append_sub_address)
    new_address = ip.split(":")[0] + ":" + sorted_sub_address
    @result[ip.split(":")[0]] = new_address
  end
  
  def sort_data(ip)
    ip.map(&:to_i).sort.join(",")
  end
  
  def split_and_compare_data(old_sub_address, new_sub_address)
    (old_sub_address.split(",") | new_sub_address.split(","))
  end
end
