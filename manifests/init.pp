class nftables (
  String $service_ensure,
  Boolean $service_enable,
  Hash $rules,
  Boolean $manage_firewalld,
  Boolean $manage_iptables,
  Array $rules_dir_ignore,
) {
  contain 'nftables::config'
  contain 'nftables::service'

  # disable and mask iptables
  if ($nftables::manage_iptables) {
    contain 'nftables::iptables'

    Class['nftables::iptables']
    ->Class['nftables::service']
  }

  # disable and mask firewalld
  if ($nftables::manage_firewalld) {
    contain 'nftables::firewalld'

    Class['nftables::firewalld']
    ->Class['nftables::service']
  }

  Class['nftables::config']
  ~>Class['nftables::service']
}
