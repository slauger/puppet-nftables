class nftables::service {
  service { 'nftables':
    ensure => $nftables::service_ensure,
    enable => $nftables::service_enable,
  }
}
