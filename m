Message-ID: <4C3843A5.50700@...1388...>
Date: Sat, 10 Jul 2010 21:55:49 +1200
From: Michal Ludvig <mludvig@...1388...>
MIME-Version: 1.0
Subject: [Openvpn-devel] feat_ipv6_payload problems on Solaris 10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

  Hi Gert & all,

I'm having a problem with feat_ipv6_payload branch (checked out from git 
yesterday). One end is Solaris 10 (sparc) and the other end is Linux.

IPv4 over the link works fine, however with IPv6 the Solaris end doesn't 
seem to see the incoming v6 traffic. I can see the packets coming on 
tun0 with snoop (tcpdump-like tool for Solaris) but the system ignores 
them. For instance ping from Solaris to Linux generates v6 ping request, 
Linux replies with v6 ping reply, the reply arrives to Solaris (verified 
by snoop) but the ping process never receives it and eventually times 
out with "no answer from <Linux v6 addr>". Similarly when I try telnet 
or ping from the Linux end I see the packets coming on tun0 but they are 
not processed. I can ping the Solaris' v6 tun0 address locally, so the 
address is assigned and interface is up. It behaves just like if there 
was an ingress v6 firewall on the Solaris box but the pfil (packet 
filter) service is disable altogether.

Here is what I use on Solaris:

~/src/openvpn-gert-ipv6.git # /opt/openvpn/sbin/openvpn --dev tun 
--secret /etc/openvpn/static.key \
       --verb 3 \
       --ifconfig 172.29.1.1 172.29.1.2
       --ifconfig-ipv6 2001:cafe::1/64 2001:cafe::2 --tun-ipv6
Sat Jul 10 19:34:30 2010 OpenVPN 2.1.1b sparc-sun-solaris2.10 [SSL] 
[LZO2] [IPv6 payload 20100307-1] built on Jul 10 2010
Sat Jul 10 19:34:30 2010 Static Encrypt: Cipher 'BF-CBC' initialized 
with 128 bit key
Sat Jul 10 19:34:30 2010 Static Encrypt: Using 160 bit message hash 
'SHA1' for HMAC authentication
Sat Jul 10 19:34:30 2010 Static Decrypt: Cipher 'BF-CBC' initialized 
with 128 bit key
Sat Jul 10 19:34:30 2010 Static Decrypt: Using 160 bit message hash 
'SHA1' for HMAC authentication
Sat Jul 10 19:34:30 2010 TUN/TAP device tun0 opened
Sat Jul 10 19:34:30 2010 do_ifconfig, tt->ipv6=1
Sat Jul 10 19:34:30 2010 /usr/sbin/ifconfig tun0 172.29.1.1 172.29.1.2 
mtu 1500 up
Sat Jul 10 19:34:30 2010 /usr/sbin/ifconfig tun0 netmask 255.255.255.255
Sat Jul 10 19:34:30 2010 /usr/sbin/ifconfig tun0 inet6 unplumb
Sat Jul 10 19:34:30 2010 /usr/sbin/ifconfig tun0 inet6 plumb 
2001:cafe::1/64 2001:cafe::2 up
Sat Jul 10 19:34:30 2010 Data Channel MTU parms [ L:1544 D:1450 EF:44 
EB:4 ET:0 EL:0 ]
Sat Jul 10 19:34:30 2010 Local Options hash (VER=V4): '9a8635be'
Sat Jul 10 19:34:30 2010 Expected Remote Options hash (VER=V4): '8faff290'
Sat Jul 10 19:34:30 2010 Socket Buffers: R=[57344->65536] S=[57344->65536]
Sat Jul 10 19:34:30 2010 UDPv4 link local (bound): [undef]:1194
Sat Jul 10 19:34:30 2010 UDPv4 link remote: [undef]
Sat Jul 10 19:35:15 2010 Peer Connection Initiated with ...
Sat Jul 10 19:35:17 2010 Initialization Sequence Completed

~/src/openvpn-gert-ipv6.git # ifconfig -a
[...]
tun0: 
flags=10010008d1<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST,IPv4,FIXEDMTU> 
mtu 1500 index 8
         inet 172.29.1.1 --> 172.29.1.2 netmask ffffffff
         ether 0:0:1:11:fb:b0
tun0: flags=2200851<UP,POINTOPOINT,RUNNING,MULTICAST,NONUD,IPv6> mtu 
1500 index 8
         inet6 2001:cafe::1/64 --> 2001:cafe::2
         ether 0:0:1:11:fb:b0

~/src/openvpn-gert-ipv6.git # netstat -rn -f inet6
Routing Table: IPv6
   Destination/Mask            Gateway                   Flags Ref   
Use    If
--------------------------- --------------------------- ----- --- 
------- -----
2001:cafe::2                2001:cafe::1                UH      1       
1 tun0


And on the Linux side:
~# /opt/openvpn-ipv6/sbin/openvpn --dev tunBarbucha --verb 3 --secret 
static.key --remote ... \
       --ifconfig 172.29.1.2 172.29.1.1
       --ifconfig-ipv6 2001:cafe::2/64 2001:cafe::1 --tun-ipv6
Sat Jul 10 19:36:47 2010 OpenVPN 2.1.1b x86_64-suse-linux-gnu [SSL] 
[LZO2] [EPOLL] [IPv6 payload 20100307-1] built on Jul 10 2010
Sat Jul 10 19:36:47 2010 Static Encrypt: Cipher 'BF-CBC' initialized 
with 128 bit key
Sat Jul 10 19:36:47 2010 Static Encrypt: Using 160 bit message hash 
'SHA1' for HMAC authentication
Sat Jul 10 19:36:47 2010 Static Decrypt: Cipher 'BF-CBC' initialized 
with 128 bit key
Sat Jul 10 19:36:47 2010 Static Decrypt: Using 160 bit message hash 
'SHA1' for HMAC authentication
Sat Jul 10 19:36:48 2010 TUN/TAP device tunBarbucha opened
Sat Jul 10 19:36:48 2010 TUN/TAP TX queue length set to 100
Sat Jul 10 19:36:48 2010 do_ifconfig, tt->ipv6=1
Sat Jul 10 19:36:48 2010 /sbin/ifconfig tunBarbucha 172.29.1.2 
pointopoint 172.29.1.1 mtu 1500
Sat Jul 10 19:36:48 2010 /sbin/ifconfig tunBarbucha inet6 add 
2001:cafe::2/64
Sat Jul 10 19:36:48 2010 Data Channel MTU parms [ L:1544 D:1450 EF:44 
EB:4 ET:0 EL:0 ]
Sat Jul 10 19:36:48 2010 Local Options hash (VER=V4): '8faff290'
Sat Jul 10 19:36:48 2010 Expected Remote Options hash (VER=V4): '9a8635be'
Sat Jul 10 19:36:48 2010 Socket Buffers: R=[262144->131072] 
S=[262144->131072]
Sat Jul 10 19:36:48 2010 UDPv4 link local (bound): [undef]:1194
Sat Jul 10 19:36:48 2010 UDPv4 link remote: ...
Sat Jul 10 19:36:59 2010 Peer Connection Initiated with ...
Sat Jul 10 19:37:00 2010 Initialization Sequence Completed

~# ip a show dev tunBarbucha
22: tunBarbucha: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 
qdisc pfifo_fast state UNKNOWN qlen 100
     link/[65534]
     inet 172.29.1.2 peer 172.29.1.1/32 scope global tunBarbucha
     inet6 2001:cafe::2/64 scope global
        valid_lft forever preferred_lft forever

All looks good to me but still Solaris seems to ignore the incoming v6 
payload. Any ideas what's wrong?

Thanks

Michal

