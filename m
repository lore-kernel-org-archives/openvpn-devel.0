From: Thomas =?ISO-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Date: Sat, 26 Jan 2019 00:17:08 +0100
Message-ID: <387122538.3937vOkYaL@...2258...>
In-Reply-To: <9ea3b5ec-4bad-f9bf-29a6-533ecb237027@...277...>
References: <20180605090421.9746-1-a@...2181...>
 <9ea3b5ec-4bad-f9bf-29a6-533ecb237027@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/5] Allow IPv6-only tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am Dienstag, 5. Juni 2018, 14:05:10 CET schrieb tincanteksup:
> Hi,
> 
> I have applied these 5 patches to master...


me too, a little bit late my confirmation:


/usr/local/sbin/openvpn --config server-neu.ovpn
Sat Jan 26 00:05:09 2019 OpenVPN 2.5_git [git:HEAD/a59fd1475089eda4+] armv7l-
unknown-linux-gnueabihf [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] 
[AEAD] built on Jan 25 2019
Sat Jan 26 00:05:09 2019 library versions: OpenSSL 1.1.0h-fips  27 Mar 2018, 
LZO 2.10
Sat Jan 26 00:05:09 2019 Diffie-Hellman initialized with 2048 bit key
Sat Jan 26 00:05:09 2019 TUN/TAP device tun0 opened
Sat Jan 26 00:05:09 2019 TUN/TAP TX queue length set to 100
Sat Jan 26 00:05:09 2019 /sbin/ip link set dev tun0 up mtu 1500
Sat Jan 26 00:05:09 2019 /sbin/ip -6 addr add 2001:a61:5e8:5b01::1:2/112 dev 
tun0
Sat Jan 26 00:05:09 2019 Socket Buffers: R=[163840->163840] S=[163840->163840]
Sat Jan 26 00:05:09 2019 setsockopt(IPV6_V6ONLY=0)
Sat Jan 26 00:05:09 2019 UDPv6 link local (bound): [AF_INET6][undef]:1194
Sat Jan 26 00:05:09 2019 UDPv6 link remote: [AF_UNSPEC]
Sat Jan 26 00:05:09 2019 MULTI: multi_init called, r=256 v=256
Sat Jan 26 00:05:09 2019 IFCONFIG POOL IPv6: (IPv4) size=0, size_ipv6=65536, 
netbits=112, base_ipv6=2001:a61:5e8:5b01::1:1001
Sat Jan 26 00:05:09 2019 Initialization Sequence Completed
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 TLS: Initial 
packet from [AF_INET6]2a01:598:89f0:85e7:f19b:58b8:9005:20f7:39005, 
sid=1055982b 433815b8
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 VERIFY OK: 
depth=1, C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST, 
emailAddress=me@...430...
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 VERIFY OK: 
depth=0, C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Client, 
emailAddress=me@...430...
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_GUI_VER=OC30Android
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_VER=3.2
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_PLAT=android
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_NCP=2
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_TCPNL=1
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_PROTO=2
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_AUTO_SESS=1
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 peer info: 
IV_BS64DL=1
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 Control 
Channel: TLSv1.2, cipher TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Sat Jan 26 00:05:36 2019 2a01:598:89f0:85e7:f19b:58b8:9005:20f7 [Test-Client] 
Peer Connection Initiated with [AF_INET6]2a01:598:89f0:85e7:f19b:
58b8:9005:20f7:39005
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
MULTI_sva: pool returned IPv4=(Not enabled), IPv6=2001:a61:5e8:5b01::1:1001
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
MULTI: no --ifconfig-pool netmask parameter is available to push to Test-
Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
MULTI: no dynamic or static remote --ifconfig address is available for Test-
Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
MULTI: Learn: 2001:a61:5e8:5b01::1:1001 -> Test-Client/
2a01:598:89f0:85e7:f19b:58b8:9005:20f7
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
MULTI: primary virtual IPv6 for Test-Client/2a01:598:89f0:85e7:f19b:
58b8:9005:20f7: 2001:a61:5e8:5b01::1:1001
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
PUSH: Received control message: 'PUSH_REQUEST'
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
SENT CONTROL [Test-Client]: 'PUSH_REPLY,route-ipv6 fd00::/64,route-ipv6  
2001:a61:5e8:5b01:0:0:0:0/64,dhcp-option DNS fd00::464e:6dff:fe72:8a08,tun-
ipv6,ping 10,ping-restart 120,ifconfig-ipv6 2001:a61:5e8:5b01::1:1001/112 
2001:a61:5e8:5b01::1:2,peer-id 0,cipher AES-256-GCM' (status=1)
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
Data Channel: using negotiated cipher 'AES-256-GCM'
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Sat Jan 26 00:05:36 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
Sat Jan 26 00:07:58 2019 Test-Client/2a01:598:89f0:85e7:f19b:58b8:9005:20f7 
SIGTERM[soft,remote-exit] received, client-instance exiting


config at raspberry pi

proto udp6
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
server-ipv6  2001:a61:5e8:5b01:0:0:1:1/112
push "route-ipv6 fd00::/64"
push "route-ipv6  2001:a61:5e8:5b01:0:0:0:0/64"
push "dhcp-option DNS fd00::464e:6dff:fe72:8a08"
keepalive 10 120
verb 3

Client was Openvpn connect 3.05 for android. 


Thomas




