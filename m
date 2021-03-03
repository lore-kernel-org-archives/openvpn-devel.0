MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Wed, 3 Mar 2021 15:46:45 +0800
Message-ID: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
Content-Type: multipart/alternative; boundary="0000000000002a5da905bc9d0e9d"
Subject: [Openvpn-devel] Segmentation fault in OpenVPN 2.6_git
 [git:dco/fcc852a9b2ea832c]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002a5da905bc9d0e9d
Content-Type: text/plain; charset="UTF-8"

Hi Arne,

I encountered segmentation fault in your dco branch. Master branch is OK. I
reverted the commit "Linux data-channel offload support", but it still
happens.
Anything wrong? Can you reproduce?

root@...2598...:/project/openvpn/schwabe/openvpn# gdb
./src/openvpn/openvpn GNU gdb (Ubuntu 9.2-0ubuntu1~20.04) 9.2 Copyright (C)
2020 Free Software Foundation, Inc. License GPLv3+: GNU GPL version 3 or
later <http://gnu.org/licenses/gpl.html> This is free software: you are
free to change and redistribute it. There is NO WARRANTY, to the extent
permitted by law. Type "show copying" and "show warranty" for details. This
GDB was configured as "x86_64-linux-gnu". Type "show configuration" for
configuration details. For bug reporting instructions, please see: <
http://www.gnu.org/software/gdb/bugs/>. Find the GDB manual and other
documentation resources online at: <
http://www.gnu.org/software/gdb/documentation/>. For help, type "help".
Type "apropos word" to search for commands related to "word"... Reading
symbols from ./src/openvpn/openvpn... (gdb) r --ifconfig 10.200.0.1
10.200.0.2 --dev tun Starting program:
/project/openvpn/schwabe/openvpn/src/openvpn/openvpn --ifconfig 10.200.0.1
10.200.0.2 --dev tun [Thread debugging using libthread_db enabled] Using
host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
2021-03-03 07:28:55 OpenVPN 2.6_git [git:dco/8be9bbd16b2c5e1b]
x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD]
[DCO] built on Mar 3 2021 2021-03-03 07:28:55 library versions: OpenSSL
1.1.1f 31 Mar 2020, LZO 2.10 2021-03-03 07:28:55 ******* WARNING *******:
All encryption and authentication features disabled -- All data will be
tunnelled as clear text and will not be protected against man-in-the-middle
changes. PLEASE DO RECONSIDER THIS CONFIGURATION! 2021-03-03 07:28:55
sitnl_send: rtnl: generic error (-17): File exists 2021-03-03 07:28:55
net_iface_mtu_set: mtu 1500 for ovpn-dco1 2021-03-03 07:28:55 net_iface_up:
set ovpn-dco1 up 2021-03-03 07:28:55 net_addr_ptp_v4_add: 10.200.0.1 peer
10.200.0.2 dev ovpn-dco1 2021-03-03 07:28:55 Could not determine IPv4/IPv6
protocol. Using AF_INET 2021-03-03 07:28:55 UDPv4 link local (bound):
[AF_INET][undef]:1194 2021-03-03 07:28:55 UDPv4 link remote: [AF_UNSPEC]
Program received signal SIGSEGV, Segmentation fault. encrypt_sign
(c=c@...1851...=0x7fffffffd2b0,
comp_frag=comp_frag@...1851...=true) at forward.c:567 567 if
(c->c2.tls_multi->context_auth != CAS_SUCCEEDED)

Tony

--0000000000002a5da905bc9d0e9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<div><br></div><div>I encountered segmentation fau=
lt in your dco branch. Master branch is OK. I reverted the commit=C2=A0&quo=
t;Linux data-channel offload support&quot;, but it still happens.</div><div=
>Anything wrong? Can you reproduce?</div><div><br></div><div><div style=3D"=
white-space:pre-wrap">
 root@...2598...:/project/openvpn/schwabe/openvpn# gdb ./src/openvpn/openvpn
GNU gdb (Ubuntu 9.2-0ubuntu1~20.04) 9.2
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.org/li=
censes/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type &quot;show copying&quot; and &quot;show warranty&quot; for details.
This GDB was configured as &quot;x86_64-linux-gnu&quot;.
Type &quot;show configuration&quot; for configuration details.
For bug reporting instructions, please see:
&lt;<a href=3D"http://www.gnu.org/software/gdb/bugs/">http://www.gnu.org/so=
ftware/gdb/bugs/</a>&gt;.
Find the GDB manual and other documentation resources online at:
    &lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/">http://w=
ww.gnu.org/software/gdb/documentation/</a>&gt;.

For help, type &quot;help&quot;.
Type &quot;apropos word&quot; to search for commands related to &quot;word&=
quot;...
Reading symbols from ./src/openvpn/openvpn...
(gdb) r --ifconfig 10.200.0.1 10.200.0.2 --dev tun
Starting program: /project/openvpn/schwabe/openvpn/src/openvpn/openvpn --if=
config 10.200.0.1 10.200.0.2 --dev tun
[Thread debugging using libthread_db enabled]
Using host libthread_db library &quot;/lib/x86_64-linux-gnu/libthread_db.so=
.1&quot;.
2021-03-03 07:28:55 OpenVPN 2.6_git [git:dco/8be9bbd16b2c5e1b] x86_64-pc-li=
nux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built=
 on Mar  3 2021
2021-03-03 07:28:55 library versions: OpenSSL 1.1.1f  31 Mar 2020, LZO 2.10
2021-03-03 07:28:55 ******* WARNING *******: All encryption and authenticat=
ion features disabled -- All data will be tunnelled as clear text and will =
not be protected against man-in-the-middle changes. PLEASE DO RECONSIDER TH=
IS CONFIGURATION!
2021-03-03 07:28:55 sitnl_send: rtnl: generic error (-17): File exists
2021-03-03 07:28:55 net_iface_mtu_set: mtu 1500 for ovpn-dco1
2021-03-03 07:28:55 net_iface_up: set ovpn-dco1 up
2021-03-03 07:28:55 net_addr_ptp_v4_add: 10.200.0.1 peer 10.200.0.2 dev ovp=
n-dco1
2021-03-03 07:28:55 Could not determine IPv4/IPv6 protocol. Using AF_INET
2021-03-03 07:28:55 UDPv4 link local (bound): [AF_INET][undef]:1194
2021-03-03 07:28:55 UDPv4 link remote: [AF_UNSPEC]

Program received signal SIGSEGV, Segmentation fault.
encrypt_sign (c=3Dc@...1851...=3D0x7fffffffd2b0, comp_frag=3Dcomp_frag@...1386...=
851...=3Dtrue) at forward.c:567
567         if (c-&gt;c2.tls_multi-&gt;context_auth !=3D CAS_SUCCEEDED)
        </div></div><div style=3D"white-space:pre-wrap"><br></div><div styl=
e=3D"white-space:pre-wrap">Tony</div></div>

--0000000000002a5da905bc9d0e9d--

