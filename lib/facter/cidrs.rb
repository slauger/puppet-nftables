Facter.add("cidrs") do
  setcode do
    cidrs = {}

    interfaces = Facter.value('networking.interfaces')
    
    interfaces.each do |interface_name, interface_params|
      if interface_params['physical']
        if interface_params.has_key?('netmask')
          octets = interface_params['netmask'].split('.').map(&:to_i)
          cidr = octets.map { |octet| octet.to_s(2).count('1') }.sum
          cidrs[interface_name] = interface_params["network"] + "/" + cidr.to_s
        end
      end
    end
    cidrs
  end
end
