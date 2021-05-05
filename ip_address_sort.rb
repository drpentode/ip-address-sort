class IpAddressSort
  attr_accessor :ip_ranking
  attr_accessor :ip_addresses

  def initialize
    @ip_ranking = {}
    @ip_addresses = {}
  end

  def request_handled(ip_address)
    cnt = 1

    if @ip_addresses[ip_address]
      cnt = @ip_addresses[ip_address]
      cnt = cnt + 1
    end

    @ip_addresses[ip_address] = cnt

    top_100_counts = @ip_ranking.keys
    top_100_min_key = 0

    if top_100_counts.length > 100
      top_100_min_key = top_100_counts.min
      @ip_ranking.delete(top_100_min_key)
    end

    if cnt > top_100_min_key
      unless @ip_ranking[cnt] 
        @ip_ranking[cnt] = []
      end
      
      if @ip_ranking[cnt - 1]
        cnts = @ip_ranking[cnt - 1]
        cnts.delete(ip_address)
        @ip_ranking[cnt - 1] = cnts

        if @ip_ranking[cnt - 1].length == 0
          @ip_ranking.delete(cnt - 1)
        end
      end
    
      @ip_ranking[cnt].push(ip_address)
    end
  end

  def top100
    sorted_rankings = Hash[@ip_ranking.sort_by { |k, v| -k }]
  end

  def clear
    @ip_ranking = {}
    @ip_addresses = {}
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

100.times do
  10.times do
    random_ip_addresses.push("10.10.10.10")
  end

  9.times do
    random_ip_addresses.push("9.9.9.9")
  end

  8.times do
    random_ip_addresses.push("8.8.8.8")
  end

  7.times do
    random_ip_addresses.push("7.7.7.7")
  end

  6.times do
    random_ip_addresses.push("6.6.6.6")
  end

  5.times do
    random_ip_addresses.push("5.5.5.5")
  end

  4.times do
    random_ip_addresses.push("4.4.4.4")
  end

  3.times do
    random_ip_addresses.push("3.3.3.3")
  end

  2.times do
    random_ip_addresses.push("2.2.2.2")
  end
end

random_ip_addresses.each do |ip|
  ip_sorter.request_handled(ip)
end

puts ip_sorter.top100.inspect

ip_sorter.clear

puts ip_sorter.top100.inspect


