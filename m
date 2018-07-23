Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
From: Adam <adam@...1031...>
In-Reply-To: <20180719062932.GS55859@...1296...>
Date: Mon, 23 Jul 2018 16:51:53 +0200
Message-Id: <0091DE50-2189-4819-A5B8-7412C8FC32B9@...1031...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
 <20180719062932.GS55859@...1296...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

>> It turns out, NetBSD needs similar handling of subnet topology for tun i=
nterfaces as OpenBSD does.
>>=20
>> Here is a patch to fix the issue (against OpenVPN 2.4.6):
>=20
> This comes as a bit of surprise - has something changed here on the
> NetBSD side?  Which NetBSD version did you test this against, how=20
> does the problem manifest itself?
>=20
> I do run CI tests on various NetBSD versions, and never had an issue
> with --topology subnet there...

I tried both NetBSD-7.1 and NetBSD-current (which is now at 8.99.21), and m=
y OpenVPN setup does not work without the patch. On server side, I use a si=
mple config like this (certificate sections omitted):

local 192.168.56.1
proto tcp-server
dev tun
topology subnet
persist-tun
persist-key

server 10.1.0.0 255.255.0.0
client-config-dir /dist/pkg/etc/openvpn/ccd

tls-server
tls-auth static.key 0


On client side (NetBSD) it looks like this:

remote 192.168.56.1 1194
proto tcp-client
dev tun
persist-tun
persist-key

tls-client
nobind
remote-cert-tls server
tls-auth static.key 1
auth-nocache
pull


tun0 interface and routing are configured as these:

% ifconfig tun0
tun0: flags=3D8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
	inet 10.1.0.2 -> 10.1.0.2 netmask 0xffff0000
	inet6 fe80::a00:27ff:fef1:6df7%tun0 ->  prefixlen 64 scopeid 0x4
% route -n show | grep 10.1
10.1.0.2           10.1.0.2           UH          -        -      -  tun0


and the VPN network is unreachable (e.g. can't ping 10.1.0.1).
However, with the patch applied, the network looks this:

% ifconfig tun0
tun0: flags=3D8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
	inet 10.1.0.2 -> 10.1.0.1 netmask 0xffff0000
	inet6 fe80::a00:27ff:fef1:6df7%tun0 ->  prefixlen 64 scopeid 0x4
% route -n show | grep 10.1
10.1/16            10.1.0.1           UG          -        -      -  tun0
10.1.0.1           10.1.0.2           UH          -        -      -  tun0

and VPN works correctly.


Hoping that clarifies your concern. :)

Kind regards,
Adam
