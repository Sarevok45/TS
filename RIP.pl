#!/usr/bin/perl -w
use strict;
use locale;

my %router_conf = (
    'R1' => [
        'ip link set dev eth1 up',
        'ip link set dev eth2 up',
        'ip addr add 10.0.1.1/24 dev eth0',
        'ip addr add 10.0.200.1/24 dev eth1',
        'ip addr add 192.168.0.1/24 dev eth2',
        'sysctl -w net.ipv4.ip_forward=1',
    ],
    
    'R2' => [
        'ip link set dev eth1 up',
        'ip link set dev eth2 up',
        'ip addr add 10.0.1.2/24 dev eth0',
        'ip addr add 10.0.30.1/24 dev eth1',
        'ip addr add 172.16.0.1/24 dev eth2',
        'sysctl -w net.ipv4.ip_forward=1'
    ],
    
    'R3' => [
        'ip link set dev eth1 up',
        'ip link set dev eth2 up',
        'ip addr add 10.0.200.2/24 dev eth0',
        'ip addr add 10.0.30.2/24 dev eth1',
        'ip addr add 192.168.100.1/24 dev eth2',
        'sysctl -w net.ipv4.ip_forward=1'
    ],
    
    'A1' => [
        'ip addr add 192.168.0.2/24 dev eth0',
        'ip route add default via 192.168.0.1'
    ],
    
    'B1' => [
        'ip addr add 172.16.0.2/24 dev eth0',
        'ip route add default via 172.16.0.1'
    ],
    
    'C1' => [
        'ip addr add 192.168.100.3/24 dev eth0',
        'ip route add default via 192.168.100.1'
    ]
);

die "Nie istnieje dany host\n" if !exists $router_conf{$ARGV[0]};
print "Rozpoczynam konfigurację....\n";

for( @{ $router_conf{ $ARGV[0] } } ) {
    system $_;
}

print "Zakończono\n";


