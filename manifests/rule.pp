define nftables::rule (
  String $rule_name = $title,
  String $content,
) {
  file { "/etc/nftables/rules.d/${rule_name}.nft":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => epp("${module_name}/etc/nftables/rules.nft.epp", {
      'tables' => $content,
    })
  }
}
