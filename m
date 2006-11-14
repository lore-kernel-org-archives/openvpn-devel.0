Date: Mon, 13 Nov 2006 21:16:38 -0800
Message-ID: <20061114051638.GA32116@...887...>
Mime-Version: 1.0
From: tofu.0650@...887... (H.Shrikumar)
Subject: [Openvpn-devel] On the way from tun0 to eth1, packets disappearing.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: tofu.0650@...887...


Hi,

I have been trying to set up openvpn to cross-connect two LANs
together. I have a slightly complicated goal, and I believe
I have it almost(!) working, except that at one point, the
packets vanish without a trace. And it seems to vanish in the
kernel, of all places, which is rather puzzling!!

I have two LANs, and two identical routers (soekris/picodebian
linux boxes) connecting them together. Each has a openvpn
server and an openvpn client, connecting cross to the other. (I
have also tried it with just one link, but my problem is not
solved. Further, I think I need the symmetrical cross-connect
for a bunch of other reasons -- so unless this is a no-no,
please humour me).

LAN-America : has host   172.20.0.13
              has router 172.20.0.2, aka 172.20.1.1, 172.20.2.1
                running ovpn-server 172.20.7.1/24 tun0
                also running ovpn-client 172.20.8.4 tun1

[two openvpn connections criss-cross,
each tun1-client connects to the other tun0-server]

LAN-Europe  : has host   172.20.0.11
              has router 172.20.0.4, aka 172.20.3.1, 172.20.4.1, 172.20.1.100
                running ovpn-server 172.20.8.1/24 tun0
                also running ovpn-client 172.20.7.4 tun1

Essentially, I want 172.20.0.11 and 172.20.0.13 to both be
reachable transparently from both LANs, via the criss-cross
OpenVPN secured channel. The two channels give me symmetry.

Of course, local LANs are working ...
I can ping Router-America (172.20.0.2) from host 172.20.0.13 on LAN-America.
I can ping Router-Europe  (172.20.0.4) from host 172.20.0.11 on LAN-Europe.
The above pings are 0.6ms consistent with ethernet.

Also, openvpn is working ...
I can ping Router-America (172.20.0.2) from host 172.20.0.11 on LAN-Europe.
I can ping Router-Europe  (172.20.0.4) from host 172.20.0.13 on LAN-America.
The above pings are 4.6ms consistent with openvpn.

So far so good.

But when I ping host to host -- from 172.20.0.13 to 172.20.0.11
(ie. it has to come from LAN to Router, then over openvpn,
then encrypted to the far router and out to the LAN there),
something wierd happens. The packet disappears!

I ran a tcpdump on all six interfaces : four tun[01] interfaces
on both routers (Router-America tun0, tun1 and Router-Europe
tun0, tun1) and two ethernets on the LAN-hosts.

I see a icmp packet leave host-America 172.20.0.13 on its eth0
   presumably it arrives on the Router-Europe eth1, because next ...
I see it on Router-America on its tun1
   which is consistent with the push route metric 3 it got on its ovpn-client
I see it arrive on Router-Europe on its tun0
   which means that openvpn has done its job?              (Note A)
I have a known-good route in Router-Europe: route add 172.20.0.11 eth1
   so the kernel ought to forward the packet now.
But! the packet never appears on tcpdump -i eth1 !!        (Note B)
And it never appears on the 172.20.0.11 itself, of course.

Note A: Also, just to be sure, I looked -- I surely have
no sign of a "bad source address ... packet dropped" in
the openvpn syslogs.  This does mean that openvpn sent the
packet to the kernel, right? Also, this means it is not an
iroute related problem, right? The packet is going out on the
ovpn-client to the ovpn-server .. so thats another sign the
iroute is not an issue.

Note B: I also did a "watch ifconfig" on Router-Europe and see
packet counters corraborate that the packet arrived in the Rx
of tun0, but never goes out on the LAN-Europe eth1. Thats a
second observation that tallies with the tcpdump observation.

Another observation : very similar ... lets ping directly from
the router to the host on the other LAN, but with different
source address (which also means the ping goes out on the
other tun).

On Router-America:

ping 172.20.0.11  as well as,
ping -I tun1 172.20.0.11  -- goes out on tun1, replies come on tun1, and works.

ping -I tun0 172.20.0.11  -- goes out on tun0, replies come on tun0, ... 
  ... but, never deliver from tun0 to the locally running ping process!!

Is the kernel eating up the packet?
OpenVpn problem? TUN driver problem? kernel problem?

Yes, I have done an "iptables -F" on both routers to be sure. 
Yes, /proc/.../ip_forward is turned on. Just to be sure, I also 
turned on /proc/.../proxyarp on all interfaces -- made no diff.  

The configurations of openvpn, and routing tables are pasted
below.

Any clues? Or suggestions?


-- //Shrikumar



------------------------------------------------------------------------------
LAN-America : has host   172.20.0.13
              has router 172.20.0.2, aka 172.20.1.1, 172.20.2.1
                running ovpn-server 172.20.7.1/24 tun0
                also running ovpn-client 172.20.8.4 tun1

LAN-America:  server.conf is as follows :
 | port 1194
 | proto udp
 | dev tun
 | ca /etc/openvpn/certs/ca.crt
 | cert /etc/openvpn/certs/pulli.crt
 | key /etc/openvpn/private/pulli.key  # This file should be kept secret
 | dh /etc/openvpn/certs/dh1024-pulli.pem
 | server 172.20.7.0 255.255.255.0
 | ifconfig-pool-persist /etc/openvpn/ifconfig-pool-persist.txt
 | ifconfig-pool-linear 
 | push "route 172.20.0.0 255.255.255.0 172.20.7.1 3"
 | client-config-dir ccd
 | ccd-exclusive
 | client-to-client
 | keepalive 10 120
 | user nobody
 | group nogroup
 | chroot /etc/openvpn/gaol
 | persist-key
 | persist-tun
 | persist-local-ip
 | status /etc/openvpn/openvpn-status.log
 | verb 4
 | mute 20

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
172.20.0.13     0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.20.7.2      0.0.0.0         255.255.255.255 UH    0      0        0 tun0
172.20.0.11     172.20.8.1      255.255.255.255 UGH   0      0        0 tun1
172.20.0.10     0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.20.8.1      0.0.0.0         255.255.255.255 UH    0      0        0 tun1
172.20.0.3      0.0.0.0         255.255.255.255 UH    1      0        0 eth2
172.20.7.0      172.20.7.2      255.255.255.0   UG    0      0        0 tun0
isp-subnet      0.0.0.0         255.255.255.0   U     0      0        0 eth0
172.20.2.0      0.0.0.0         255.255.255.0   U     0      0        0 eth2
172.20.1.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.20.0.0      172.20.8.1      255.255.255.0   UG    3      0        0 tun1
172.20.8.0      172.20.8.1      255.255.255.0   UG    0      0        0 tun1
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         isp-router      0.0.0.0         UG    0      0        0 eth0

------------------------------------------------------------------------------
LAN-Europe  : has host   172.20.0.11
              has router 172.20.0.4, aka 172.20.3.1, 172.20.4.1, 172.20.1.100
                running ovpn-server 172.20.8.1/24 tun0
                also running ovpn-client 172.20.7.4 tun1

LAN-Europe :  server.conf is as follows :
 | port 1194
 | proto udp
 | dev tun
 | ca /etc/openvpn/certs/ca.crt
 | cert /etc/openvpn/certs/punkt.crt
 | key /etc/openvpn/private/punkt.key  # This file should be kept
 | secret
 | dh /etc/openvpn/certs/dh1024-punkt.pem
 | server 172.20.8.0 255.255.255.0
 | ifconfig-pool-persist /etc/openvpn/ifconfig-pool-persist.txt
 | ifconfig-pool-linear 
 | push "route 172.20.0.0 255.255.255.0 172.20.8.1 3"
 | client-config-dir ccd
 | client-to-client
 | keepalive 10 120
 | user nobody
 | group nogroup
 | chroot /etc/openvpn/gaol
 | persist-key
 | persist-tun
 | persist-local-ip
 | status /etc/openvpn/openvpn-status.log
 | verb 4
 | mute 20


Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
172.20.0.13     172.20.7.1      255.255.255.255 UGH   0      0        0 tun1
172.20.1.1      0.0.0.0         255.255.255.255 UH    0      0        0 eth0
172.20.7.1      0.0.0.0         255.255.255.255 UH    0      0        0 tun1
172.20.0.11     0.0.0.0         255.255.255.255 UH    1      0        0 eth1
172.20.8.2      0.0.0.0         255.255.255.255 UH    0      0        0 tun0
172.20.7.0      172.20.7.1      255.255.255.0   UG    0      0        0 tun1
172.20.4.0      0.0.0.0         255.255.255.0   U     0      0        0 eth2
172.20.3.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.20.0.0      172.20.7.1      255.255.255.0   UG    3      0        0 tun1
172.20.8.0      172.20.8.2      255.255.255.0   UG    0      0        0 tun0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         172.20.1.1      0.0.0.0         UG    0      0        0 eth0



