Subject: Re: [Openvpn-devel] openvpn-2.0_beta1: tunnel MTU a bit too large
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1084740580.39452@...41...>
In-Reply-To: <200405162057.13888.vda@...216...>
References: <200405161143.42983.vda@...216...>, <200405161143.42983.vda@...216...>
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
Date: Sun May 16 13:50:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Denis Vlasenko <vda@...216...>, openvpn-devel@lists.sourceforge.net

Denis,

There are two ways of setting the MTU in OpenVPN, one is to use --tun-mtu
which doesn't include any encapsulation overhead, the other is to use
--link-mtu which sets the maximum encrypted UDP datagram size sent between
OpenVPN daemons after encapsulation.

2.0 takes a different approach to earlier version of OpenVPN on this.  1.x
tries to use a lower MTU to get around fragmentation problems.  But since
MTU=1500 is a kind of industry standard for ethernet networks, lowering it can
cause problems.  So the 2.0 approach is to set the MTU to 1500 and then use
--mssfix 1450 by default.  This will keep TCP connections over the tunnel from
using the full size 1500 MTU by advertising lower MSS values to TCP senders. 
Instead TCP senders will use a segment size that will result in total
encrypted, encapsulated OpenVPN packet sizes of 1450 or less.  And then when
you add on the IP header and UDP header, you are still under 1500.

So if you're getting fragmentation on an HTTP download, I would try reducing
--mssfix to something below 1450 and see if that that fixes the problem.

James

Denis Vlasenko <vda@...216...> said:

> > Or maybe I'm mistaken and I shall set --link-mtu not to the value
> > reported by 'ip a l dev eth0' (i.e. max IP packet size), but
> > to the max *UDP* packet size? 1500-28=1472, then. Not every user
> > knows IP overhead size. I don't. I looked at tcpdump to figure out.
> 
> "Double frag" bug does not happen for UDP if I use --tun-mtu 1435 or lower.
> With
> openvpn \
>     --secret "$PWD/key" \
>     --dev tun \
>     --proto udp \
>     --port 8002 \
>     --local 1.1.4.1 \
>     --remote 1.1.4.2 \
>     --ifconfig 1.1.5.1 1.1.5.2 \
>     --tun-mtu 1434 \
>     --ping 30 \
>     --ping-exit 66 \
>     --verb 3 \
>     --mute 20:
> 
> UDP flood (dd if=/dev/zero bs=1M | nc -nuvvv -w1 1.1.5.6 34564):
> ...
> 20:44:23.376801 IP (tos 0x0, ttl  64, id 5657, offset 0, flags [DF], length:
1496) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1468
> 20:44:23.376907 IP (tos 0x0, ttl  64, id 5658, offset 0, flags [DF], length:
1248) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1220
> 20:44:23.378234 IP (tos 0x0, ttl  64, id 5659, offset 0, flags [DF], length:
1496) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1468
> 20:44:23.378380 IP (tos 0x0, ttl  64, id 5660, offset 0, flags [DF], length:
1496) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1468
> 20:44:23.378520 IP (tos 0x0, ttl  64, id 5661, offset 0, flags [DF], length:
1496) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1468
> 20:44:23.378659 IP (tos 0x0, ttl  64, id 5662, offset 0, flags [DF], length:
1496) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1468
> 20:44:23.378798 IP (tos 0x0, ttl  64, id 5663, offset 0, flags [DF], length:
1496) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1468
> 20:44:23.378888 IP (tos 0x0, ttl  64, id 5664, offset 0, flags [DF], length:
1248) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1220
> ...
> 
> Ok.
> 
> TCP flood (e.g. HTTP download):
> ...
> 20:41:55.514646 IP (tos 0x0, ttl  64, id 5293, offset 0, flags [DF], length:
1472) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1444
> 20:41:55.514786 IP (tos 0x0, ttl  64, id 5294, offset 0, flags [DF], length:
1472) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1444
> 20:41:55.514923 IP (tos 0x0, ttl  64, id 5295, offset 0, flags [DF], length:
1472) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1444
> 20:41:55.515049 IP (tos 0x0, ttl  64, id 5296, offset 0, flags [DF], length:
1472) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1444
> 20:41:55.515207 IP (tos 0x0, ttl  64, id 5297, offset 0, flags [DF], length:
1472) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1444
> 20:41:55.515341 IP (tos 0x0, ttl  64, id 5298, offset 0, flags [DF], length:
1472) 1.1.4.1.8006 > 1.1.4.6.8006: [udp sum ok] UDP, length: 1444
> ...                                                                        
 ^^^^
> 
> Something is wrong here.
> 
> #ip a l eth0 tun0
> 2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>     link/ether 00:50:fc:b0:e1:17 brd ff:ff:ff:ff:ff:ff
>     inet 1.1.4.1/24 brd 1.1.4.255 scope global ifi
> 49: tun0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1434 qdisc pfifo_fast qlen 100
>     link/ppp
>     inet 1.1.5.5 peer 1.1.5.6/32 scope global tun0
> 
> openvpn log:
> Sun May 16 20:55:53 2004 OpenVPN 2.0_beta1 i386-pc-linux-gnu [SSL] [LZO]
built on May 12 2004
> Sun May 16 20:55:53 2004 Static Encrypt: Cipher 'BF-CBC' initialized with
128 bit key
> Sun May 16 20:55:53 2004 Static Encrypt: Using 160 bit message hash 'SHA1'
for HMAC authentication
> Sun May 16 20:55:53 2004 Static Decrypt: Cipher 'BF-CBC' initialized with
128 bit key
> Sun May 16 20:55:53 2004 Static Decrypt: Using 160 bit message hash 'SHA1'
for HMAC authentication
> Sun May 16 20:55:53 2004 WARNING: normally if you use --mssfix and/or
--fragment, you should also set --tun-mtu 1500 (currently it is 1434)
> Sun May 16 20:55:53 2004 TUN/TAP device tun1 opened
> Sun May 16 20:55:53 2004 /bin/ifconfig tun1 1.1.5.1 pointopoint 1.1.5.2 mtu 1434
> Sun May 16 20:55:53 2004 Data Channel MTU parms [ L:1478 D:1450 EF:44 EB:0
ET:0 EL:0 ]
> Sun May 16 20:55:53 2004 Local Options hash (VER=V3): '5194cd41'
> Sun May 16 20:55:53 2004 Expected Remote Options hash (VER=V3): 'e341fa03'
> Sun May 16 20:55:53 2004 UDPv4 link local (bound): 1.1.4.1:8002
> Sun May 16 20:55:53 2004 UDPv4 link remote: 1.1.4.2:8002
> Sun May 16 20:55:58 2004 Peer Connection Initiated with 1.1.4.2:8002
> --
> vda
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




