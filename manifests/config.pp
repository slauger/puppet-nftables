class nftables::config {
  file { '/etc/sysconfig/nftables.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp("${module_name}/etc/sysconfig/nftables.conf.epp"),
  }

  file { '/etc/nftables/main.nft':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => epp("${module_name}/etc/nftables/main.nft.epp", {
      'allow_local_rules' => $nftables::allow_local_rules,
    }),
  }

  file { '/etc/nftables/rules.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    ignore  => $nftables::rules_dir_ignore,
  }

  $nftables::rules.each | String $filename, Hash $content | {
    file { "/etc/nftables/rules.d/${filename}.nft":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => epp("${module_name}/etc/nftables/rules.nft.epp", {
        'tables' => $content,
      })
    }
  }
}
