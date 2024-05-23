Facter.add('primary_network_interface') do
  confine :kernel => :Linux
  setcode do
    if Facter::Util::Resolution.which('ip')
      Facter::Util::Resolution.exec('ip route show default | grep ^default | awk \'{print $5}\' | head -n 1').strip
    end
  end
end
