Message-Id: <200308200943.h7K9h595018603@...89...>
From: "oyk" <oyk@...89...>
Mime-Version: 1.0
Subject: [Openvpn-devel] my problem on openvpn with tap device.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Aug 20 03:37:19 2003
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 7bit
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi, all
  I am testing on the openvpn(version 1.5beta5). 
  I want to know whether the openvpn can control multi-client connections simultaneously.
My case environment:  
  two client boxes: one is a windowxp box(10.1.0.176), the other is a linux box(10.1.0.178).

  Server:   one linux box(10.1.0.232)
#ifconfig (on the server box)
eth0      Link encap:Ethernet  HWaddr 00:07:E9:D4:17:05  
          inet addr:10.1.0.232  Bcast:10.1.1.255  Mask:255.255.254.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1375385 errors:0 dropped:0 overruns:0 frame:18
          TX packets:26317 errors:0 dropped:0 overruns:0 carrier:0
          collisions:1232 txqueuelen:100 
          RX bytes:436079888 (415.8 Mb)  TX bytes:4750120 (4.5 Mb)
          Interrupt:18 

eth1      Link encap:Ethernet  HWaddr 00:07:E9:D4:17:06  
          inet addr:192.168.201.1  Bcast:192.168.201.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2524 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4001 errors:0 dropped:0 overruns:0 carrier:0
          collisions:9 txqueuelen:100 
          RX bytes:538445 (525.8 Kb)  TX bytes:349456 (341.2 Kb)
          Interrupt:19 Base address:0x2000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:3725 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3725 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:265761 (259.5 Kb)  TX bytes:265761 (259.5 Kb)

 In the 192.168.201.0/24 subnetwork, there is one internal box, whose ip is 192.168.201.2. 
Absolutely, it is only connected the Server by one twisted-pair directly. 
 My purpose: the client boxes can access 192.168.201.0/25 subnetwork simultaneously. 
In other words, I can access the 192.168.201.2 box from windowsxp client box and linux 
client box simultaneously.
 
 The follow are my configuration:
On the windowsxp client box(10.1.0.176):
remote 10.1.0.232
dev tap
dev-node my-tap
secret key.txt
ping 10
verb 5

my=tap IP: 192.168.1.2
myroute.bat: route add 192.168.201.0 mask 255.255.255.0 192.168.1.2

On linux client box(10.1.0.178): 
remote 10.1.0.232
dev tap
up ./tap.up
secret key.txt
ping 10
verb 5

tap.up
#!/bin/bash
ifconfig $1 192.168.1.3 netmask 255.255.255.0 mtu $2
route add -net 192.168.201.0 netmask 255.255.255.0 gw $5

On the Server:
dev tap
up ./tap.up
secret key.txt
ping 10
verb 5

On the Server firewall rules:

#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward
PRIVATE=192.168.201.0/24
LOOP=127.0.0.1
iptables -F 
iptables -P OUTPUT ACCEPT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -i eth0 -s $LOOP -j DROP
iptables -A FORWARD -i eth0 -s $LOOP -j DROP
iptables -A INPUT -i eth0 -d $LOOP -j DROP
iptables -A FORWARD -i eth0 -d $LOOP -j DROP
iptables -A FORWARD -s ! $PRIVATE -i eth1 -j DROP
iptables -A INPUT -s $LOOP -j ACCEPT
iptables -A INPUT -d $LOOP -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p udp --dport 5000 -j ACCEPT
iptables -A INPUT -i tap+ -j ACCEPT
iptables -A FORWARD -i tap+ -j ACCEPT
iptables -A INPUT -i eth1 -j ACCEPT
iptables -A FORWARD -i eth1 -j ACCEPT
iptables -A OUTPUT -m state --state NEW -o eth0 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state NEW -o eth0 -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -s $PRIVATE -o eth0 -j MASQUERADE

My test steps:
On the Server side:
1. openvpn --config server.conf
2. sh firewall.sh
3.tcpdump  -s 1518 -lennx -i tap0 |tcpshow -cooked  (on another console)
On the linux client box:
4. openvpn --config linuxclient.conf
5. ping 192.168.1.1 (OK!)
tcpdump shows:
tcpdump: listening on tap0
---------------------------------------------------------------------------
Packet 1
TIME:   17:29:38.755258
ARP:    192.168.1.3 (00:FF:CD:30:4B:A1) asks where is 192.168.1.1
---------------------------------------------------------------------------
Packet 2
TIME:   17:29:38.755282 (0.000024)
ARP:    192.168.1.1 says to 192.168.1.3 it's at 00:FF:29:2D:B4:96
---------------------------------------------------------------------------
Packet 3
TIME:   17:29:38.756636 (0.001354)
ICMP:   192.168.1.3 -> 192.168.1.1 echo-request
DATA:   W6...>C?.s...
................. !"#$%&'()*+,-./01234567
---------------------------------------------------------------------------
Packet 4
TIME:   17:29:38.756696 (0.000060)
ICMP:   192.168.1.1 -> 192.168.1.3 echo-reply
DATA:   W6...>C?.s...
................. !"#$%&'()*+,-./01234567
---------------------------------------------------------------------------
6. ping 192.168.201.1 (OK!)
tcpdump shows:
---------------------------------------------------------------------------
Packet 1
TIME:   17:32:57.138120
ICMP:   192.168.1.3 -> 192.168.201.1 echo-request
DATA:   Y6..g?C?}....
................. !"#$%&'()*+,-./01234567
---------------------------------------------------------------------------
Packet 2
TIME:   17:32:57.138162 (0.000042)
ICMP:   192.168.201.1 -> 192.168.1.3 echo-reply
DATA:   Y6..g?C?}....
................. !"#$%&'()*+,-./01234567
---------------------------------------------------------------------------
7. ping 192.168.201.2 (Fail!)
On the server side, OpenVPN shows: RRRRR...
On the client side, OpenVPN shows: WWWWW...
and tcpdump shows:
tcpdump: listening on tap0
---------------------------------------------------------------------------
Packet 1
TIME:   17:33:45.569484
ARP:    192.168.1.3 (00:FF:CD:30:4B:A1) asks where is 192.168.201.2
---------------------------------------------------------------------------
Packet 2
TIME:   17:33:46.569419 (0.999935)
ARP:    192.168.1.3 (00:FF:CD:30:4B:A1) asks where is 192.168.201.2
---------------------------------------------------------------------------

Now, I try to start my windows box:
On the windowsxp box:
8. start openvpn 
On the server side shows:
Wed Aug 20 17:35:36 2003 96[0]: Peer Connection Initiated with 10.1.1.176:5000
RRRRWed Aug 20 17:35:37 2003 97[0]: Authenticate/Decrypt packet error: bad packet ID (may be a replay): [ #167 / time = (1061371483) Wed Aug 20 17:24:43 2003 ]
Now, the linux client box is interruptted, I can not access the OpenVPN Server from my linux box. 
And, the windowsxp client box setup OpenVPN environment. The result are the same as linux client box.

And, Wether do the OpenVPN have only one simultaneously alive client?

And, I cann't access the internal subnetwork, why?
The same configurations, I use tun device, I can access internal subnetwork without any problem. 
   Thank you, everybody!
Best Regards
  Ouyang Kai



