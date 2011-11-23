Message-ID: <4ECC6EE6.5050709@...1388...>
Date: Wed, 23 Nov 2011 16:56:22 +1300
From: Michal Ludvig <mludvig@...1388...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Problems with add_route_ipv6()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi guys,

I'm using the latest openvpn from GIT on OpenSUSE 11.4 and am 
experiencing a problem with IPv6 payload setup. It works but openvpn 
seems to be somewhat confused when setting up the v6 route.

Here is the start-up sequence, that works fine:

16:27:27 OpenVPN 2.x-master x86_64-suse-linux-gnu [SSL (OpenSSL)] [LZO2] 
[EPOLL] [eurephia] [MH] [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] 
built on Nov 23 2011
16:27:27 WARNING: No server certificate verification method has been 
enabled.  See http://openvpn.net/howto.html#mitm for more info.
16:27:27 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher to 
call user-defined scripts or executables
16:27:27 Socket Buffers: R=[126976->131072] S=[126976->131072]
16:27:27 UDPv4 link local: [undef]
16:27:27 UDPv4 link remote: [AF_INET]118.90.12.34:1194
16:27:27 TLS: Initial packet from [AF_INET]118.90.12.34:1194, 
sid=9cf3b1b8 b861db1e
Wed Nov 23 16:27:31 2011 VERIFY OK: depth=1, 
/C=CZ/L=Prague/O=Logix.cz/CN=Logix.cz_Root_CA/emailAddress=ca@...1525...
Wed Nov 23 16:27:31 2011 VERIFY OK: depth=0, 
/C=NZ/L=Auckland/O=Logix/CN=xyz.logix.net.nz/emailAddress=ca@...1525...
16:27:35 WARNING: 'proto' is used inconsistently, local='proto UDPv4', 
remote='proto UDPv6'
16:27:35 Data Channel Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
16:27:35 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for 
HMAC authentication
16:27:35 Data Channel Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
16:27:35 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for 
HMAC authentication
16:27:35 Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 
2048 bit RSA
16:27:35 [xyz.logix.net.nz] Peer Connection Initiated with 
[AF_INET]118.90.12.34:1194
16:27:37 SENT CONTROL [xyz.logix.net.nz]: 'PUSH_REQUEST' (status=1)
16:27:37 PUSH: Received control message: 'PUSH_REPLY,ifconfig-ipv6 
2001:e20:abcd:403::1:0 2001:e20:abcd:403::1,route 172.31.172.0 
255.255.255.0,route-ipv6 2001:e20:abcd:400::/56,tun-ipv6,route 
172.31.173.129,topology net30,ifconfig 172.31.173.134 172.31.173.133'
16:27:37 OPTIONS IMPORT: --ifconfig/up options modified
16:27:37 OPTIONS IMPORT: route options modified
16:27:37 ROUTE_GATEWAY 192.168.50.254/255.255.255.0 IFACE=wlan0 
HWADDR=08:11:96:04:50:cc
16:27:37 ROUTE6: default_gateway=UNDEF
16:27:37 TUN/TAP device tunHome opened
16:27:37 TUN/TAP TX queue length set to 100
16:27:37 do_ifconfig, tt->ipv6=1, tt->did_ifconfig_ipv6_setup=1
16:27:37 /bin/ip link set dev tunHome up mtu 1500
16:27:37 /bin/ip addr add dev tunHome local 172.31.173.134 peer 
172.31.173.133
16:27:37 /bin/ip -6 addr add 2001:e20:abcd:403::1:0/64 dev tunHome
16:27:37 /bin/ip route add 172.31.172.0/24 via 172.31.173.133
16:27:37 /bin/ip route add 172.31.173.129/32 via 172.31.173.133
16:27:37 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:27:37 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
16:27:37 Initialization Sequence Completed

However every 2 minutes OpenVPN for some reason triggers a restart and 
then it tries to call add_route_ipv6() more then once. In fact it calls 
it 2x on the first restrat, 3x on the 2nd restart, etc. Here you go 
after a couple of minutes:

16:42:16 [xyz.logix.net.nz] Inactivity timeout (--ping-restart), restarting
16:42:16 /bin/ip route del 172.31.173.129/32
16:42:16 /bin/ip route del 172.31.172.0/24
16:42:16 delete_route_ipv6(2001:e20:abcd:400::/56)
16:42:16 /bin/ip -6 route del 2001:e20:abcd:400::/56 dev tunHome
16:42:16 Closing TUN/TAP interface
16:42:16 /bin/ip addr del dev tunHome local 172.31.173.134 peer 
172.31.173.133
16:42:16 SIGUSR1[soft,ping-restart] received, process restarting
16:42:16 Restart pause, 2 second(s)
16:42:18 WARNING: No server certificate verification method has been 
enabled.  See http://openvpn.net/howto.html#mitm for more info.
16:42:18 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher to 
call user-defined scripts or executables
16:42:18 Socket Buffers: R=[126976->131072] S=[126976->131072]
16:42:18 UDPv4 link local: [undef]
16:42:18 UDPv4 link remote: [AF_INET]118.90.12.34:1194
16:42:18 TLS: Initial packet from [AF_INET]118.90.12.34:1194, 
sid=1db8d9ff 496ac330
16:42:18 VERIFY OK: depth=1, 
/C=CZ/L=Prague/O=Logix.cz/CN=Logix.cz_Root_CA/emailAddress=ca@...1525...
16:42:18 VERIFY OK: depth=0, 
/C=NZ/L=Auckland/O=Logix/CN=xyz.logix.net.nz/emailAddress=ca@...1525...
16:42:19 WARNING: 'proto' is used inconsistently, local='proto UDPv4', 
remote='proto UDPv6'
16:42:19 Data Channel Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
16:42:19 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for 
HMAC authentication
16:42:19 Data Channel Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
16:42:19 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for 
HMAC authentication
16:42:19 Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 
2048 bit RSA
16:42:19 [xyz.logix.net.nz] Peer Connection Initiated with 
[AF_INET]118.90.12.34:1194
16:42:21 SENT CONTROL [xyz.logix.net.nz]: 'PUSH_REQUEST' (status=1)
16:42:21 PUSH: Received control message: 'PUSH_REPLY,ifconfig-ipv6 
2001:e20:abcd:403::1:0 2001:e20:abcd:403::1,route 172.31.172.0 
255.255.255.0,route-ipv6 2001:e20:abcd:400::/56,tun-ipv6,route 
172.31.173.129,topology net30,ifconfig 172.31.173.134 172.31.173.133'
16:42:21 OPTIONS IMPORT: --ifconfig/up options modified
16:42:21 OPTIONS IMPORT: route options modified
16:42:21 ROUTE_GATEWAY 192.168.50.254/255.255.255.0 IFACE=wlan0 
HWADDR=08:11:96:04:50:cc
16:42:21 ROUTE6: default_gateway=UNDEF
16:42:21 TUN/TAP device tunHome opened
16:42:21 TUN/TAP TX queue length set to 100
16:42:21 do_ifconfig, tt->ipv6=1, tt->did_ifconfig_ipv6_setup=1
16:42:21 /bin/ip link set dev tunHome up mtu 1500
16:42:21 /bin/ip addr add dev tunHome local 172.31.173.134 peer 
172.31.173.133
16:42:21 /bin/ip -6 addr add 2001:e20:abcd:403::1:0/64 dev tunHome
16:42:21 /bin/ip route add 172.31.172.0/24 via 172.31.173.133
16:42:21 /bin/ip route add 172.31.173.129/32 via 172.31.173.133
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1 
metric 0) dev tunHome
16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
RTNETLINK answers: File exists
16:42:21 ERROR: Linux route -6/-A inet6 add command failed: external 
program exited with error status: 2
16:42:21 Initialization Sequence Completed

After a couple hrs the list of failed retries becomes pretty long..

This is the remote config:
-------
lport 1194
proto udp6
dev tunTrUDP
key ...
float

server 172.31.173.128 255.255.255.128
server-ipv6 2001:e20:abcd:403::/64

push "route 172.31.172.0 255.255.255.0"
push "route-ipv6 2001:e20:abcd:400::/56"
------

And finally this is the local config:

------
remote xyz.logix.net.nz 1194
dev tunHome
tun-ipv6
key ...
------

Is there anything wrong with my setup or is it an OpenVPN bug?

Thanks!

Michal

