module UtilityMethods
  def create_ip_key(ip)
    sub_address = sort_data(ip.split(':')[1].split(','))
    @result[ip.split(':')[0]] = ip.split(':')[0] + ':' + sub_address
  end

  def append_ip_data(ip, new_sub_address, old_sub_address)
    @result[ip.split(':')[0]] = full_address(
      ip.split(':')[0],
      old_sub_address,
      new_sub_address
    )
  end

  def full_address(ip, old_sub_address, new_sub_address)
    append_sub_address = split_and_compare_data(
      old_sub_address,
      new_sub_address
    )
    sorted_sub_address = sort_data(append_sub_address)
    "#{ip}:#{sorted_sub_address}"
  end

  def sort_data(ip)
    ip.map(&:to_i).sort.join(',')
  end

  def split_and_compare_data(old_sub_address, new_sub_address)
    (old_sub_address.split(',') | new_sub_address.split(','))
  end

  def contain_letters?(data)
    data =~ /[A-Za-z]/ ? true : false
  end

  def invalid_ip?(ip)
    return false unless ip.split(':').count == 1
    @result[:error] = 'file contains IP(s) that are not formatted properly'
    true
  end
end
