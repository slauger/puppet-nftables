Facter.add('primary_network_cidr') do
  confine :kernel => :Linux
  setcode do
    if Facter::Util::Resolution.which('ip')
      primary_interface = Facter::Util::Resolution.exec('ip route show default | grep ^default | awk \'{print $5}\' | head -n 1').strip
      interfaces = Facter.value('networking.interfaces')
      octets = interfaces[primary_interface]['netmask'].split('.').map(&:to_i)
      cidr = octets.map { |octet| octet.to_s(2).count('1') }.sum
      interfaces[primary_interface]["network"] + "/" + cidr.to_s
    end
  end
end
