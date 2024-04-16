class nftables::firewalld {
  service { 'firewalld':
    ensure => stopped,
    enable => 'mask',
  }
  Service['firewalld'] 
  ->Service['nftables']
}
