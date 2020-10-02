From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
Date: Fri, 2 Oct 2020 15:26:29 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------FE717577CBA23BC990093043"
Content-Language: en-US
Subject: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------FE717577CBA23BC990093043
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi all,

After testing connecting over native IPv6 to the VPN server, it turns 
out the IPv4 traffic is not routed over the VPN. This worked in older 
versions of OpenVPN (2.4.x) but no longer in OpenVPN 2.5rc2. I am 
testing with Windows 8.1, but the same was reported on Windows 10.

This is pushed to the client regarding default gateway: redirect-gateway 
def1 ipv6

The log shows this "NOTE": 2020-10-02 06:20:07 NOTE: unable to redirect 
IPv4 default gateway -- Cannot obtain current remote host address

IPv6 traffic *does* get routed over the VPN.

It may have something to do with this commit: 
https://github.com/OpenVPN/openvpn/commit/aa34684972eb01bfa5c355d1c8a8a9d384bf0175#diff-c5fe151f7dee49748a306a4defe6bbea

See attached full client log message.

Regards,
François

--------------FE717577CBA23BC990093043
Content-Type: text/x-log; charset=UTF-8;
 name="vpn.tuxed.net_internet_20201002_win81.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vpn.tuxed.net_internet_20201002_win81.log"

2020-10-02 06:19:58 Note: Treating option '--ncp-ciphers' as  '--data-ciphers' (renamed in OpenVPN 2.5).
2020-10-02 06:19:58 OpenVPN 2.5_rc2 x86_64-w64-mingw32 [SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on Sep 30 2020
2020-10-02 06:19:58 Windows version 6.3 (Windows 8.1) 64bit
2020-10-02 06:19:58 library versions: OpenSSL 1.1.1h  22 Sep 2020, LZO 2.10
Enter Management Password:
2020-10-02 06:19:58 MANAGEMENT: TCP Socket listening on [AF_INET]127.0.0.1:25341
2020-10-02 06:19:58 Need hold release from management interface, waiting...
2020-10-02 06:19:59 MANAGEMENT: Client connected from [AF_INET]127.0.0.1:25341
2020-10-02 06:19:59 MANAGEMENT: CMD 'state on'
2020-10-02 06:19:59 MANAGEMENT: CMD 'log all on'
2020-10-02 06:19:59 MANAGEMENT: CMD 'echo all on'
2020-10-02 06:19:59 MANAGEMENT: CMD 'bytecount 5'
2020-10-02 06:19:59 MANAGEMENT: CMD 'hold off'
2020-10-02 06:19:59 MANAGEMENT: CMD 'hold release'
2020-10-02 06:19:59 Outgoing Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key
2020-10-02 06:19:59 Outgoing Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication
2020-10-02 06:19:59 Incoming Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key
2020-10-02 06:19:59 Incoming Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication
2020-10-02 06:19:59 MANAGEMENT: >STATE:1601644799,RESOLVE,,,,,,
2020-10-02 06:19:59 TCP/UDP: Preserving recently used remote address: [AF_INET6]2a01:4f8:c2c:a7af::1:1194
2020-10-02 06:19:59 Socket Buffers: R=[65536->65536] S=[65536->65536]
2020-10-02 06:19:59 UDP link local: (not bound)
2020-10-02 06:19:59 UDP link remote: [AF_INET6]2a01:4f8:c2c:a7af::1:1194
2020-10-02 06:19:59 MANAGEMENT: >STATE:1601644799,WAIT,,,,,,
2020-10-02 06:19:59 MANAGEMENT: >STATE:1601644799,AUTH,,,,,,
2020-10-02 06:19:59 TLS: Initial packet from [AF_INET6]2a01:4f8:c2c:a7af::1:1194, sid=5d283dff fecce94d
2020-10-02 06:19:59 VERIFY KU OK
2020-10-02 06:19:59 Validating certificate extended key usage
2020-10-02 06:19:59 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Server Authentication
2020-10-02 06:19:59 VERIFY EKU OK
2020-10-02 06:19:59 VERIFY OK: depth=0, CN=vpn.tuxed.net
2020-10-02 06:19:59 Control Channel: TLSv1.2, cipher TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384, 3072 bit RSA
2020-10-02 06:19:59 [vpn.tuxed.net] Peer Connection Initiated with [AF_INET6]2a01:4f8:c2c:a7af::1:1194
2020-10-02 06:19:59 PUSH: Received control message: 'PUSH_REPLY,explicit-exit-notify 1,redirect-gateway def1 ipv6,block-outside-dns,dhcp-option DNS 10.132.193.1,dhcp-option DNS fd0b:7113:df63:d03c::1,tun-ipv6,route-gateway 10.132.193.1,topology subnet,ping 10,ping-restart 60,ifconfig-ipv6 fd0b:7113:df63:d03c::2/112 fd0b:7113:df63:d03c::1,ifconfig 10.132.193.2 255.255.255.248,peer-id 0,cipher AES-256-GCM'
2020-10-02 06:19:59 OPTIONS IMPORT: timers and/or timeouts modified
2020-10-02 06:19:59 OPTIONS IMPORT: explicit notify parm(s) modified
2020-10-02 06:19:59 OPTIONS IMPORT: --ifconfig/up options modified
2020-10-02 06:19:59 OPTIONS IMPORT: route options modified
2020-10-02 06:19:59 OPTIONS IMPORT: route-related options modified
2020-10-02 06:19:59 OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified
2020-10-02 06:19:59 OPTIONS IMPORT: peer-id set
2020-10-02 06:19:59 OPTIONS IMPORT: adjusting link_mtu to 1624
2020-10-02 06:19:59 OPTIONS IMPORT: data channel crypto options modified
2020-10-02 06:19:59 Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
2020-10-02 06:19:59 Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
2020-10-02 06:19:59 interactive service msg_channel=380
2020-10-02 06:19:59 ROUTE_GATEWAY 192.168.178.1/255.255.255.0 I=4 HWADDR=20:16:d8:d6:01:14
2020-10-02 06:19:59 GDG6: remote_host_ipv6=2a01:4f8:c2c:a7af::1
2020-10-02 06:19:59 GetBestInterfaceEx() returned if=4
2020-10-02 06:19:59 GDG6: II=4 DP=::/0 NH=fe80::e228:6dff:fe56:e55
2020-10-02 06:19:59 GDG6: Metric=256, Loopback=0, AA=1, I=0
2020-10-02 06:19:59 ROUTE6_GATEWAY fe80::e228:6dff:fe56:e55 I=4
2020-10-02 06:19:59 ROUTE6: 2000::/4 overlaps IPv6 remote 2a01:4f8:c2c:a7af::1, adding host route to VPN endpoint
2020-10-02 06:19:59 open_tun
2020-10-02 06:19:59 tap-windows6 device [eduVPN Client TAP-Windows] opened
2020-10-02 06:19:59 TAP-Windows Driver Version 9.24 
2020-10-02 06:19:59 Set TAP-Windows TUN subnet mode network/local/netmask = 10.132.193.0/10.132.193.2/255.255.255.248 [SUCCEEDED]
2020-10-02 06:19:59 Notified TAP-Windows driver to set a DHCP IP/netmask of 10.132.193.2/255.255.255.248 on interface {5A050F18-5E91-4FCC-876A-BDAB25E015E6} [DHCP-serv: 10.132.193.6, lease-time: 31536000]
2020-10-02 06:19:59 Successful ARP Flush on interface [19] {5A050F18-5E91-4FCC-876A-BDAB25E015E6}
2020-10-02 06:19:59 MANAGEMENT: >STATE:1601644799,ASSIGN_IP,,10.132.193.2,,,,,fd0b:7113:df63:d03c::2
2020-10-02 06:19:59 IPv4 MTU set to 1500 on interface 19 using service
2020-10-02 06:19:59 INET6 address service: add fd0b:7113:df63:d03c::2/128
2020-10-02 06:19:59 add_route_ipv6(fd0b:7113:df63:d03c::/112 -> fd0b:7113:df63:d03c::2 metric 0) dev eduVPN Client TAP-Windows
2020-10-02 06:19:59 IPv6 route addition via service succeeded
2020-10-02 06:20:01 IPv6 dns servers set using service
2020-10-02 06:20:01 IPv6 MTU set to 1500 on interface 19 using service
2020-10-02 06:20:01 Blocking outside dns using service succeeded.
2020-10-02 06:20:07 TEST ROUTES: 1/1 succeeded len=0 ret=1 a=0 u/d=up
2020-10-02 06:20:07 NOTE: unable to redirect IPv4 default gateway -- Cannot obtain current remote host address
2020-10-02 06:20:07 add_route_ipv6(2a01:4f8:c2c:a7af::1/128 -> fe80::e228:6dff:fe56:e55 metric 1) dev eduVPN Client TAP-Windows
2020-10-02 06:20:07 IPv6 route addition via service succeeded
2020-10-02 06:20:07 add_route_ipv6(::/3 -> fd0b:7113:df63:d03c::1 metric -1) dev eduVPN Client TAP-Windows
2020-10-02 06:20:07 IPv6 route addition via service succeeded
2020-10-02 06:20:07 add_route_ipv6(2000::/4 -> fd0b:7113:df63:d03c::1 metric -1) dev eduVPN Client TAP-Windows
2020-10-02 06:20:07 IPv6 route addition via service succeeded
2020-10-02 06:20:07 add_route_ipv6(3000::/4 -> fd0b:7113:df63:d03c::1 metric -1) dev eduVPN Client TAP-Windows
2020-10-02 06:20:07 IPv6 route addition via service succeeded
2020-10-02 06:20:07 add_route_ipv6(fc00::/7 -> fd0b:7113:df63:d03c::1 metric -1) dev eduVPN Client TAP-Windows
2020-10-02 06:20:07 IPv6 route addition via service succeeded
2020-10-02 06:20:07 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
2020-10-02 06:20:07 Initialization Sequence Completed
2020-10-02 06:20:07 MANAGEMENT: >STATE:1601644807,CONNECTED,SUCCESS,10.132.193.2,2a01:4f8:c2c:a7af::1,1194,,,fd0b:7113:df63:d03c::2

--------------FE717577CBA23BC990093043--

