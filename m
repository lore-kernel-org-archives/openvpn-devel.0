Subject: Re: [Openvpn-devel] Multicast over TAP w/ OpenVPN 2.0
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083369518.38148@...41...>
In-Reply-To: <loom.20040429T195254-378@...171...>
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
Date: Fri Apr 30 16:59:01 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Zhen Xu <zhen@...55...>, openvpn-devel@lists.sourceforge.net

Zhen Xu <zhen@...55...> said:

> Hi,
> 
> I am testing the latest OpenVPN 2.0 with quagga. The server is configured to 
> run in server mode with TAP interface. I can bring up the VPN link no problem 
> and I can do connectivities between two hosts without any problem. My goal is 
> to run OSPF with Quagga over the OpenVPN link. I have been using OpenVPN 1.x 
> with TUN devices with Quagga OSPF without any problems for more than a year. 
> 
> Server A/TLS Server
> 
> (openvpn.conf)
> 
> port 5000
> dev tap0
> tls-server
> ca ca.cert
> cert hosta.cert
> key hosta.key
> dh dh2048.pem
> mode server
> client-config-dir /opt/openvpn-2.0/etc
> ifconfig 192.168.36.1 255.255.255.224
> ifconfig-pool 192.168.36.21 192.168.36.30
> push "ping 5"
> push "ping-restart 15"
> push "ping-timer-rem"
> push "inactive 30"
> ping 5
> ping-restart 15
> ping-timer-rem
> persist-tun
> persist-key
> passtos
> comp-lzo
> cipher AES-256-CBC
> auth RSA-SHA1-2
> askpass
> 
> Server B/TLS Client
> 
> (openvpn.conf)
> 
> port 5000
> dev tap0
> remote XXX.XXX.XXX.XXX
> tls-client
> ca ca.cert
> cert hostb.cert
> key hostb.key
> resolv-retry infinite
> pull
> persist-tun
> persist-key
> cipher AES-256-CBC
> auth RSA-SHA1-2
> askpass
> comp-lzo
> passtos
> 
> Once the VPN link is up, Quagga can not establish links between two sides. 
> After looking into more by doing tcpdump on the TAP interface, I found the 
> following:
> 
> On TLS Server:
> 
> 14:01:09.980878 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:01:11.006828 192.168.36.1 > OSPF-ALL.MCAST.NET: OSPFv2-hello 48: backbone dr 
> 192.168.36.1 [tos 0xc0]  [ttl 1]
> 14:01:20.047635 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:01:21.007230 192.168.36.1 > OSPF-ALL.MCAST.NET: OSPFv2-hello 48: backbone dr 
> 192.168.36.1 [tos 0xc0]  [ttl 1]
> 14:01:29.983184 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:01:31.007617 192.168.36.1 > OSPF-ALL.MCAST.NET: OSPFv2-hello 48: backbone dr 
> 192.168.36.1 [tos 0xc0]  [ttl 1]
> 
> On TLS Client:
> 
> 14:00:29.962852 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:00:39.963003 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:00:49.963155 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:00:59.963306 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 14:01:09.963458 192.168.36.3 > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: backbone dr 
> 192.168.36.3 [tos 0xc0]  [ttl 1]
> 
> As you can see, on the TLS server side, traffic to and from the remote client 
> showed up on the TAP interface. However, on the TLS client side, only traffic 
> to the server showed up on the TAP interface and all traffic from the server 
> never showed up on the TAP interface. 
> 
> Then, I tried to do a broadcast ping on both ends with "ping -b 
> xxx.xxx.xxx.xxx" and ICMP echo and reply showed up on both ends on the TAP 
> interface.
> 
> Is this a bug related to OpenVPN or it is a setting issue?

Right now you could call it a bug, or maybe more accurately an unimplemented
feature.  There's a problem with OpenVPN 2.0 in multiclient mode + IP
Multicast.  Since the server to client direction requires that OpenVPN be a
router, IP multicast doesn't work correctly because OpenVPN does not have all
the extra smarts to be an IP multicast router.  What it currently does (at
least in tun interface mode) is treat an IP multicast like a broadcast.  In
tap interface mode, OpenVPN does ethernet bridging based on MAC addresses and
never even looks at the IP address in the packet to see if it's an mcast
address.  If the OS delivers to OpenVPN (via the tap interface) the ethernet
encapsulated mcast datagram with the MAC destination set to broadcast, i.e.
FF:FF:FF:FF:FF:FF, then OpenVPN should broadcast it to all clients.

Also note that if you're using native mrouted (without IP-in-IP tunnels), you
may need to override the network address and subnet mask of the tun/tap
interface to make everything work correctly.  I was trying to get this to work
myself and I found that mrouted has a bug (on linux) where it sees that the
tun interface has a subnet mask of 255.255.255.255 and dies immediately,
without checking to see if there's an interface override in the config file.

These are the solutions:

(1) Let the kernel do the routing.  That means falling back to one OpenVPN
daemon on each end of the tunnel, as in 1.x.

(2) Use a tun interface in OpenVPN 2.0 in multiclient mode.  This will treat
multicast like broadcast.

(3) Use multicast tunnels -- this will tunnel the multicast packets through
OpenVPN encapuslated in an IP-in-IP container which should work fine.

James


