Facter.add("cidrs") do
  setcode do
    cidrs = {}

    interfaces = Facter.value('networking.interfaces')
    
    interfaces.each do |interface_name, interface_params|
      puts interface_name
      if interface_params['physical']
        octets = interface_params['netmask'].split('.').map(&:to_i)
        cidr = octets.map { |octet| octet.to_s(2).count('1') }.sum
        cidrs[interface_name] = interface_params["network"] + "/" + cidr.to_s
      end
    end
    cidrs
  end
end
