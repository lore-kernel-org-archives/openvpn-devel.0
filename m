From: =?UTF-8?Q?Thomas_Sch=c3=a4fer?= <tschaefer@...75...>
Message-ID: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
Date: Wed, 18 Jan 2017 16:43:22 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C15DC9EC6C3A3D097E36F4D8"
Subject: [Openvpn-devel] NOTE: unable to redirect default gateway -- Cannot
 read current default gateway from system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------C15DC9EC6C3A3D097E36F4D8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In case of being totally wrong here, please redirect me to the right 
place (bug-systems, forum,...).

Some words about the configuration:

Server: shares a private IPv4-Network and ula-IPv6-Network
IPv4-Adresses also NATed to the public.

proto udp6
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
server 192.168.178.128  255.255.255.128
server-ipv6  fd00::1:1/112
push "route 192.168.178.0 255.255.255.0"
push "route-ipv6 fd00::/64"
keepalive 10 120
verb 3


Client:
client
dev tun
proto udp6
remote raspberrypi.XXXXXXXX.myfritz.net 1194 udp6
ca ca.crt
cert client.crt
key client.key
remote-cert-tls server
redirect-gateway
verb 3

This works perfectly as long the client has still an IPv4-connection.

But in case of an IPv6-only-client (not system-wide disabled, just not 
getting IPv4-addresses by the ISP, e.g. eduroam-IPv6) the client doesn't 
set the IPv4-default route, since it can not find the old one.

Regards,
Thomas


--------------C15DC9EC6C3A3D097E36F4D8
Content-Type: text/x-log;
 name="openvpn-error.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn-error.log"

openvpn --config client.ovpn 
Wed Jan 18 16:11:34 2017 OpenVPN 2.4.0 x86_64-suse-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Dec 27 2016
Wed Jan 18 16:11:34 2017 library versions: OpenSSL 1.0.2j-fips  26 Sep 2016, LZO 2.08
Wed Jan 18 16:11:34 2017 TCP/UDP: Preserving recently used remote address: [AF_INET6]2003:63:2417:f900:ba27:ebff:feb6:f293:1194
Wed Jan 18 16:11:34 2017 Socket Buffers: R=[212992->212992] S=[212992->212992]
Wed Jan 18 16:11:34 2017 setsockopt(IPV6_V6ONLY=0)
Wed Jan 18 16:11:34 2017 UDPv6 link local (bound): [AF_INET6][undef]:1194
Wed Jan 18 16:11:34 2017 UDPv6 link remote: [AF_INET6]2003:63:2417:f900:ba27:ebff:feb6:f293:1194
Wed Jan 18 16:11:34 2017 TLS: Initial packet from [AF_INET6]2003:63:2417:f900:ba27:ebff:feb6:f293:1194, sid=f70817fa 1f034096
Wed Jan 18 16:11:34 2017 VERIFY OK: depth=1, C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST, emailAddress=me@...430...
Wed Jan 18 16:11:34 2017 Validating certificate key usage
Wed Jan 18 16:11:34 2017 ++ Certificate has key usage  00a0, expects 00a0
Wed Jan 18 16:11:34 2017 VERIFY KU OK
Wed Jan 18 16:11:34 2017 Validating certificate extended key usage
Wed Jan 18 16:11:34 2017 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
Wed Jan 18 16:11:34 2017 VERIFY EKU OK
Wed Jan 18 16:11:34 2017 VERIFY OK: depth=0, C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Server, emailAddress=me@...430...
Wed Jan 18 16:11:34 2017 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Wed Jan 18 16:11:34 2017 [Test-Server] Peer Connection Initiated with [AF_INET6]2003:63:2417:f900:ba27:ebff:feb6:f293:1194
Wed Jan 18 16:11:36 2017 SENT CONTROL [Test-Server]: 'PUSH_REQUEST' (status=1)
Wed Jan 18 16:11:36 2017 PUSH: Received control message: 'PUSH_REPLY,route 192.168.178.0 255.255.255.0,route-ipv6 fd00::/64,tun-ipv6,route 192.168.178.129,topology net30,ping 10,ping-restart 120,ifconfig-ipv6 fd00::1:1001/112 fd00::1:2,ifconfig 192.168.178.134 192.168.178.133,peer-id 0,cipher AES-256-GCM'
Wed Jan 18 16:11:36 2017 Note: option tun-ipv6 is ignored because modern operating systems do not need special IPv6 tun handling anymore.
Wed Jan 18 16:11:36 2017 OPTIONS IMPORT: timers and/or timeouts modified
Wed Jan 18 16:11:36 2017 OPTIONS IMPORT: --ifconfig/up options modified
Wed Jan 18 16:11:36 2017 OPTIONS IMPORT: route options modified
Wed Jan 18 16:11:36 2017 OPTIONS IMPORT: peer-id set
Wed Jan 18 16:11:36 2017 OPTIONS IMPORT: adjusting link_mtu to 1624
Wed Jan 18 16:11:36 2017 OPTIONS IMPORT: data channel crypto options modified
Wed Jan 18 16:11:36 2017 Data Channel Encrypt: Cipher 'AES-256-GCM' initialized with 256 bit key
Wed Jan 18 16:11:36 2017 Data Channel Decrypt: Cipher 'AES-256-GCM' initialized with 256 bit key
Wed Jan 18 16:11:36 2017 ROUTE: default_gateway=UNDEF
Wed Jan 18 16:11:36 2017 GDG6: remote_host_ipv6=2003:63:2417:f900:ba27:ebff:feb6:f293
Wed Jan 18 16:11:36 2017 ROUTE6_GATEWAY fe80::da67:d9ff:fe6e:a242 IFACE=wlan0
Wed Jan 18 16:11:36 2017 TUN/TAP device tun0 opened
Wed Jan 18 16:11:36 2017 TUN/TAP TX queue length set to 100
Wed Jan 18 16:11:36 2017 do_ifconfig, tt->did_ifconfig_ipv6_setup=1
Wed Jan 18 16:11:36 2017 /bin/ip link set dev tun0 up mtu 1500
Wed Jan 18 16:11:36 2017 /bin/ip addr add dev tun0 local 192.168.178.134 peer 192.168.178.133
Wed Jan 18 16:11:36 2017 /bin/ip -6 addr add fd00::1:1001/112 dev tun0
Wed Jan 18 16:11:36 2017 NOTE: unable to redirect default gateway -- Cannot read current default gateway from system
Wed Jan 18 16:11:36 2017 /bin/ip route add 192.168.178.0/24 via 192.168.178.133
Wed Jan 18 16:11:36 2017 /bin/ip route add 192.168.178.129/32 via 192.168.178.133
Wed Jan 18 16:11:36 2017 add_route_ipv6(fd00::/64 -> fd00::1:2 metric -1) dev tun0
Wed Jan 18 16:11:36 2017 /bin/ip -6 route add fd00::/64 dev tun0
Wed Jan 18 16:11:36 2017 Initialization Sequence Completed

--------------C15DC9EC6C3A3D097E36F4D8--

