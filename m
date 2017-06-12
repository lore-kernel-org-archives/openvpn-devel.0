From: debbie10t <debbie10t@...277...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
Message-ID: <f73269d2-ba02-5360-9498-378f1e221a56@...277...>
Date: Mon, 12 Jun 2017 15:28:37 +0100
MIME-Version: 1.0
In-Reply-To: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

*bump*

Is there no explanation ?



On 07/06/17 17:41, debbie10t wrote:
> Hi,
> 
> I have a basic setup and discovered that my W10 client was assigning a 
> second IPv6 address to TAP even though it is *not* being pushed by the 
> server.  The second address is an old address from a server that I 
> sometimes connect to.  The server is still running but the client is not 
> connected to it.
> 
> The most significant information here is that this *only* happens when 
> using the openvpn-GUI + interactive-service.
> 
> When using the command prompt to run the W10 client manually the VPN is 
> setup completely normally. Only the pushed address is used.
> 
> 
> Below is the VPN which causes the strange behaviour.
> 
> SERVER (Linux Ubuntu .. The client connects to this)
> 
> conf
> ====
> persist-key
> persist-tun
> client-to-client
> ;user nobody
> ;group nobody
> verb 4
> cd /etc/openvpn
> dev tuns108
> port 11948
> 
> server 10.8.0.0 255.255.255.0
> server-ipv6 12fc:1918::10:8:0:0/112
> 
> client-config-dir defaults/ccd
> ccd-exclusive
> 
> keepalive 10 30
> comp-lzo no
> push "comp-lzo no"
> log defaults/108.log
> management 127.0.0.1 11948
> 
> tls-auth
> dh
> ca
> cert
> key
> ====
> 
> 
> 
> CCD File (Verified that this file *is* used)
> ========
> 
> push-reset
> push "ping 10"
>        ping 10
> push "ping-restart 30"
>        ping-restart 60
> push "route 10.8.0.1"
> 
> ifconfig-push 10.8.0.110 10.8.0.109
> ifconfig-ipv6-push 12fc:1918::10:8:0:110/112
> =========
> 
> 
> 
> CLIENT (W 10.0.14393)
> 
> ovpn
> ====
> 
> 
> dev-node defc108
> 
> dev-type tun
> 
> management 127.0.0.1 11948
> 
> resolv-retry infinite
> 
> 
> client
> 
> explicit-exit-notify 3
> 
> 
> 
> reneg-sec 0
> 
> 
> comp-lzo no
> 
> 
> remote-cert-tls server
> 
> 
> verb 4
> 
> 
> 
> remote ...
> port 11948
> 
> proto udp
> 
> nobind
> 
> 
> dhcp-option DISABLE-NBT
> 
> 
> 
> ca
> cert
> key
> tls-auth
> ====
> 
> 
> Most relevant parts of logs:
> 
> SERVER LOG
> ==========
> 
> Wed Jun  7 16:34:01 2017 us=552519 OpenVPN 2.5_git 
> [git:master/07372a0fdeb36382] x86_64-unknown-linux-gnu [SSL (OpenSSL)] 
> [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Feb 23 2017
> Wed Jun  7 16:34:01 2017 us=552561 library versions: OpenSSL 1.0.1f 6 
> Jan 2014, LZO 2.06
> Wed Jun  7 16:34:01 2017 us=553657 MANAGEMENT: TCP Socket listening on 
> [AF_INET]127.0.0.1:11948
> <s>
> Wed Jun  7 16:34:01 2017 us=749800 ROUTE_GATEWAY 
> 10.1.101.1/255.255.255.0 IFACE=eth0 HWADDR=00:30:1b:42:65:ac
> Wed Jun  7 16:34:01 2017 us=750719 TUN/TAP device tuns108 opened
> Wed Jun  7 16:34:01 2017 us=750798 TUN/TAP TX queue length set to 100
> Wed Jun  7 16:34:01 2017 us=750854 do_ifconfig, 
> tt->did_ifconfig_ipv6_setup=1
> Wed Jun  7 16:34:01 2017 us=750916 /sbin/ifconfig tuns108 10.8.0.1 
> pointopoint 10.8.0.2 mtu 1500
> Wed Jun  7 16:34:01 2017 us=756708 /sbin/ifconfig tuns108 add 
> 12fc:1918::10:8:0:1/112
> Wed Jun  7 16:34:01 2017 us=758869 /sbin/route add -net 10.8.0.0 netmask 
> 255.255.255.0 gw 10.8.0.2
> <s>
> Wed Jun  7 16:34:01 2017 us=760819 IFCONFIG POOL IPv6: (IPv4) size=62, 
> size_ipv6=65536, netbits=112, base_ipv6=12fc:1918::10:8:0:1000
> Wed Jun  7 16:34:01 2017 us=760843 IFCONFIG POOL: base=10.8.0.4 size=62, 
> ipv6=1
> Wed Jun  7 16:34:01 2017 us=760915 Initialization Sequence Completed
> Wed Jun  7 16:34:32 2017 us=784338 MULTI: multi_create_instance called
> Wed Jun  7 16:34:32 2017 us=784601 client.ip:3163 Re-using SSL/TLS context
> <s>
> Wed Jun  7 16:34:32 2017 us=785333 client.ip:3163 TLS: Initial packet 
> from [AF_INET]client.ip:3163, sid=b26639a2 13444e2c
> Wed Jun  7 16:34:32 2017 us=819223 client.ip:3163 VERIFY OK: depth=1, 
> C=US, ST=California, L=San Francisco, O=Copyleft Certificate Co, OU=My 
> Organizational Unit, CN=defaults, emailAddress=me@...2160...
> Wed Jun  7 16:34:32 2017 us=820188 client.ip:3163 VERIFY OK: depth=0, 
> C=US, ST=California, L=San Francisco, O=Copyleft Certificate Co, OU=My 
> Organizational Unit, CN=defaultc01, emailAddress=me@...2160...
> Wed Jun  7 16:34:32 2017 us=827342 client.ip:3163 peer info: IV_VER=2.4.2
> Wed Jun  7 16:34:32 2017 us=827466 client.ip:3163 peer info: IV_PLAT=win
> Wed Jun  7 16:34:32 2017 us=827507 client.ip:3163 peer info: IV_PROTO=2
> Wed Jun  7 16:34:32 2017 us=827545 client.ip:3163 peer info: IV_NCP=2
> Wed Jun  7 16:34:32 2017 us=827582 client.ip:3163 peer info: IV_LZ4=1
> Wed Jun  7 16:34:32 2017 us=827629 client.ip:3163 peer info: IV_LZ4v2=1
> Wed Jun  7 16:34:32 2017 us=827667 client.ip:3163 peer info: IV_LZO=1
> Wed Jun  7 16:34:32 2017 us=827703 client.ip:3163 peer info: IV_COMP_STUB=1
> Wed Jun  7 16:34:32 2017 us=827741 client.ip:3163 peer info: 
> IV_COMP_STUBv2=1
> Wed Jun  7 16:34:32 2017 us=827779 client.ip:3163 peer info: IV_TCPNL=1
> Wed Jun  7 16:34:32 2017 us=827818 client.ip:3163 peer info: 
> IV_GUI_VER=OpenVPN_GUI_11
> <s>
> Connection Initiated with [AF_INET]client.ip:3163
> Wed Jun  7 16:34:32 2017 us=829379 defaultc01/client.ip:3163 OPTIONS 
> IMPORT: reading client specific options from: defaults/ccd/defaultc01
> Wed Jun  7 16:34:32 2017 us=830040 defaultc01/client.ip:3163 MULTI_sva: 
> push_ifconfig_ipv6 12fc:1918::10:8:0:110/112
> Wed Jun  7 16:34:32 2017 us=830334 defaultc01/client.ip:3163 OPTIONS 
> IMPORT: timers and/or timeouts modified
> Wed Jun  7 16:34:32 2017 us=830384 defaultc01/client.ip:3163 MULTI: 
> Learn: 10.8.0.110 -> defaultc01/client.ip:3163
> Wed Jun  7 16:34:32 2017 us=830423 defaultc01/client.ip:3163 MULTI: 
> primary virtual IP for defaultc01/client.ip:3163: 10.8.0.110
> Wed Jun  7 16:34:32 2017 us=830465 defaultc01/client.ip:3163 MULTI: 
> Learn: 12fc:1918::10:8:0:110 -> defaultc01/client.ip:3163
> Wed Jun  7 16:34:32 2017 us=830505 defaultc01/client.ip:3163 MULTI: 
> primary virtual IPv6 for defaultc01/client.ip:3163: 12fc:1918::10:8:0:110
> Wed Jun  7 16:34:34 2017 us=70005 defaultc01/client.ip:3163 PUSH: 
> Received control message: 'PUSH_REQUEST'
> Wed Jun  7 16:34:34 2017 us=70294 defaultc01/client.ip:3163 SENT CONTROL 
> [defaultc01]: 'PUSH_REPLY,ping 10,ping-restart 30,route 
> 10.8.0.1,ifconfig-ipv6 12fc:1918::10:8:0:110/112 
> 12fc:1918::10:8:0:1,ifconfig 10.8.0.110 10.8.0.109,peer-id 0,cipher 
> AES-256-GCM' (status=1)
> <s>
> Wed Jun  7 16:34:34 2017 us=226401 defaultc01/client.ip:3163 MULTI: bad 
> source address from client [::], packet dropped
> Wed Jun  7 16:34:34 2017 us=226531 defaultc01/client.ip:3163 MULTI: bad 
> source address from client [::], packet dropped
> Wed Jun  7 16:34:34 2017 us=226617 defaultc01/client.ip:3163 MULTI: bad 
> source address from client [::], packet dropped
> Wed Jun  7 16:34:35 2017 us=226119 defaultc01/client.ip:3163 MULTI: bad 
> source address from client [12fc:1918::10:36:101:110], packet dropped
> 
> 
> 
> CLIENT LOG
> ==========
> 
> Wed Jun 07 16:33:50 2017 us=953420 OpenVPN 2.4.2 x86_64-w64-mingw32 [SSL 
> (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] built on May 12 2017
> 
> Wed Jun 07 16:33:50 2017 us=953420 Windows version 6.2 (Windows 8 or 
> greater) 64bit
> 
> Wed Jun 07 16:33:50 2017 us=953420 library versions: OpenSSL 1.0.2k  26 
> Jan 2017, LZO 2.10
> 
> <s>
> Wed Jun 07 16:33:51 2017 us=828418 TCP/UDP: Preserving recently used 
> remote address: [AF_INET]server.ip:11948
> 
> <s>
> Wed Jun 07 16:33:51 2017 us=875295 [defaults] Peer Connection Initiated 
> with [AF_INET]server.ip:11948
> 
> Wed Jun 07 16:33:53 2017 us=125353 MANAGEMENT: 
>  >STATE:1496849633,GET_CONFIG,,,,,,
> 
> Wed Jun 07 16:33:53 2017 us=125353 SENT CONTROL [defaults]: 
> 'PUSH_REQUEST' (status=1)
> 
> Wed Jun 07 16:33:53 2017 us=125353 PUSH: Received control message: 
> 'PUSH_REPLY,ping 10,ping-restart 30,route 10.8.0.1,ifconfig-ipv6 
> 12fc:1918::10:8:0:110/112 12fc:1918::10:8:0:1,ifconfig 10.8.0.110 
> 10.8.0.109,peer-id 0,cipher AES-256-GCM'
> 
> Wed Jun 07 16:33:53 2017 us=125353 OPTIONS IMPORT: timers and/or 
> timeouts modified
> 
> Wed Jun 07 16:33:53 2017 us=125353 OPTIONS IMPORT: --ifconfig/up options 
> modified
> 
> Wed Jun 07 16:33:53 2017 us=125353 OPTIONS IMPORT: route options modified
> 
> Wed Jun 07 16:33:53 2017 us=125353 OPTIONS IMPORT: peer-id set
> 
> Wed Jun 07 16:33:53 2017 us=125353 OPTIONS IMPORT: adjusting link_mtu to 
> 1625
> 
> Wed Jun 07 16:33:53 2017 us=125353 OPTIONS IMPORT: data channel crypto 
> options modified
> 
> <s>
> Wed Jun 07 16:33:53 2017 us=125353 interactive service msg_channel=544
> 
> Wed Jun 07 16:33:53 2017 us=125353 ROUTE_GATEWAY 
> 10.10.101.1/255.255.255.0 I=13 HWADDR=24:b6:fd:31:bc:ca
> 
> Wed Jun 07 16:33:53 2017 us=125353 open_tun
> 
> Wed Jun 07 16:33:53 2017 us=125353 TAP-WIN32 device [defc108] opened: 
> \\.\Global\{AAFE414F-F176-40D4-9F66-2DA6AF175589}.tap
> 
> Wed Jun 07 16:33:53 2017 us=125353 TAP-Windows Driver Version 9.21
> 
> Wed Jun 07 16:33:53 2017 us=125353 TAP-Windows MTU=1500
> 
> Wed Jun 07 16:33:53 2017 us=125353 Notified TAP-Windows driver to set a 
> DHCP IP/netmask of 10.8.0.110/255.255.255.252 on interface 
> {AAFE414F-F176-40D4-9F66-2DA6AF175589} [DHCP-serv: 10.8.0.109, 
> lease-time: 31536000]
> 
> Wed Jun 07 16:33:53 2017 us=125353 DHCP option string: 2b060104 00000002
> 
> Wed Jun 07 16:33:53 2017 us=125353 Successful ARP Flush on interface 
> [17] {AAFE414F-F176-40D4-9F66-2DA6AF175589}
> 
> Wed Jun 07 16:33:53 2017 us=125353 do_ifconfig, 
> tt->did_ifconfig_ipv6_setup=1
> 
> Wed Jun 07 16:33:53 2017 us=125353 MANAGEMENT: 
>  >STATE:1496849633,ASSIGN_IP,,10.8.0.110,,,,,12fc:1918::10:8:0:110
> 
> Wed Jun 07 16:33:53 2017 us=125353 
> add_route_ipv6(12fc:1918::10:8:0:0/112 -> 12fc:1918::10:8:0:110 metric 
> 0) dev defc108
> 
> Wed Jun 07 16:33:53 2017 us=125353 ROUTE: route addition failed using 
> service: The object already exists.   [status=5010 if_index=17]
> 
> Wed Jun 07 16:33:53 2017 us=125353 IPv6 route addition via service failed
> 
> Wed Jun 07 16:33:58 2017 us=969193 TEST ROUTES: 1/1 succeeded len=1 
> ret=1 a=0 u/d=up
> 
> Wed Jun 07 16:33:58 2017 us=969193 MANAGEMENT: 
>  >STATE:1496849638,ADD_ROUTES,,,,,,
> 
> Wed Jun 07 16:33:58 2017 us=969193 C:\WINDOWS\system32\route.exe ADD 
> 10.8.0.1 MASK 255.255.255.255 10.8.0.109
> 
> Wed Jun 07 16:33:58 2017 us=969193 Route addition via service succeeded
> 
> Wed Jun 07 16:33:58 2017 us=969193 Initialization Sequence Completed
> 
> Wed Jun 07 16:33:58 2017 us=969193 MANAGEMENT: 
>  >STATE:1496849638,CONNECTED,SUCCESS,10.8.0.110,server.ip,11948,,,12fc:1918::10:8:0:110
> 
> I am not quite sure why the route addition failed but there are *no* 
> other VPNs running on the client,  do not worry about it for this issue.
> 
> 
> 
> CLIENT IPCONFIG /ALL
> ====================
> 
> Windows IP Configuration
> 
> 
> 
>     Host Name . . . . . . . . . . . . : ***
> 
>     Primary Dns Suffix  . . . . . . . :
> 
>     Node Type . . . . . . . . . . . . : Hybrid
> 
>     IP Routing Enabled. . . . . . . . : Yes
> 
>     WINS Proxy Enabled. . . . . . . . : No
> 
> 
> 
> Ethernet adapter defc108:
> 
> 
> 
>     Connection-specific DNS Suffix  . :
> 
>     Description . . . . . . . . . . . : TAP-Windows Adapter V9
> 
>     Physical Address. . . . . . . . . : 00-FF-AA-FE-41-4F
> 
>     DHCP Enabled. . . . . . . . . . . : Yes
> 
>     Autoconfiguration Enabled . . . . : Yes
> 
>     IPv6 Address. . . . . . . . . . . : 12fc:1918::10:8:0:110(Preferred)
> 
>     IPv6 Address. . . . . . . . . . . : 12fc:1918::10:36:101:110(Preferred)
> 
>     Link-local IPv6 Address . . . . . : 
> fe80::ac09:1fad:3e4a:963d%17(Preferred)
> 
>     IPv4 Address. . . . . . . . . . . : 10.8.0.110(Preferred)
> 
>     Subnet Mask . . . . . . . . . . . : 255.255.255.252
> 
>     Lease Obtained. . . . . . . . . . : 07 June 2017 16:33:53
> 
>     Lease Expires . . . . . . . . . . : 07 June 2018 16:33:52
> 
>     Default Gateway . . . . . . . . . :
> 
>     DHCP Server . . . . . . . . . . . : 10.8.0.109
> 
>     DHCPv6 IAID . . . . . . . . . . . : 83951530
> 
>     DHCPv6 Client DUID. . . . . . . . : 
> 00-01-00-01-19-BC-E7-9F-C0-18-85-79-69-A7
> 
>     DNS Servers . . . . . . . . . . . : fec0:0:0:ffff::1%1
> 
>                                         fec0:0:0:ffff::2%1
> 
>                                         fec0:0:0:ffff::3%1
> 
>     NetBIOS over Tcpip. . . . . . . . : Disabled
> 
> 
> 
> Ethernet adapter Network Bridge:
> 
> 
> 
>     Connection-specific DNS Suffix  . :
> 
>     Description . . . . . . . . . . . : Microsoft Network Adapter 
> Multiplexor Driver
> 
>     Physical Address. . . . . . . . . : 24-B6-FD-31-BC-CA
> 
>     DHCP Enabled. . . . . . . . . . . : No
> 
>     Autoconfiguration Enabled . . . . : Yes
> 
>     IPv4 Address. . . . . . . . . . . : 10.10.101.111(Preferred)
> 
>     Subnet Mask . . . . . . . . . . . : 255.255.255.0
> 
>     Default Gateway . . . . . . . . . : 10.10.101.1
> 
>     DNS Servers . . . . . . . . . . . : 10.10.101.1
> 
>     NetBIOS over Tcpip. . . . . . . . : Disabled
> 
> 
> I have also attached a screenshot of wireshark on the client soliciting
> both addresses.
> 
> Notes:
> Above the W10 config uses --dev-node defc108
> The other config which would use the 12fc:1918::10:36:101:110 address
> uses --dev-node tunc36 .. I don't know if/how that could be related.
> There is no overlap in the two VPNs in either addresses or cert/keys or 
> anything else that I am aware of. (Double checked many times)
> 
> If you require any further details please let me know.
> 
> Thanks

