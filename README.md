# nft

Puppet module for managing nftables firewall on a node.

## Example

```
nftables::rules:
  '100-basic':
    'table inet filter':
      'chain input':
        '000 - policy': 'type filter hook input priority 100; policy accept;'
        '110 - related and established': 'ct state established,related accept'
        '120 - icmp': 'ip protocol icmp accept'
        '130 - dhcp': 'udp dport { 67, 68 } ct state new accept'
        '140 - dns': 'udp dport 53 ct state new accept'
        '150 - ntp': 'udp dport 123 ct state new accept'
        '160 - ssh': 'tcp dport 22 ct state new accept'
      'chain output':
        '000 - policy': 'type filter hook output priority 100; policy accept;'
      'chain forward':
        '000 - policy': 'type filter hook forward priority 100; policy accept;'
  '999-reject':
    'table inet filter':
      'chain input':
        '999 - reject': 'reject with icmp type port-unreachable'
```

## Local rules

Sometimes you want to add local rules, which are not managed via puppet.

You can place local configuration files with the suffix `*.local.nft` in the directory `/etc/nftables/rules.d`.

The ignore pattern can be changed via `nftables::rules_dir_ignore` (defaults to `['*.local.nft']`.
