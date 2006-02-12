Mime-Version: 1.0 (Apple Message framework v623)
Message-Id: <880abfd24b45b843de23222c3340e5b0@...277...>
From: Arrigo Triulzi <arrigo.triulzi@...277...>
Subject: [Openvpn-devel] Bug: OpenVPN 2.1beta8 OpenBSD server with "topology subnet"
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
Date: Sun Feb 12 16:22:06 2006
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I believe the following might be a bug (although I'd love to stand 
corrected on it) with OpenVPN 2.1beta8 running on OpenBSD.

server.conf (OpenBSD 3.7-stable):

   local W.X.Y.Z
   port 1194
   proto tcp-server
   dev tun0
   ca crypto/ca.crt
   cert crypto/vpn1.albourne.com.crt
   key crypto/vpn1.albourne.com.key  # This file should be kept secret
   dh crypto/dh1024.pem
   topology subnet
   server 192.168.172.0 255.255.252.0
   ifconfig-pool-persist /usr/local/var/run/openvpn-ipp.txt
   client-to-client
   keepalive 10 120
   comp-lzo
   persist-key
   persist-tun
   status /usr/local/var/run/openvpn-status.log
   verb 3

client.conf (Ubuntu 5.10/Linux 2.6.12):

   client
   dev tun
   proto tcp-client
   remote W.X.Y.Z 1194
   resolv-retry infinite
   nobind
   persist-key
   persist-tun
   ca ca.crt
   cert cygnus.crt
   key cygnus.key
   ns-cert-type server
   comp-lzo
   verb 3

The server and client (both 2.1beta8, compiled from source) happily 
start up with no errors, handshake and set the relevant local 
interfaces:

[client]
Fri Feb 10 01:00:28 2006 PUSH: Received control message: 
'PUSH_REPLY,route-gateway 192.168.172.1,topology subnet,ping 
10,ping-restart 120,ifconfig 192.168.172.3 255.255.252.0'
Fri Feb 10 01:00:28 2006 OPTIONS IMPORT: timers and/or timeouts modified
Fri Feb 10 01:00:28 2006 OPTIONS IMPORT: --ifconfig/up options modified
Fri Feb 10 01:00:28 2006 OPTIONS IMPORT: route-related options modified
Fri Feb 10 01:00:28 2006 TUN/TAP device tun0 opened
Fri Feb 10 01:00:28 2006 TUN/TAP TX queue length set to 100
Fri Feb 10 01:00:28 2006 /sbin/ifconfig tun0 192.168.172.3 netmask 
255.255.252.0 mtu 1500 broadcast 192.168.175.255

[server]
Fri Feb 10 00:00:26 2006 83.X.Y.Z:16009 [cygnus] Peer Connection 
Initiated with 83.X.Y.Z:16009
Fri Feb 10 00:00:26 2006 cygnus/83.X.Y.Z:16009 MULTI: Learn: 
192.168.172.3 -> cygnus/83.X.Y.Z:16009
Fri Feb 10 00:00:26 2006 cygnus/83.X.Y.Z:16009 MULTI: primary virtual 
IP for cygnus/83.X.Y.Z:16009: 192.168.172.3
Fri Feb 10 00:00:27 2006 cygnus/83.X.Y.Z:16009 PUSH: Received control 
message: 'PUSH_REQUEST'
Fri Feb 10 00:00:27 2006 cygnus/83.X.Y.Z:16009 SENT CONTROL [cygnus]: 
'PUSH_REPLY,route-gateway 192.168.172.1,topology subnet,ping 
10,ping-restart 120,ifconfig 192.168.172.3 255.255.252.0' (status=1)


The output from ifconfig:

[client]
tun0      Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           inet addr:192.168.172.3  P-t-P:192.168.172.3  
Mask:255.255.252.0
           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)


[server]
tun0: flags=9843<UP,BROADCAST,RUNNING,SIMPLEX,LINK0,MULTICAST> mtu 1500
         address: 00:bd:af:74:c0:01
         inet 192.168.172.1 netmask 0xfffffc00 broadcast 192.168.175.255
         inet6 fe80::2bd:afff:fe74:c001%tun0 prefixlen 64 scopeid 0x17

So that looks just fine.

If I try to send ICMP ping packets down the wire observing with tcpdump 
-i tun0 on both systems I get the following output:

[client]
00:54:41.013660 IP (tos 0x0, ttl  64, id 8, offset 0, flags [DF], 
proto: ICMP (1), length: 84)
   192.168.172.4 > 192.168.172.1: ICMP echo request, id 17700, seq 9, 
length 64
00:54:42.013493 IP (tos 0x0, ttl  64, id 9, offset 0, flags [DF], 
proto: ICMP (1), length: 84)
   192.168.172.4 > 192.168.172.1: ICMP echo request, id 17700, seq 10, 
length 64

[server]
00:54:41.041494 0:54:0:8:40:0 0:0:0:2:45:0 4001 88:
                          614a c0a8 ac04 c0a8 ac01 0800 cf8b 4524
                          0009 c1ca ef43 4735 0000 0809 0a0b 0c0d
                          0e0f 1011 1213 1415 1617 1819 1a1b 1c1d
                          1e1f 2021 2223 2425 2627 2829 2a2b 2c2d
                          2e2f 3031 3233 3435 3637
00:54:42.041826 0:54:0:9:40:0 0:0:0:2:45:0 4001 88:
                          6149 c0a8 ac04 c0a8 ac01 0800 768b 4524
                          000a c2ca ef43 9f34 0000 0809 0a0b 0c0d
                          0e0f 1011 1213 1415 1617 1819 1a1b 1c1d
                          1e1f 2021 2223 2425 2627 2829 2a2b 2c2d
                          2e2f 3031 3233 3435 3637

(I _think_ the above are the correct packets on the server-side, 
there's nothing but stuff like the above)

If I remove the "topology subnet" from server.conf and restart I can 
happily ping through the tunnel and the output from tcpdump on both 
ends is as expected (note that the client is assigned IP 192.168.172.6, 
as expected, with the map30 topology):

[server]
sudo tcpdump -i tun0
tcpdump: listening on tun0, link-type LOOP
23:59:40.442035 192.168.172.6 > 192.168.172.1: icmp: echo request (DF)
23:59:40.442074 192.168.172.1 > 192.168.172.6: icmp: echo reply (DF)
23:59:41.442278 192.168.172.6 > 192.168.172.1: icmp: echo request (DF)
23:59:41.442293 192.168.172.1 > 192.168.172.6: icmp: echo reply (DF)
23:59:42.443881 192.168.172.6 > 192.168.172.1: icmp: echo request (DF)
23:59:42.443894 192.168.172.1 > 192.168.172.6: icmp: echo reply (DF)
23:59:43.444639 192.168.172.6 > 192.168.172.1: icmp: echo request (DF)

This seems to indicate that there is a problem on OpenBSD 3.7 with 
OpenVPN 2.1beta8.

I am more than willing to act as a test site as I have a redundant 
firewall pair and while I debug this problem I can run the primary in 
map30 mode to give VPN access to remote clients.

Please let me know if you need more information and/or want me to try 
stuff.

Ciao,

Arrigo


