From: tincanteksup <tincanteksup@...277...>
Message-ID: <d9c75727-f242-4c8a-3bfc-006e01629716@...277...>
Date: Thu, 24 May 2018 13:46:05 +0100
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] [openvpn-devel] Use --ec-curve
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

I have come across the use of --ec-curve on the Forum a couple of times
but, as it is undocumented and does not appear to work, I did not pay
that much attention ..

Now, it turns out that --ec-curve is supported by current release v246,
so I decided to look more closely at the problem.

The short version of this thread is that, from what I can test, only
openssl-1.0.2o can actually connect to a server using any other curve 
than secp384r1.

In this example only the openssl version is changed, only one client
cert is used for both tests.

server openvpn-2.4.6 openssl-1.1.0h uses --ec-curve brainpoolP384r1

client openvpn-2.4.6 openssl-1.1.0h cannot connect
"SSL routines:tls_post_process_client_hello:no shared cipher"

client openvpn-2.4.6 openssl-1.0.2o *can* connect
"Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-ECDSA-AES256-
GCM-SHA384, 384 bit EC, curve: brainpoolP384r1"

The key detail, which drew my attention, is that a v246 server using 
ossl11x can send the TLS cipher information but the same version of
ovpn/ossl cannot receive (or setup) that cipher.  Where as a client
using ovpn246/ossl192o can do this ..

As --ec-curve remains undocumented I presume that is because its
implementation is not yet completed ? So I decided to send this email
for confirmation or, if this problem is not known, to inform you of it.

Thanks
tct
-- 


Logs follow.

Client openssl-1.0.2o connects ok:

Thu May 24 12:58:42 2018 us=9503 OpenVPN 2.4.6 x86_64-pc-linux-gnu [SSL 
(OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on May 
23 2018
Thu May 24 12:58:42 2018 us=9530 library versions: OpenSSL 1.0.2o  27 
Mar 2018, LZO 2.10
Thu May 24 12:58:42 2018 us=10324 Outgoing Control Channel Encryption: 
Cipher 'AES-256-CTR' initialized with 256 bit key
Thu May 24 12:58:42 2018 us=10393 Outgoing Control Channel Encryption: 
Using 256 bit message hash 'SHA256' for HMAC authentication
Thu May 24 12:58:42 2018 us=10407 Incoming Control Channel Encryption: 
Cipher 'AES-256-CTR' initialized with 256 bit key
Thu May 24 12:58:42 2018 us=10432 Incoming Control Channel Encryption: 
Using 256 bit message hash 'SHA256' for HMAC authentication
Thu May 24 12:58:42 2018 us=10538 Control Channel MTU parms [ L:1622 
D:1156 EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:58:42 2018 us=33689 Data Channel MTU parms [ L:1622 D:1450 
EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:58:42 2018 us=33797 Local Options String (VER=V4): 
'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto UDPv4,comp-lzo,cipher 
AES-256-GCM,auth [null-digest],keysize 256,key-method 2,tls-client'
Thu May 24 12:58:42 2018 us=33837 Expected Remote Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-server'
Thu May 24 12:58:42 2018 us=33880 TCP/UDP: Preserving recently used 
remote address: [AF_INET]x.x.x.x:55111
Thu May 24 12:58:42 2018 us=33927 Socket Buffers: R=[212992->212992] 
S=[212992->212992]
Thu May 24 12:58:42 2018 us=33950 UDP link local: (not bound)
Thu May 24 12:58:42 2018 us=33972 UDP link remote: [AF_INET]x.x.x.x:55111
Thu May 24 12:58:42 2018 us=38290 TLS: Initial packet from 
[AF_INET]x.x.x.x:55111, sid=388688bc 54e4c1e1
Thu May 24 12:58:42 2018 us=49540 VERIFY OK: depth=1, C=00, ST=tct, 
L=home, O=tct@...2045..., OU=tct@...2403..., CN=v304.ec.bpP384r1.ca, 
emailAddress=me@...2160...
Thu May 24 12:58:42 2018 us=51106 VERIFY KU OK
Thu May 24 12:58:42 2018 us=51163 Validating certificate extended key usage
Thu May 24 12:58:42 2018 us=51177 ++ Certificate has EKU (str) TLS Web 
Server Authentication, expects TLS Web Server Authentication
Thu May 24 12:58:42 2018 us=51188 VERIFY EKU OK
Thu May 24 12:58:42 2018 us=51211 VERIFY X509NAME OK: C=00, ST=tct, 
L=home, O=tct@...2045..., OU=tct@...2403..., CN=v304.ec.bpP384r1.s01.arch, 
emailAddress=me@...2160...
Thu May 24 12:58:42 2018 us=51231 VERIFY OK: depth=0, C=00, ST=tct, 
L=home, O=tct@...2045..., OU=tct@...2403..., CN=v304.ec.bpP384r1.s01.arch, 
emailAddress=me@...2160...
Thu May 24 12:58:42 2018 us=69171 Control Channel: TLSv1.2, cipher 
TLSv1/SSLv3 ECDHE-ECDSA-AES256-GCM-SHA384, 384 bit EC, curve: 
brainpoolP384r1
Thu May 24 12:58:42 2018 us=69266 [v304.ec.bpP384r1.s01.arch] Peer 
Connection Initiated with [AF_INET]x.x.x.x:55111
Thu May 24 12:58:43 2018 us=275829 SENT CONTROL 
[v304.ec.bpP384r1.s01.arch]: 'PUSH_REQUEST' (status=1)
Thu May 24 12:58:43 2018 us=280875 PUSH: Received control message: 
'PUSH_REPLY,tun-ipv6,route-ipv6 
12fc:1918::10:55:111:0/112,explicit-exit-notify 3,route 
10.55.111.1,topology net30,ping 10,ping-restart 30,ifconfig-ipv6 
12fc:1918::10:55:111:8000/112 12fc:1918::10:55:111:226,ifconfig 
10.55.111.6 10.55.111.5,peer-id 0'
Thu May 24 12:58:43 2018 us=281032 OPTIONS IMPORT: timers and/or 
timeouts modified
Thu May 24 12:58:43 2018 us=281061 OPTIONS IMPORT: explicit notify 
parm(s) modified
Thu May 24 12:58:43 2018 us=281072 OPTIONS IMPORT: --ifconfig/up options 
modified
Thu May 24 12:58:43 2018 us=281090 OPTIONS IMPORT: route options modified
Thu May 24 12:58:43 2018 us=281110 OPTIONS IMPORT: peer-id set
Thu May 24 12:58:43 2018 us=281129 OPTIONS IMPORT: adjusting link_mtu to 
1625
Thu May 24 12:58:43 2018 us=281158 Data Channel MTU parms [ L:1553 
D:1450 EF:53 EB:406 ET:0 EL:3 ]
Thu May 24 12:58:43 2018 us=281236 Outgoing Data Channel: Cipher 
'AES-256-GCM' initialized with 256 bit key
Thu May 24 12:58:43 2018 us=281276 Incoming Data Channel: Cipher 
'AES-256-GCM' initialized with 256 bit key
Thu May 24 12:58:43 2018 us=281435 ROUTE_GATEWAY 
10.10.201.1/255.255.255.0 IFACE=eth0 HWADDR=00:15:5d:c9:6e:0c
Thu May 24 12:58:43 2018 us=281496 GDG6: remote_host_ipv6=n/a
Thu May 24 12:58:43 2018 us=281533 ROUTE6: default_gateway=UNDEF
Thu May 24 12:58:43 2018 us=281942 TUN/TAP device tunc55111 opened
Thu May 24 12:58:43 2018 us=282037 TUN/TAP TX queue length set to 100
Thu May 24 12:58:43 2018 us=282060 do_ifconfig, 
tt->did_ifconfig_ipv6_setup=1
Thu May 24 12:58:43 2018 us=282124 /sbin/ifconfig tunc55111 10.55.111.6 
pointopoint 10.55.111.5 mtu 1500
Thu May 24 12:58:43 2018 us=307075 /sbin/ifconfig tunc55111 add 
12fc:1918::10:55:111:8000/112
Thu May 24 12:58:43 2018 us=308145 /sbin/route add -net 10.55.111.1 
netmask 255.255.255.255 gw 10.55.111.5
Thu May 24 12:58:43 2018 us=318236 
add_route_ipv6(12fc:1918::10:55:111:0/112 -> 12fc:1918::10:55:111:226 
metric -1) dev tunc55111
Thu May 24 12:58:43 2018 us=318346 /sbin/route -A inet6 add 
12fc:1918::10:55:111:0/112 dev tunc55111
Thu May 24 12:58:43 2018 us=319320 WARNING: this configuration may cache 
passwords in memory -- use the auth-nocache option to prevent this
Thu May 24 12:58:43 2018 us=319385 Initialization Sequence Completed
^CThu May 24 12:58:46 2018 us=658999 event_wait : Interrupted system 
call (code=4)
Thu May 24 12:58:46 2018 us=659061 SIGTERM received, sending exit 
notification to peer
Thu May 24 12:58:50 2018 us=56639 TCP/UDP: Closing socket
Thu May 24 12:58:50 2018 us=56758 /sbin/route del -net 10.55.111.1 
netmask 255.255.255.255
Thu May 24 12:58:50 2018 us=57820 
delete_route_ipv6(12fc:1918::10:55:111:0/112)
Thu May 24 12:58:50 2018 us=57903 /sbin/route -A inet6 del 
12fc:1918::10:55:111:0/112 dev tunc55111
Thu May 24 12:58:50 2018 us=58731 Closing TUN/TAP interface
Thu May 24 12:58:50 2018 us=58805 /sbin/ifconfig tunc55111 0.0.0.0
Thu May 24 12:58:50 2018 us=59673 /sbin/ifconfig tunc55111 del 
12fc:1918::10:55:111:8000/112
Thu May 24 12:58:50 2018 us=78456 SIGTERM[soft,exit-with-notification] 
received, process exiting

*****

Client openssl-1.1.0h Fails:

Thu May 24 12:57:47 2018 us=610097 OpenVPN 2.4.6 x86_64-pc-linux-gnu 
[SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built 
on Apr 24 2018
Thu May 24 12:57:47 2018 us=610145 library versions: OpenSSL 1.1.0h  27 
Mar 2018, LZO 2.10
Thu May 24 12:57:47 2018 us=610864 Outgoing Control Channel Encryption: 
Cipher 'AES-256-CTR' initialized with 256 bit key
Thu May 24 12:57:47 2018 us=610927 Outgoing Control Channel Encryption: 
Using 256 bit message hash 'SHA256' for HMAC authentication
Thu May 24 12:57:47 2018 us=610972 Incoming Control Channel Encryption: 
Cipher 'AES-256-CTR' initialized with 256 bit key
Thu May 24 12:57:47 2018 us=611016 Incoming Control Channel Encryption: 
Using 256 bit message hash 'SHA256' for HMAC authentication
Thu May 24 12:57:47 2018 us=611170 Control Channel MTU parms [ L:1622 
D:1156 EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:57:47 2018 us=760274 Data Channel MTU parms [ L:1622 
D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:57:47 2018 us=760409 Local Options String (VER=V4): 
'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto UDPv4,comp-lzo,cipher 
AES-256-GCM,auth [null-digest],keysize 256,key-method 2,tls-client'
Thu May 24 12:57:47 2018 us=760461 Expected Remote Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-server'
Thu May 24 12:57:47 2018 us=760511 TCP/UDP: Preserving recently used 
remote address: [AF_INET]x.x.x.x:55111
Thu May 24 12:57:47 2018 us=760669 Socket Buffers: R=[212992->212992] 
S=[212992->212992]
Thu May 24 12:57:47 2018 us=760769 UDP link local: (not bound)
Thu May 24 12:57:47 2018 us=760823 UDP link remote: [AF_INET]x.x.x.x:55111
Thu May 24 12:57:47 2018 us=765223 TLS: Initial packet from 
[AF_INET]x.x.x.x:55111, sid=2fd6a572 9ce2ca28
^CThu May 24 12:57:54 2018 us=874393 event_wait : Interrupted system 
call (code=4)
Thu May 24 12:57:54 2018 us=874532 TCP/UDP: Closing socket
Thu May 24 12:57:54 2018 us=874599 SIGINT[hard,] received, process exiting

*****

Server:

Thu May 24 12:57:38 2018 us=890158 OpenVPN 2.4.6 x86_64-pc-linux-gnu 
[SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built 
on Apr 24 2018
Thu May 24 12:57:38 2018 us=890185 library versions: OpenSSL 1.1.0h  27 
Mar 2018, LZO 2.10
Thu May 24 12:57:38 2018 us=892243 mlockall call succeeded
Thu May 24 12:57:38 2018 us=893089 ECDH curve brainpoolP384r1 added
Thu May 24 12:57:38 2018 us=893205 Outgoing Control Channel Encryption: 
Cipher 'AES-256-CTR' initialized with 256 bit key
Thu May 24 12:57:38 2018 us=893235 Outgoing Control Channel Encryption: 
Using 256 bit message hash 'SHA256' for HMAC authentication
Thu May 24 12:57:38 2018 us=893257 Incoming Control Channel Encryption: 
Cipher 'AES-256-CTR' initialized with 256 bit key
Thu May 24 12:57:38 2018 us=893280 Incoming Control Channel Encryption: 
Using 256 bit message hash 'SHA256' for HMAC authentication
Thu May 24 12:57:38 2018 us=893303 TLS-Auth MTU parms [ L:1622 D:1156 
EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:57:38 2018 us=893434 ROUTE_GATEWAY 
10.10.201.1/255.255.255.0 IFACE=eth0 HWADDR=00:15:5d:c9:6e:01
Thu May 24 12:57:38 2018 us=893502 GDG6: remote_host_ipv6=n/a
Thu May 24 12:57:38 2018 us=893540 ROUTE6: default_gateway=UNDEF
Thu May 24 12:57:38 2018 us=894567 TUN/TAP device tuns55111 opened
Thu May 24 12:57:38 2018 us=894638 TUN/TAP TX queue length set to 100
Thu May 24 12:57:38 2018 us=894659 do_ifconfig, 
tt->did_ifconfig_ipv6_setup=1
Thu May 24 12:57:38 2018 us=894679 /usr/bin/ip link set dev tuns55111 up 
mtu 1500
Thu May 24 12:57:38 2018 us=896719 /usr/bin/ip addr add dev tuns55111 
local 10.55.111.1 peer 10.55.111.2
Thu May 24 12:57:38 2018 us=898325 /usr/bin/ip -6 addr add 
12fc:1918::10:55:111:226/112 dev tuns55111
Thu May 24 12:57:38 2018 us=899969 /usr/bin/ip route add 10.55.111.0/24 
via 10.55.111.2
Thu May 24 12:57:38 2018 us=903830 
add_route_ipv6(12fc:1918::10:55:111:0/112 -> 12fc:1918::10:55:111:225 
metric -1) dev tuns55111
Thu May 24 12:57:38 2018 us=904068 /usr/bin/ip -6 route add 
12fc:1918::10:55:111:0/112 dev tuns55111
Thu May 24 12:57:38 2018 us=905668 Data Channel MTU parms [ L:1622 
D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:57:38 2018 us=905797 Could not determine IPv4/IPv6 
protocol. Using AF_INET
Thu May 24 12:57:38 2018 us=905861 Socket Buffers: R=[212992->212992] 
S=[212992->212992]
Thu May 24 12:57:38 2018 us=905923 UDPv4 link local (bound): 
[AF_INET]10.10.201.226:55111
Thu May 24 12:57:38 2018 us=905999 UDPv4 link remote: [AF_UNSPEC]
Thu May 24 12:57:38 2018 us=906083 MULTI: multi_init called, r=256 v=256
Thu May 24 12:57:38 2018 us=906167 IFCONFIG POOL IPv6: (IPv4) size=62, 
size_ipv6=65536, netbits=112, base_ipv6=12fc:1918::10:55:111:8000
Thu May 24 12:57:38 2018 us=906234 IFCONFIG POOL: base=10.55.111.4 
size=62, ipv6=1
Thu May 24 12:57:38 2018 us=906301 Initialization Sequence Completed
Thu May 24 12:57:47 2018 us=763548 MULTI: multi_create_instance called
Thu May 24 12:57:47 2018 us=763605 x.x.x.x:2240 Re-using SSL/TLS context
Thu May 24 12:57:47 2018 us=763721 x.x.x.x:2240 Control Channel MTU 
parms [ L:1622 D:1156 EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:57:47 2018 us=763755 x.x.x.x:2240 Data Channel MTU parms [ 
L:1622 D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:57:47 2018 us=763794 x.x.x.x:2240 Local Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-server'
Thu May 24 12:57:47 2018 us=763805 x.x.x.x:2240 Expected Remote Options 
String (VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-client'
Thu May 24 12:57:47 2018 us=763827 x.x.x.x:2240 TLS: Initial packet from 
[AF_INET]x.x.x.x:2240, sid=fa2621fb e8a05c19
Thu May 24 12:57:47 2018 us=767229 x.x.x.x:2240 TLS error: The server 
has no TLS ciphersuites in common with the client. Your --tls-cipher 
setting might be too restrictive.
Thu May 24 12:57:47 2018 us=767261 x.x.x.x:2240 OpenSSL: 
error:1417A0C1:SSL routines:tls_post_process_client_hello:no shared cipher
Thu May 24 12:57:47 2018 us=767271 x.x.x.x:2240 TLS_ERROR: BIO read 
tls_read_plaintext error
Thu May 24 12:57:47 2018 us=767279 x.x.x.x:2240 TLS Error: TLS object -> 
incoming plaintext read error
Thu May 24 12:57:47 2018 us=767287 x.x.x.x:2240 TLS Error: TLS handshake 
failed
Thu May 24 12:57:47 2018 us=767320 x.x.x.x:2240 SIGUSR1[soft,tls-error] 
received, client-instance restarting
Thu May 24 12:57:49 2018 us=212438 MULTI: multi_create_instance called
Thu May 24 12:57:49 2018 us=212497 x.x.x.x:4005 Re-using SSL/TLS context
Thu May 24 12:57:49 2018 us=212543 x.x.x.x:4005 Control Channel MTU 
parms [ L:1622 D:1156 EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:57:49 2018 us=212554 x.x.x.x:4005 Data Channel MTU parms [ 
L:1622 D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:57:49 2018 us=212581 x.x.x.x:4005 Local Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-server'
Thu May 24 12:57:49 2018 us=212590 x.x.x.x:4005 Expected Remote Options 
String (VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-client'
Thu May 24 12:57:49 2018 us=212613 x.x.x.x:4005 TLS: Initial packet from 
[AF_INET]x.x.x.x:4005, sid=ec4e199b d594346d
Thu May 24 12:57:49 2018 us=216712 x.x.x.x:4005 TLS error: The server 
has no TLS ciphersuites in common with the client. Your --tls-cipher 
setting might be too restrictive.
Thu May 24 12:57:49 2018 us=216750 x.x.x.x:4005 OpenSSL: 
error:1417A0C1:SSL routines:tls_post_process_client_hello:no shared cipher
Thu May 24 12:57:49 2018 us=216761 x.x.x.x:4005 TLS_ERROR: BIO read 
tls_read_plaintext error
Thu May 24 12:57:49 2018 us=216770 x.x.x.x:4005 TLS Error: TLS object -> 
incoming plaintext read error
Thu May 24 12:57:49 2018 us=216778 x.x.x.x:4005 TLS Error: TLS handshake 
failed
Thu May 24 12:57:49 2018 us=216816 x.x.x.x:4005 SIGUSR1[soft,tls-error] 
received, client-instance restarting
Thu May 24 12:58:11 2018 us=610907 MULTI: multi_create_instance called
Thu May 24 12:58:11 2018 us=610971 x.x.x.x:3218 Re-using SSL/TLS context
Thu May 24 12:58:11 2018 us=611022 x.x.x.x:3218 Control Channel MTU 
parms [ L:1622 D:1156 EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:58:11 2018 us=611035 x.x.x.x:3218 Data Channel MTU parms [ 
L:1622 D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:58:11 2018 us=611065 x.x.x.x:3218 Local Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-server'
Thu May 24 12:58:11 2018 us=611074 x.x.x.x:3218 Expected Remote Options 
String (VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-client'
Thu May 24 12:58:11 2018 us=611100 x.x.x.x:3218 TLS: Initial packet from 
[AF_INET]x.x.x.x:3218, sid=13e2e083 5bbabab6
Thu May 24 12:58:11 2018 us=614512 x.x.x.x:3218 TLS error: The server 
has no TLS ciphersuites in common with the client. Your --tls-cipher 
setting might be too restrictive.
Thu May 24 12:58:11 2018 us=614543 x.x.x.x:3218 OpenSSL: 
error:1417A0C1:SSL routines:tls_post_process_client_hello:no shared cipher
Thu May 24 12:58:11 2018 us=614552 x.x.x.x:3218 TLS_ERROR: BIO read 
tls_read_plaintext error
Thu May 24 12:58:11 2018 us=614560 x.x.x.x:3218 TLS Error: TLS object -> 
incoming plaintext read error
Thu May 24 12:58:11 2018 us=614568 x.x.x.x:3218 TLS Error: TLS handshake 
failed
Thu May 24 12:58:11 2018 us=614603 x.x.x.x:3218 SIGUSR1[soft,tls-error] 
received, client-instance restarting
Thu May 24 12:58:42 2018 us=35767 MULTI: multi_create_instance called
Thu May 24 12:58:42 2018 us=35825 x.x.x.x:2812 Re-using SSL/TLS context
Thu May 24 12:58:42 2018 us=35871 x.x.x.x:2812 Control Channel MTU parms 
[ L:1622 D:1156 EF:94 EB:0 ET:0 EL:3 ]
Thu May 24 12:58:42 2018 us=35882 x.x.x.x:2812 Data Channel MTU parms [ 
L:1622 D:1450 EF:122 EB:406 ET:0 EL:3 ]
Thu May 24 12:58:42 2018 us=35909 x.x.x.x:2812 Local Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-server'
Thu May 24 12:58:42 2018 us=35918 x.x.x.x:2812 Expected Remote Options 
String (VER=V4): 'V4,dev-type tun,link-mtu 1550,tun-mtu 1500,proto 
UDPv4,comp-lzo,cipher AES-256-GCM,auth [null-digest],keysize 
256,key-method 2,tls-client'
Thu May 24 12:58:42 2018 us=35941 x.x.x.x:2812 TLS: Initial packet from 
[AF_INET]x.x.x.x:2812, sid=f2e7542e c292aebe
Thu May 24 12:58:42 2018 us=58081 x.x.x.x:2812 VERIFY OK: depth=1, C=00, 
ST=tct, L=home, O=tct@...2045..., OU=tct@...2403..., CN=v304.ec.bpP384r1.ca, 
emailAddress=me@...2160...
Thu May 24 12:58:42 2018 us=59353 x.x.x.x:2812 VERIFY KU OK
Thu May 24 12:58:42 2018 us=59368 x.x.x.x:2812 Validating certificate 
extended key usage
Thu May 24 12:58:42 2018 us=59378 x.x.x.x:2812 ++ Certificate has EKU 
(str) TLS Web Client Authentication, expects TLS Web Client Authentication
Thu May 24 12:58:42 2018 us=59387 x.x.x.x:2812 VERIFY EKU OK
Thu May 24 12:58:42 2018 us=59396 x.x.x.x:2812 VERIFY X509NAME OK: C=00, 
ST=tct, L=home, O=tct@...2045..., OU=tct@...2403..., 
CN=v304.ec.bpP384r1.c01.ub18, emailAddress=me@...2160...
Thu May 24 12:58:42 2018 us=59404 x.x.x.x:2812 VERIFY OK: depth=0, C=00, 
ST=tct, L=home, O=tct@...2045..., OU=tct@...2403..., 
CN=v304.ec.bpP384r1.c01.ub18, emailAddress=me@...2160...
Thu May 24 12:58:42 2018 us=64960 x.x.x.x:2812 peer info: IV_VER=2.4.6
Thu May 24 12:58:42 2018 us=65026 x.x.x.x:2812 peer info: IV_PLAT=linux
Thu May 24 12:58:42 2018 us=65038 x.x.x.x:2812 peer info: IV_PROTO=2
Thu May 24 12:58:42 2018 us=65047 x.x.x.x:2812 peer info: IV_NCP=2
Thu May 24 12:58:42 2018 us=65056 x.x.x.x:2812 peer info: IV_LZ4=1
Thu May 24 12:58:42 2018 us=65065 x.x.x.x:2812 peer info: IV_LZ4v2=1
Thu May 24 12:58:42 2018 us=65084 x.x.x.x:2812 peer info: IV_LZO=1
Thu May 24 12:58:42 2018 us=65094 x.x.x.x:2812 peer info: IV_COMP_STUB=1
Thu May 24 12:58:42 2018 us=65103 x.x.x.x:2812 peer info: IV_COMP_STUBv2=1
Thu May 24 12:58:42 2018 us=65112 x.x.x.x:2812 peer info: IV_TCPNL=1
Thu May 24 12:58:42 2018 us=65121 x.x.x.x:2812 peer info: 
IV_HWADDR=00:15:5d:c9:6e:0c
Thu May 24 12:58:42 2018 us=65140 x.x.x.x:2812 peer info: 
IV_SSL=OpenSSL_1.0.2o__27_Mar_2018
Thu May 24 12:58:42 2018 us=65150 x.x.x.x:2812 peer info: 
UV_INFO=v304.ec.bpP384r1.c01.ub18
Thu May 24 12:58:42 2018 us=65159 x.x.x.x:2812 peer info: UV_PING=10
Thu May 24 12:58:42 2018 us=65168 x.x.x.x:2812 peer info: UV_PINGR=60
Thu May 24 12:58:42 2018 us=65300 x.x.x.x:2812 Outgoing Data Channel: 
Cipher 'AES-256-GCM' initialized with 256 bit key
Thu May 24 12:58:42 2018 us=65366 x.x.x.x:2812 Incoming Data Channel: 
Cipher 'AES-256-GCM' initialized with 256 bit key
Thu May 24 12:58:42 2018 us=70343 x.x.x.x:2812 Control Channel: TLSv1.2, 
cipher TLSv1.2 ECDHE-ECDSA-AES256-GCM-SHA384, 384 bit EC, curve: 
brainpoolP384r1
Thu May 24 12:58:42 2018 us=70422 x.x.x.x:2812 
[v304.ec.bpP384r1.c01.ub18] Peer Connection Initiated with 
[AF_INET]x.x.x.x:2812
Thu May 24 12:58:42 2018 us=70462 v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 
OPTIONS IMPORT: reading client specific options from: 
tuns_55111u/CCD_net30/v304.ec.bpP384r1.c01.ub18
Thu May 24 12:58:42 2018 us=70499 v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 
MULTI_sva: pool returned IPv4=10.55.111.6, IPv6=12fc:1918::10:55:111:8000
Thu May 24 12:58:42 2018 us=70587 v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 
MULTI: Learn: 10.55.111.6 -> v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812
Thu May 24 12:58:42 2018 us=70609 v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 
MULTI: primary virtual IP for v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812: 
10.55.111.6
Thu May 24 12:58:42 2018 us=70630 v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 
MULTI: Learn: 12fc:1918::10:55:111:8000 -> 
v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812
Thu May 24 12:58:42 2018 us=70662 v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 
MULTI: primary virtual IPv6 for v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812: 
12fc:1918::10:55:111:8000
Thu May 24 12:58:43 2018 us=277337 
v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 PUSH: Received control message: 
'PUSH_REQUEST'
Thu May 24 12:58:43 2018 us=277430 
v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 SENT CONTROL 
[v304.ec.bpP384r1.c01.ub18]: 'PUSH_REPLY,tun-ipv6,route-ipv6 
12fc:1918::10:55:111:0/112,explicit-exit-notify 3,route 
10.55.111.1,topology net30,ping 10,ping-restart 30,ifconfig-ipv6 
12fc:1918::10:55:111:8000/112 12fc:1918::10:55:111:226,ifconfig 
10.55.111.6 10.55.111.5,peer-id 0' (status=1)
Thu May 24 12:58:46 2018 us=660527 
v304.ec.bpP384r1.c01.ub18/x.x.x.x:2812 SIGTERM[soft,remote-exit] 
received, client-instance exiting
^CThu May 24 12:58:53 2018 us=371354 event_wait : Interrupted system 
call (code=4)
Thu May 24 12:58:55 2018 us=373853 TCP/UDP: Closing socket
Thu May 24 12:58:55 2018 us=373982 /usr/bin/ip route del 10.55.111.0/24
Thu May 24 12:58:55 2018 us=375493 
delete_route_ipv6(12fc:1918::10:55:111:0/112)
Thu May 24 12:58:55 2018 us=375567 /usr/bin/ip -6 route del 
12fc:1918::10:55:111:0/112 dev tuns55111
Thu May 24 12:58:55 2018 us=376872 Closing TUN/TAP interface
Thu May 24 12:58:55 2018 us=376998 /usr/bin/ip addr del dev tuns55111 
local 10.55.111.1 peer 10.55.111.2
Thu May 24 12:58:55 2018 us=378425 /usr/bin/ip -6 addr del 
12fc:1918::10:55:111:226/112 dev tuns55111
Thu May 24 12:58:55 2018 us=447518 SIGINT[hard,] received, process exiting

*****


