class nftables::iptables {
  service { 'iptables':
    ensure => stopped,
    enable => 'mask',
  }
  Service['iptables']
  ->Service['nftables']
}
