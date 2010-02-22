Message-ID: <4B82F647.5050405@...1305...>
Date: Mon, 22 Feb 2010 16:25:27 -0500
From: mark <mark.co-dyre@...1305...>
MIME-Version: 1.0
Subject: [Openvpn-devel] segfault issue
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

Hello all!

I'm using the openvpn-client with connmand (Redhat Moblin connection 
manager) and everything seems to be working fine although once every 
hour, like perfect clockwork, I get a segfault although there are no 
noticeable issues, crashes, exits.  Everything just keeps chuggin along.

-----sys.log: issue------
Feb 22 19:45:33 A5-20713 kernel: [54562.275481] bash[21933]: segfault at 
bf186ff8 ip b7f66da9 sp bf186ffc error 6 in libc-2.10.1.so[b7ef5000+16a000]
Feb 22 19:45:43 A5-20713 kernel: [54572.379778] bash[21974]: segfault at 
bf3bbffc ip 0807e845 sp bf3bc000 error 6 in bash[8048000+d4000]

Feb 22 20:45:33 A5-20713 kernel: [58161.946736] bash[1605]: segfault at 
bf4dffcc ip 08064809 sp bf4dffc0 error 6 in bash[8048000+d4000]
Feb 22 20:45:43 A5-20713 kernel: [58172.320628] bash[1646]: segfault at 
bf405ffc ip 0807d1f6 sp bf405ee0 error 6 in bash[8048000+d4000]

---------

The segfault disappears if I stop the openvpn-client and or the connman 
software although returns when both are running.
I sense it has something to do with each of the two pieces of software 
managing the connections.  Although I'm not quiet sure how to go about 
debugging it.  Would anyone have any words of wisdom or advice to share 
with me to go about debugging this issue.  Or know of something the 
client manages on an hourly cycle that can be a starting point to my 
investigations.  I imagine one or the other is trying to use memory that 
it shouldn't be although I'm currently a novice at debugging this 
because I've never debugged this type of issue before.   So any help 
would be greatly appreciated.  I've included some info below that might 
be able to help with the challenge I currently face.

BTW... using a 2.6.30 kernel.

------sys.log: startup of both openvpn-client and connmand ------

Feb 22 04:36:19 A5-20713 bootlog:  starting Connection Manager... [ OK ]
Feb 22 04:36:19 A5-20713 connmand[462]: Connection Manager version 0.48
Feb 22 04:36:19 A5-20713 connmand[462]: Excluding WiFi interface plugin
Feb 22 04:36:19 A5-20713 connmand[462]: Checking loopback interface 
settings
Feb 22 04:36:19 A5-20713 connmand[462]: System hostname is A5-20713
Feb 22 04:36:19 A5-20713 connmand[462]: Adding profile default
Feb 22 04:36:19 A5-20713 connmand[462]: lo {RX} 0 packets 0 bytes
Feb 22 04:36:19 A5-20713 connmand[462]: lo {TX} 0 packets 0 bytes
Feb 22 04:36:19 A5-20713 connmand[462]: lo {newlink} index 1 operstate 0 
<UNKNOWN>
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {RX} 0 packets 0 bytes
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {TX} 0 packets 0 bytes
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {create} index 2 type 1 
<ETHER>
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {update} flags 4098 <DOWN>
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {newlink} index 2 address 
00:10:F3:19:39:54 mtu 1500
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {newlink} index 2 operstate 
2 <DOWN>
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {RX} 0 packets 0 bytes
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {TX} 0 packets 0 bytes
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {update} flags 4163 
<UP,RUNNING>
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {newlink} index 2 address 
00:10:F3:19:39:54 mtu 1500
Feb 22 04:36:19 A5-20713 connmand[462]: eth0 {newlink} index 2 operstate 
0 <UNKNOWN>
Feb 22 04:36:19 A5-20713 kernel: [    7.784458] ADDRCONF(NETDEV_UP): 
eth0: link is not ready
Feb 22 04:36:21 A5-20713 connmand[462]: eth0 {RX} 0 packets 0 bytes
Feb 22 04:36:21 A5-20713 connmand[462]: eth0 {TX} 0 packets 0 bytes
Feb 22 04:36:21 A5-20713 connmand[462]: eth0 {update} flags 69699 
<UP,RUNNING,LOWER_UP>
Feb 22 04:36:21 A5-20713 connmand[462]: eth0 {newlink} index 2 address 
00:10:F3:19:39:54 mtu 1500
Feb 22 04:36:21 A5-20713 connmand[462]: eth0 {newlink} index 2 operstate 
6 <UP>
Feb 22 04:36:21 A5-20713 connmand[462]: Network SSID not set
Feb 22 04:36:25 A5-20713 dhclient: DHCPDISCOVER on eth0 to 
255.255.255.255 port 67 interval 3
Feb 22 04:36:25 A5-20713 dhclient: DHCPOFFER from 172.19.1.2
Feb 22 04:36:25 A5-20713 dhclient: DHCPREQUEST on eth0 to 
255.255.255.255 port 67
Feb 22 04:36:25 A5-20713 dhclient: DHCPACK from 172.19.1.2
Feb 22 04:36:25 A5-20713 dhclient: bound to 192.168.0.93 -- renewal in 
95920 seconds.
Feb 22 04:36:25 A5-20713 connmand[462]: Setting domainname to 
testnet.inpulseonline.com
Feb 22 04:36:25 A5-20713 connmand[462]: Adding DNS server 192.168.0.43
Feb 22 04:36:25 A5-20713 connmand[462]: Enabling DNS server 192.168.0.43
Feb 22 04:36:25 A5-20713 connmand[462]: Enabling DNS server 192.168.0.43
Feb 22 04:36:25 A5-20713 connmand[462]: eth0 {add} address 
192.168.0.93/24 label eth0
Feb 22 04:36:25 A5-20713 connmand[462]: eth0 {add} route 192.168.0.2 gw 
0.0.0.0 scope 253 <LINK>
Feb 22 04:36:25 A5-20713 connmand[462]: eth0 {add} route 0.0.0.0 gw 
192.168.0.2 scope 0 <UNIVERSE>
Feb 22 04:36:28 A5-20713 openvpn[670]: OpenVPN 2.0.9 i586-pc-linux [SSL] 
[EPOLL] built on Nov 23 2009
Feb 22 04:36:28 A5-20713 openvpn[670]: IMPORTANT: OpenVPN's default port 
number is now 1194, based on an official port number assignment by 
IANA.  OpenVPN 2.0-beta16 and earlier used 5000 as the default port.
Feb 22 04:36:28 A5-20713 openvpn[671]: Attempting to establish TCP 
connection with 172.19.1.73:1195
Feb 22 04:36:28 A5-20713 openvpn[671]: TCP connection established with 
172.19.1.73:1195
Feb 22 04:36:28 A5-20713 openvpn[671]: TCPv4_CLIENT link local: [undef]
Feb 22 04:36:28 A5-20713 openvpn[671]: TCPv4_CLIENT link remote: 
172.19.1.73:1195
Feb 22 04:36:28 A5-20713 openvpn[671]: [corona] Peer Connection 
Initiated with 172.19.1.73:1195
Feb 22 04:36:29 A5-20713 openvpn[671]: TUN/TAP device tun0 opened
Feb 22 04:36:29 A5-20713 openvpn[671]: /sbin/ifconfig tun0 1.1.12.102 
pointopoint 1.1.12.101 mtu 1500
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {RX} 0 packets 0 bytes
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {TX} 0 packets 0 bytes
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {create} index 3 type 65534 
<NONE>
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {update} flags 4240 <DOWN>
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {newlink} index 3 operstate 
2 <DOWN>
Feb 22 04:36:29 A5-20713 kernel: [   17.998024] tun0: Disabled Privacy 
Extensions
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {add} address 1.1.12.102/32 
label tun0
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {RX} 0 packets 0 bytes
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {TX} 0 packets 0 bytes
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {update} flags 69841 
<UP,RUNNING,LOWER_UP>
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {newlink} index 3 operstate 
0 <UNKNOWN>
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {del} address 1.1.12.102/32 
label tun0
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {add} address 1.1.12.102/32 
label tun0
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {add} route 192.168.0.0 gw 
1.1.12.101 scope 0 <UNIVERSE>
Feb 22 04:36:29 A5-20713 connmand[462]: tun0 {add} route 1.1.0.1 gw 
1.1.12.101 scope 0 <UNIVERSE>
Feb 22 04:36:29 A5-20713 openvpn[671]: Initialization Sequence Completed
...
Feb 22 04:45:33 A5-20713 kernel: [  562.412726] bash[2492]: segfault at 
bf144ffc ip 0806b582 sp bf145000 error 6 in bash[8048000+d4000]
Feb 22 04:45:43 A5-20713 kernel: [  572.563757] bash[2532]: segfault at 
bf5a3ffc ip 0806b382 sp bf5a4000 error 6 in bash[8048000+d4000]
...


----routing table----
Destination     Gateway         Genmask                 Flags Metric 
Ref    Use Iface
1.1.12.65         *                      255.255.255.255     UH     
0      0        0   tun0
corona.openvpn. 1.1.12.65   255.255.255.255    UGH   0      0        
0    tun0
10.0.0.10         *                      255.255.255.255    UH     
0      0        0    eth0
10.0.0.0           *                      255.255.255.0        U       
0      0        0     eth0
192.168.0.0     1.1.12.65        255.255.255.0        UG    0      
0        0     tun0
default            10.0.0.10        0.0.0.0                     UG    
0      0        0     eth0
----------------

---- client config file ----
daemon
client
dev tun
proto tcp-client
remote 172.19.1.73 1195
remote 70.55.243.120 1195
resolv-retry 0
nobind
persist-key
persist-tun
ns-cert-type server
ca ca.crt
cert client.crt
key client.key
route-up /usr/local/sbin/openvpn-post-connect.pl
verb 1
mute 22
--------------


The post connect script just syncs new config files if they had changed.


Thanks for reading....

Cheers,

Mark

