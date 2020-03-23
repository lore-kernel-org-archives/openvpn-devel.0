Date: Mon, 23 Mar 2020 17:11:56 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20200323171156.295122f1@...1661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello list,

There seems to be some kind of alignment problem in OpenVPN 2.4
versions on ARMv4 based machines (32 bit), especially when lzo 
compression kicks in.

History: 
--------------------
We run OpenVPN 2.3 happily on a ARMv4 machine. Now we want to upgrade
to 2.4 because of automatically negotiated AES instead of BlowFish. The
configuration is unchanged, only OpenVPN and OpenSSL get upgraded. The
tunnel gets up, but some traffic is dropped on the OpenVPN server side
MULTI: bad source address from client [10.1.0.75], packet dropped


Short version of the story:
---------------------------
Only this helps:
 $ echo 3 > /proc/cpu/alignment
Compiling with CFLAGS="${CFLAGS} -DVERIFY_ALIGNMENT"
leads to a lot of alignment failure messages

Long version of the story:
--------------------------
- Authentication via certificates
- both server and client are ARMv4 based machines
- Tunnel IP net is 10.1.0.0/24
- LZO compression with --comp-lzo (adaptive)
- IP of OpenVPN server: 192.168.202.82/22
  IP of OVPN_Client1: 192.168.201.116/22
  IP of OVPN_Client2: 192.168.203.84/22

A ping from the OpenVPN client to the OpenVPN server works, 
as long the packet payload has a certain size
  $ ping 10.1.0.1 -s 350

The same ping situation but with a default payload ping failes:
  $ ping 10.1.0.1
The server complains with
Mon Mar 23 14:54:06 2020 us=663594 OVPN_Client1/192.168.201.116 MULTI: bad source address from client [10.1.0.75], packet dropped

Interesting: The source IP address is different with every ping packet
reaching the OpenVPN server: 10.1.0.XXX, with XXX is a random number
from 0 to 254. Eventually a ping becomes answered with a pong, when
luckily the correct tunnel IP address is used (chance is 1 to 255 :-)

With the bigger ping payload _every_ packet gets answered, because a
manually entered debug line prints the correct source address of the
packet.

Removing LZO compression also solves the problem: With --comp-lzo removed
from the client and server, no packets are dropped. We used LZO 2.06 and
2.10, they behave the same.

Modifying the cipher and/or the hash algorithm doesn't change anything,
even if no encryption is used at all (none)


Then I compilied OpenVPN (all of the three versions) with
   CFLAGS="${CFLAGS} -DVERIFY_ALIGNMENT"
and started OpenVPN very verbose (verb 14).

This is tail -f /var/log/openvpn.log | grep ERROR:
Mon Mar 23 13:25:59 2020 us=740000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at mss.c/56 ptr=0x00c3ece8 OLC=537/84/2562 I=/1077682176
Mon Mar 23 13:26:00 2020 us=660000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at mroute.h/196 ptr=0x00bfec30 OLC=461/84/2562 I=crypto.c/397
Mon Mar 23 13:26:00 2020 us=690000 OVPN_Client1/192.168.201.116:49610 ERROR: Alignment at proto.c/48 ptr=0x00c3ece8 OLC=461/84/2562 I=/1077682176
Mon Mar 23 13:26:00 2020 us=690000 OVPN_Client1/192.168.201.116:49610 ERROR: Alignment at mss.c/56 ptr=0x00c3ece8 OLC=461/84/2562 I=/1077682176
Mon Mar 23 13:26:00 2020 us=720000 OVPN_Client1/192.168.201.116:49610 ERROR: Alignment at mroute.h/196 ptr=0x00bfec30 OLC=537/84/2562 I=crypto.c/573
Mon Mar 23 13:26:00 2020 us=750000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at proto.c/48 ptr=0x00c3ece8 OLC=537/84/2562 I=/1077682176
Mon Mar 23 13:26:00 2020 us=750000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at mss.c/56 ptr=0x00c3ece8 OLC=537/84/2562 I=/1077682176
Mon Mar 23 13:26:01 2020 us=710000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at mroute.h/196 ptr=0x00bfec30 OLC=461/84/2562 I=crypto.c/397
Mon Mar 23 13:26:01 2020 us=730000 OVPN_Client1/192.168.201.116:49610 ERROR: Alignment at proto.c/48 ptr=0x00c3ece8 OLC=461/84/2562 I=/1077682176
Mon Mar 23 13:26:01 2020 us=730000 OVPN_Client1/192.168.201.116:49610 ERROR: Alignment at mss.c/56 ptr=0x00c3ece8 OLC=461/84/2562 I=/1077682176
Mon Mar 23 13:26:01 2020 us=770000 OVPN_Client1/192.168.201.116:49610 ERROR: Alignment at mroute.h/196 ptr=0x00bfec30 OLC=537/84/2562 I=crypto.c/573
Mon Mar 23 13:26:01 2020 us=800000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at proto.c/48 ptr=0x00c43188 OLC=537/84/2562 I=/1077682176
Mon Mar 23 13:26:01 2020 us=800000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at mss.c/56 ptr=0x00c43188 OLC=537/84/2562 I=/1077682176
Mon Mar 23 13:26:02 2020 us=680000 OVPN_Client2/192.168.202.84:53155 ERROR: Alignment at mroute.h/196 ptr=0x00bfec30 OLC=461/84/2562 I=crypto.c/397
....

The only thing that I know of until now, that 
makes the packets not get dropped is:
  $ echo 3 > /proc/cpu/alignment


Now every packet gets transported, none are 
dropped any longer.

The ERRORS are still there, but few of them:
Mon Mar 23 14:53:12 2020 us=753594 OVPN_Client1/192.168.201.116 ERROR: Alignment at mroute.h/196 ptr=0x00f6c598 OLC=537/84/2562 I=crypto.c/574
Mon Mar 23 14:53:13 2020 us=763594 OVPN_Client1/192.168.201.116 ERROR: Alignment at mroute.h/196 ptr=0x00f6c598 OLC=537/84/2562 I=crypto.c/574
Mon Mar 23 14:53:14 2020 us=773594 OVPN_Client1/192.168.201.116 ERROR: Alignment at mroute.h/196 ptr=0x00f6c598 OLC=537/84/2562 I=crypto.c/574
Mon Mar 23 14:53:15 2020 us=783594 OVPN_Client1/192.168.201.116 ERROR: Alignment at mroute.h/196 ptr=0x00f6c598 OLC=537/84/2562 I=crypto.c/574
Mon Mar 23 14:53:16 2020 us=793594 OVPN_Client1/192.168.201.116 ERROR: Alignment at mroute.h/196 ptr=0x00f6c598 OLC=537/84/2562 I=crypto.c/574
....


Tested on versions:
-------
OpenVPN version 2.4.8, 2.4.3 and 2.4.2
Used LZO 2.10
Used OpenSSL 1.1.1d and 1.0.2d

OpenVPN 2.4.2 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Mar 23 2020
library versions: OpenSSL 1.0.2n  7 Dec 2017, LZO 2.10
Originally developed by James Yonan
Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>

OpenVPN 2.4.3 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Mar 23 2020
library versions: OpenSSL 1.1.1d  10 Sep 2019, LZO 2.10
Originally developed by James Yonan
Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>

OpenVPN 2.4.8 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Mar 23 2020
library versions: OpenSSL 1.1.1d  10 Sep 2019, LZO 2.10
Originally developed by James Yonan
Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>



For the sake of completenes here is the server config file:
-------
max-routes 300
server 10.1.0.0 255.255.255.0
server-ipv6 fd19:433a:30e5:0c2c::/64
dh /etc/openvpn/lan/server/dh.pem
ca /etc/openvpn/lan/server/ca.crt
key /etc/openvpn/lan/server/private.key
cert /etc/openvpn/lan/server/cert.crt
proto udp
lport 1194
rport 1194
comp-lzo
cipher AES-256-CBC
auth sha256
tun-mtu 1500
reneg-sec 3600
ping 30
ping-restart 60
verb 14
dev tun
client-to-client
client-config-dir /etc/openvpn/lan/ccd
push "route 192.168.1.0 255.255.255.0"
push  "route-ipv6 fdb8:fead:4164:38f6::/64"
management /var/run/openvpnd_lan.socket unix
explicit-exit-notify 1
route 192.168.2.0 255.255.255.0
push "route 192.168.2.0 255.255.255.0"
route 192.168.4.0 255.255.255.0
push "route 192.168.4.0 255.255.255.0"


And the configuration of one client:
--------
max-routes 300
client
remote 192.168.202.82
ca /etc/openvpn/lan/client/ca.crt
key /etc/openvpn/lan/client/private.key
cert /etc/openvpn/lan/client/cert.crt
proto udp
lport 1194
rport 1194
nobind
comp-lzo
cipher AES-256-CBC
auth sha256
tun-mtu 1500
reneg-sec 3600
ping 30
ping-restart 60
verb 3
dev tun
tun-ipv6
float
management /var/run/openvpn_lan.socket unix

-- 
Servus
  Michael

