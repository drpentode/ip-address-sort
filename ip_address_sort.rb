class IpAddressSort
  attr_accessor :ip_ranking

  def initialize
    @ip_ranking = {}
  end

  def request_handled(ip_address)
    val = 1

    if @ip_ranking[val]
      if @ip_ranking[val - 1]
        @ip_ranking[val - 1].delete(ip_address)
      end
    else 
      @ip_ranking[val] = []
    end
      
    @ip_ranking[val].push(ip_address)
  end

  def top100
    rankings = @ip_ranking.keys.sort do |a, b|
      b <=> a
    end

    key_rankings_100 = rankings[0..99]
    ip_rankings = []

    key_rankings_100.each do |ranking|
      if ip_rankings.length <= 100 # skip all this logic if ip_rankings already has 100
        ips = @ip_ranking[ranking]
        ips.each do |ip|
          if ip_rankings.length <= 100 # because we are adding groups of IPs, if a set of IPs pushes the array over 100, we need to stop
            ip_rankings.push(ip)
          end
        end
      end
    end

    return ip_rankings
  end

  def clear
    @ip_ranking = {}
  end
end

ip_sorter = IpAddressSort.new

random_ip_addresses = []

1000.times do
  ip_1 = rand(1..255).to_s
  ip_2 = rand(0..255).to_s
  ip_3 = rand(0..255).to_s
  ip_4 = rand(0..255).to_s

  random_ip_addresses.push("#{ip_1}.#{ip_2}.#{ip_3}.#{ip_4}")
end

random_ip_addresses.each do |ip|
  ip_sorter.request_handled(ip)
end

puts ip_sorter.ip_addresses.inspect
puts ip_sorter.top100.inspect

ip_sorter.clear

puts ip_sorter.ip_addresses.inspect
puts ip_sorter.top100.inspect

