From: Denis Vlasenko <vda@...216...>
MIME-Version: 1.0
Message-Id: <200405161143.42983.vda@...216...>
Subject: [Openvpn-devel] openvpn-2.0_beta1: tunnel MTU a bit too large
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun May 16 01:45:01 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

# dd if=/dev/zero count=1 bs=7000 | nc -nuvvv -w1 1.1.5.5 284

over tunnel:
11:09:20.930621 > 0800 1468: IP (tos 0x0, ttl  64, id 46021, offset 0, flags [+], length: 1452) 1.1.5.6.1025 > 1.1.5.5.284: [bad udp cksum c815!] UDP, length: 7000
11:09:20.930657 > 0800 1468: IP (tos 0x0, ttl  64, id 46021, offset 1432, flags [+], length: 1452) 1.1.5.6 > 1.1.5.5: udp
11:09:20.930681 > 0800 1468: IP (tos 0x0, ttl  64, id 46021, offset 2864, flags [+], length: 1452) 1.1.5.6 > 1.1.5.5: udp
11:09:20.930706 > 0800 1468: IP (tos 0x0, ttl  64, id 46021, offset 4296, flags [+], length: 1452) 1.1.5.6 > 1.1.5.5: udp
11:09:20.930752 > 0800 1316: IP (tos 0x0, ttl  64, id 46021, offset 5728, flags [none], length: 1300) 1.1.5.6 > 1.1.5.5: udp

i.e. it is fragmented. This is okay.

over wire:
11:09:20.931947 IP (tos 0x0, ttl  64, id 6593, offset 0, flags [+], length: 1500) 1.1.4.6.8006 > 1.1.4.1.8006: [bad udp cksum 5902!] UDP, length: 1492
11:09:20.931976 IP (tos 0x0, ttl  64, id 6593, offset 1480, flags [none], length: 40) 1.1.4.6 > 1.1.4.1: udp
11:09:20.932157 IP (tos 0x0, ttl  64, id 6594, offset 0, flags [+], length: 1500) 1.1.4.6.8006 > 1.1.4.1.8006: [bad udp cksum c71!] UDP, length: 1492
11:09:20.932174 IP (tos 0x0, ttl  64, id 6594, offset 1480, flags [none], length: 40) 1.1.4.6 > 1.1.4.1: udp
11:09:20.932343 IP (tos 0x0, ttl  64, id 6595, offset 0, flags [+], length: 1500) 1.1.4.6.8006 > 1.1.4.1.8006: [bad udp cksum dd63!] UDP, length: 1492
11:09:20.932405 IP (tos 0x0, ttl  64, id 6595, offset 1480, flags [none], length: 40) 1.1.4.6 > 1.1.4.1: udp
11:09:20.932563 IP (tos 0x0, ttl  64, id 6596, offset 0, flags [+], length: 1500) 1.1.4.6.8006 > 1.1.4.1.8006: [bad udp cksum 7a33!] UDP, length: 1492
11:09:20.932580 IP (tos 0x0, ttl  64, id 6596, offset 1480, flags [none], length: 40) 1.1.4.6 > 1.1.4.1: udp
11:09:20.932711 IP (tos 0x0, ttl  64, id 27, offset 0, flags [DF], length: 1368) 1.1.4.6.8006 > 1.1.4.1.8006: [udp sum ok] UDP, length: 1340

Each UDP fragment is fragmented (split into two packets) again.
Tunnel iface have wrong MTU!

# ip a
2: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:50:fc:b1:49:ce brd ff:ff:ff:ff:ff:ff
    inet 1.1.4.6/24 brd 1.1.4.255 scope global eth0
12: tun0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1456 qdisc pfifo_fast qlen 100
    link/ppp
    inet 1.1.5.6 peer 1.1.5.5/32 scope global tun0

I start tunnel with:
openvpn \
    --secret "$PWD/key" \
    --dev tun \
    --proto udp \
    --port 8006 \
    --remote 1.1.4.1 \
    --ifconfig 1.1.5.6 1.1.5.5 \
    --link-mtu 1500 \
    --mtu-test \
    --verb 3 \
    --mute 20
Sun May 16 11:11:46 2004 OpenVPN 2.0_beta1 i386-pc-linux-gnu [SSL] [LZO] built on May 12 2004
Sun May 16 11:11:46 2004 Static Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Sun May 16 11:11:46 2004 Static Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Sun May 16 11:11:46 2004 Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Sun May 16 11:11:46 2004 Static Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Sun May 16 11:11:46 2004 WARNING: normally if you use --mssfix and/or --fragment, you should also set --tun-mtu 1500 (currently it is 1456)
Sun May 16 11:11:46 2004 TUN/TAP device tun0 opened
Sun May 16 11:11:46 2004 /bin/ifconfig tun0 1.1.5.6 pointopoint 1.1.5.5 mtu 1456
Sun May 16 11:11:47 2004 Data Channel MTU parms [ L:1500 D:1450 EF:44 EB:0 ET:0 EL:0 ]
Sun May 16 11:11:47 2004 Local Options hash (VER=V3): 'f12ee986'
Sun May 16 11:11:47 2004 Expected Remote Options hash (VER=V3): '7d238820'
Sun May 16 11:11:47 2004 UDPv4 link local (bound): [undef]:8006
Sun May 16 11:11:47 2004 UDPv4 link remote: 1.1.4.1:8006
Sun May 16 11:11:57 2004 Peer Connection Initiated with 1.1.4.1:8006
Sun May 16 11:11:59 2004 NOTE: Beginning empirical MTU test -- results should be available in 3 to 4 minutes.
Sun May 16 11:15:28 2004 NOTE: Empirical MTU test completed [Tried,Actual] local->remote=[1500,1500] remote->local=[1500,1500]

I tried without --mtu-test. 'ip a' output is the same, i.e., mtu=1456.

Max mtu which does not exhibit this problem is:

# ip l set tun0 mtu 1435

Or maybe I'm mistaken and I shall set --link-mtu not to the value
reported by 'ip a l dev eth0' (i.e. max IP packet size), but
to the max *UDP* packet size? 1500-28=1472, then. Not every user
knows IP overhead size. I don't. I looked at tcpdump to figure out.
--
vda


