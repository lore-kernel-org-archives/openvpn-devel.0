MIME-Version: 1.0
References: <20200323171156.295122f1@...1661...>
In-Reply-To: <20200323171156.295122f1@...1661...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 23 Mar 2020 22:00:12 +0500
Message-ID: <CAFHpkQFbK8138bC8q0k8bC47yGWOJdhdE2OS2Obb8aqhiu9g=Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000033af8505a18892f3"
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Kress <lists@...1660...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000033af8505a18892f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thank you for wonderful investigation.


however, are there reasons for using lzo ? it consumes too much cpu
(comparing to lz4). also, it highly depends on traffic itself, many
application already compress their bytes themselves.

if you are stick to lzo, because it is propagated to all configs, in 2.4
you can push compression options just like dhcp option from server to
clients (and it wins over the config file).

=D0=BF=D0=BD, 23 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 21:29, Michael Kre=
ss <lists@...1660...>:

> Hello list,
>
> There seems to be some kind of alignment problem in OpenVPN 2.4
> versions on ARMv4 based machines (32 bit), especially when lzo
> compression kicks in.
>
> History:
> --------------------
> We run OpenVPN 2.3 happily on a ARMv4 machine. Now we want to upgrade
> to 2.4 because of automatically negotiated AES instead of BlowFish. The
> configuration is unchanged, only OpenVPN and OpenSSL get upgraded. The
> tunnel gets up, but some traffic is dropped on the OpenVPN server side
> MULTI: bad source address from client [10.1.0.75], packet dropped
>
>
> Short version of the story:
> ---------------------------
> Only this helps:
>  $ echo 3 > /proc/cpu/alignment
> Compiling with CFLAGS=3D"${CFLAGS} -DVERIFY_ALIGNMENT"
> leads to a lot of alignment failure messages
>
> Long version of the story:
> --------------------------
> - Authentication via certificates
> - both server and client are ARMv4 based machines
> - Tunnel IP net is 10.1.0.0/24
> - LZO compression with --comp-lzo (adaptive)
> - IP of OpenVPN server: 192.168.202.82/22
>   IP of OVPN_Client1: 192.168.201.116/22
>   IP of OVPN_Client2: 192.168.203.84/22
>
> A ping from the OpenVPN client to the OpenVPN server works,
> as long the packet payload has a certain size
>   $ ping 10.1.0.1 -s 350
>
> The same ping situation but with a default payload ping failes:
>   $ ping 10.1.0.1
> The server complains with
> Mon Mar 23 14:54:06 2020 us=3D663594 OVPN_Client1/192.168.201.116 MULTI:
> bad source address from client [10.1.0.75], packet dropped
>
> Interesting: The source IP address is different with every ping packet
> reaching the OpenVPN server: 10.1.0.XXX, with XXX is a random number
> from 0 to 254. Eventually a ping becomes answered with a pong, when
> luckily the correct tunnel IP address is used (chance is 1 to 255 :-)
>
> With the bigger ping payload _every_ packet gets answered, because a
> manually entered debug line prints the correct source address of the
> packet.
>
> Removing LZO compression also solves the problem: With --comp-lzo removed
> from the client and server, no packets are dropped. We used LZO 2.06 and
> 2.10, they behave the same.
>
> Modifying the cipher and/or the hash algorithm doesn't change anything,
> even if no encryption is used at all (none)
>
>
> Then I compilied OpenVPN (all of the three versions) with
>    CFLAGS=3D"${CFLAGS} -DVERIFY_ALIGNMENT"
> and started OpenVPN very verbose (verb 14).
>
> This is tail -f /var/log/openvpn.log | grep ERROR:
> Mon Mar 23 13:25:59 2020 us=3D740000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D537/84/2562 I=3D/1077=
682176
> Mon Mar 23 13:26:00 2020 us=3D660000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D461/84/2562
> I=3Dcrypto.c/397
> Mon Mar 23 13:26:00 2020 us=3D690000 OVPN_Client1/192.168.201.116:49610
> ERROR: Alignment at proto.c/48 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/10=
77682176
> Mon Mar 23 13:26:00 2020 us=3D690000 OVPN_Client1/192.168.201.116:49610
> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/1077=
682176
> Mon Mar 23 13:26:00 2020 us=3D720000 OVPN_Client1/192.168.201.116:49610
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D537/84/2562
> I=3Dcrypto.c/573
> Mon Mar 23 13:26:00 2020 us=3D750000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at proto.c/48 ptr=3D0x00c3ece8 OLC=3D537/84/2562 I=3D/10=
77682176
> Mon Mar 23 13:26:00 2020 us=3D750000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D537/84/2562 I=3D/1077=
682176
> Mon Mar 23 13:26:01 2020 us=3D710000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D461/84/2562
> I=3Dcrypto.c/397
> Mon Mar 23 13:26:01 2020 us=3D730000 OVPN_Client1/192.168.201.116:49610
> ERROR: Alignment at proto.c/48 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/10=
77682176
> Mon Mar 23 13:26:01 2020 us=3D730000 OVPN_Client1/192.168.201.116:49610
> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/1077=
682176
> Mon Mar 23 13:26:01 2020 us=3D770000 OVPN_Client1/192.168.201.116:49610
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D537/84/2562
> I=3Dcrypto.c/573
> Mon Mar 23 13:26:01 2020 us=3D800000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at proto.c/48 ptr=3D0x00c43188 OLC=3D537/84/2562 I=3D/10=
77682176
> Mon Mar 23 13:26:01 2020 us=3D800000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at mss.c/56 ptr=3D0x00c43188 OLC=3D537/84/2562 I=3D/1077=
682176
> Mon Mar 23 13:26:02 2020 us=3D680000 OVPN_Client2/192.168.202.84:53155
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D461/84/2562
> I=3Dcrypto.c/397
> ....
>
> The only thing that I know of until now, that
> makes the packets not get dropped is:
>   $ echo 3 > /proc/cpu/alignment
>
>
> Now every packet gets transported, none are
> dropped any longer.
>
> The ERRORS are still there, but few of them:
> Mon Mar 23 14:53:12 2020 us=3D753594 OVPN_Client1/192.168.201.116 ERROR:
> Alignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c=
/574
> Mon Mar 23 14:53:13 2020 us=3D763594 OVPN_Client1/192.168.201.116 ERROR:
> Alignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c=
/574
> Mon Mar 23 14:53:14 2020 us=3D773594 OVPN_Client1/192.168.201.116 ERROR:
> Alignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c=
/574
> Mon Mar 23 14:53:15 2020 us=3D783594 OVPN_Client1/192.168.201.116 ERROR:
> Alignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c=
/574
> Mon Mar 23 14:53:16 2020 us=3D793594 OVPN_Client1/192.168.201.116 ERROR:
> Alignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c=
/574
> ....
>
>
> Tested on versions:
> -------
> OpenVPN version 2.4.8, 2.4.3 and 2.4.2
> Used LZO 2.10
> Used OpenSSL 1.1.1d and 1.0.2d
>
> OpenVPN 2.4.2 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
> [MH/PKTINFO] [AEAD] built on Mar 23 2020
> library versions: OpenSSL 1.0.2n  7 Dec 2017, LZO 2.10
> Originally developed by James Yonan
> Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>
> OpenVPN 2.4.3 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
> [MH/PKTINFO] [AEAD] built on Mar 23 2020
> library versions: OpenSSL 1.1.1d  10 Sep 2019, LZO 2.10
> Originally developed by James Yonan
> Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
>
> OpenVPN 2.4.8 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
> [MH/PKTINFO] [AEAD] built on Mar 23 2020
> library versions: OpenSSL 1.1.1d  10 Sep 2019, LZO 2.10
> Originally developed by James Yonan
> Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
>
>
>
> For the sake of completenes here is the server config file:
> -------
> max-routes 300
> server 10.1.0.0 255.255.255.0
> server-ipv6 fd19:433a:30e5:0c2c::/64
> dh /etc/openvpn/lan/server/dh.pem
> ca /etc/openvpn/lan/server/ca.crt
> key /etc/openvpn/lan/server/private.key
> cert /etc/openvpn/lan/server/cert.crt
> proto udp
> lport 1194
> rport 1194
> comp-lzo
> cipher AES-256-CBC
> auth sha256
> tun-mtu 1500
> reneg-sec 3600
> ping 30
> ping-restart 60
> verb 14
> dev tun
> client-to-client
> client-config-dir /etc/openvpn/lan/ccd
> push "route 192.168.1.0 255.255.255.0"
> push  "route-ipv6 fdb8:fead:4164:38f6::/64"
> management /var/run/openvpnd_lan.socket unix
> explicit-exit-notify 1
> route 192.168.2.0 255.255.255.0
> push "route 192.168.2.0 255.255.255.0"
> route 192.168.4.0 255.255.255.0
> push "route 192.168.4.0 255.255.255.0"
>
>
> And the configuration of one client:
> --------
> max-routes 300
> client
> remote 192.168.202.82
> ca /etc/openvpn/lan/client/ca.crt
> key /etc/openvpn/lan/client/private.key
> cert /etc/openvpn/lan/client/cert.crt
> proto udp
> lport 1194
> rport 1194
> nobind
> comp-lzo
> cipher AES-256-CBC
> auth sha256
> tun-mtu 1500
> reneg-sec 3600
> ping 30
> ping-restart 60
> verb 3
> dev tun
> tun-ipv6
> float
> management /var/run/openvpn_lan.socket unix
>
> --
> Servus
>   Michael
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000033af8505a18892f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>thank you for wonderful investigation.</div><div><br>=
</div><div><br></div><div>however, are there reasons for using lzo ? it con=
sumes too much cpu (comparing to lz4). also, it highly depends on traffic i=
tself, many application already compress their bytes themselves.</div><div>=
<br></div><div>if you are stick to lzo, because it is propagated to all con=
figs, in 2.4 you can push compression options just like dhcp option from se=
rver to clients (and it wins over the config file).<br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, =
23 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 21:29, Michael Kress &lt;<a href=
=3D"mailto:lists@...1660...">lists@...1660...</a>&gt;:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hello list,<br>
<br>
There seems to be some kind of alignment problem in OpenVPN 2.4<br>
versions on ARMv4 based machines (32 bit), especially when lzo <br>
compression kicks in.<br>
<br>
History: <br>
--------------------<br>
We run OpenVPN 2.3 happily on a ARMv4 machine. Now we want to upgrade<br>
to 2.4 because of automatically negotiated AES instead of BlowFish. The<br>
configuration is unchanged, only OpenVPN and OpenSSL get upgraded. The<br>
tunnel gets up, but some traffic is dropped on the OpenVPN server side<br>
MULTI: bad source address from client [10.1.0.75], packet dropped<br>
<br>
<br>
Short version of the story:<br>
---------------------------<br>
Only this helps:<br>
=C2=A0$ echo 3 &gt; /proc/cpu/alignment<br>
Compiling with CFLAGS=3D&quot;${CFLAGS} -DVERIFY_ALIGNMENT&quot;<br>
leads to a lot of alignment failure messages<br>
<br>
Long version of the story:<br>
--------------------------<br>
- Authentication via certificates<br>
- both server and client are ARMv4 based machines<br>
- Tunnel IP net is <a href=3D"http://10.1.0.0/24" rel=3D"noreferrer" target=
=3D"_blank">10.1.0.0/24</a><br>
- LZO compression with --comp-lzo (adaptive)<br>
- IP of OpenVPN server: <a href=3D"http://192.168.202.82/22" rel=3D"norefer=
rer" target=3D"_blank">192.168.202.82/22</a><br>
=C2=A0 IP of OVPN_Client1: <a href=3D"http://192.168.201.116/22" rel=3D"nor=
eferrer" target=3D"_blank">192.168.201.116/22</a><br>
=C2=A0 IP of OVPN_Client2: <a href=3D"http://192.168.203.84/22" rel=3D"nore=
ferrer" target=3D"_blank">192.168.203.84/22</a><br>
<br>
A ping from the OpenVPN client to the OpenVPN server works, <br>
as long the packet payload has a certain size<br>
=C2=A0 $ ping 10.1.0.1 -s 350<br>
<br>
The same ping situation but with a default payload ping failes:<br>
=C2=A0 $ ping 10.1.0.1<br>
The server complains with<br>
Mon Mar 23 14:54:06 2020 us=3D663594 OVPN_Client1/<a href=3D"http://192.168=
.201.116" rel=3D"noreferrer" target=3D"_blank">192.168.201.116</a> MULTI: b=
ad source address from client [10.1.0.75], packet dropped<br>
<br>
Interesting: The source IP address is different with every ping packet<br>
reaching the OpenVPN server: 10.1.0.XXX, with XXX is a random number<br>
from 0 to 254. Eventually a ping becomes answered with a pong, when<br>
luckily the correct tunnel IP address is used (chance is 1 to 255 :-)<br>
<br>
With the bigger ping payload _every_ packet gets answered, because a<br>
manually entered debug line prints the correct source address of the<br>
packet.<br>
<br>
Removing LZO compression also solves the problem: With --comp-lzo removed<b=
r>
from the client and server, no packets are dropped. We used LZO 2.06 and<br>
2.10, they behave the same.<br>
<br>
Modifying the cipher and/or the hash algorithm doesn&#39;t change anything,=
<br>
even if no encryption is used at all (none)<br>
<br>
<br>
Then I compilied OpenVPN (all of the three versions) with<br>
=C2=A0 =C2=A0CFLAGS=3D&quot;${CFLAGS} -DVERIFY_ALIGNMENT&quot;<br>
and started OpenVPN very verbose (verb 14).<br>
<br>
This is tail -f /var/log/openvpn.log | grep ERROR:<br>
Mon Mar 23 13:25:59 2020 us=3D740000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D537/84/2562 I=3D/1077=
682176<br>
Mon Mar 23 13:26:00 2020 us=3D660000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D461/84/2562 I=3Dc=
rypto.c/397<br>
Mon Mar 23 13:26:00 2020 us=3D690000 OVPN_Client1/<a href=3D"http://192.168=
.201.116:49610" rel=3D"noreferrer" target=3D"_blank">192.168.201.116:49610<=
/a> ERROR: Alignment at proto.c/48 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/=
1077682176<br>
Mon Mar 23 13:26:00 2020 us=3D690000 OVPN_Client1/<a href=3D"http://192.168=
.201.116:49610" rel=3D"noreferrer" target=3D"_blank">192.168.201.116:49610<=
/a> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/10=
77682176<br>
Mon Mar 23 13:26:00 2020 us=3D720000 OVPN_Client1/<a href=3D"http://192.168=
.201.116:49610" rel=3D"noreferrer" target=3D"_blank">192.168.201.116:49610<=
/a> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D537/84/2562 I=
=3Dcrypto.c/573<br>
Mon Mar 23 13:26:00 2020 us=3D750000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at proto.c/48 ptr=3D0x00c3ece8 OLC=3D537/84/2562 I=3D/10=
77682176<br>
Mon Mar 23 13:26:00 2020 us=3D750000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D537/84/2562 I=3D/1077=
682176<br>
Mon Mar 23 13:26:01 2020 us=3D710000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D461/84/2562 I=3Dc=
rypto.c/397<br>
Mon Mar 23 13:26:01 2020 us=3D730000 OVPN_Client1/<a href=3D"http://192.168=
.201.116:49610" rel=3D"noreferrer" target=3D"_blank">192.168.201.116:49610<=
/a> ERROR: Alignment at proto.c/48 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/=
1077682176<br>
Mon Mar 23 13:26:01 2020 us=3D730000 OVPN_Client1/<a href=3D"http://192.168=
.201.116:49610" rel=3D"noreferrer" target=3D"_blank">192.168.201.116:49610<=
/a> ERROR: Alignment at mss.c/56 ptr=3D0x00c3ece8 OLC=3D461/84/2562 I=3D/10=
77682176<br>
Mon Mar 23 13:26:01 2020 us=3D770000 OVPN_Client1/<a href=3D"http://192.168=
.201.116:49610" rel=3D"noreferrer" target=3D"_blank">192.168.201.116:49610<=
/a> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D537/84/2562 I=
=3Dcrypto.c/573<br>
Mon Mar 23 13:26:01 2020 us=3D800000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at proto.c/48 ptr=3D0x00c43188 OLC=3D537/84/2562 I=3D/10=
77682176<br>
Mon Mar 23 13:26:01 2020 us=3D800000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at mss.c/56 ptr=3D0x00c43188 OLC=3D537/84/2562 I=3D/1077=
682176<br>
Mon Mar 23 13:26:02 2020 us=3D680000 OVPN_Client2/<a href=3D"http://192.168=
.202.84:53155" rel=3D"noreferrer" target=3D"_blank">192.168.202.84:53155</a=
> ERROR: Alignment at mroute.h/196 ptr=3D0x00bfec30 OLC=3D461/84/2562 I=3Dc=
rypto.c/397<br>
....<br>
<br>
The only thing that I know of until now, that <br>
makes the packets not get dropped is:<br>
=C2=A0 $ echo 3 &gt; /proc/cpu/alignment<br>
<br>
<br>
Now every packet gets transported, none are <br>
dropped any longer.<br>
<br>
The ERRORS are still there, but few of them:<br>
Mon Mar 23 14:53:12 2020 us=3D753594 OVPN_Client1/<a href=3D"http://192.168=
.201.116" rel=3D"noreferrer" target=3D"_blank">192.168.201.116</a> ERROR: A=
lignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c/57=
4<br>
Mon Mar 23 14:53:13 2020 us=3D763594 OVPN_Client1/<a href=3D"http://192.168=
.201.116" rel=3D"noreferrer" target=3D"_blank">192.168.201.116</a> ERROR: A=
lignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c/57=
4<br>
Mon Mar 23 14:53:14 2020 us=3D773594 OVPN_Client1/<a href=3D"http://192.168=
.201.116" rel=3D"noreferrer" target=3D"_blank">192.168.201.116</a> ERROR: A=
lignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c/57=
4<br>
Mon Mar 23 14:53:15 2020 us=3D783594 OVPN_Client1/<a href=3D"http://192.168=
.201.116" rel=3D"noreferrer" target=3D"_blank">192.168.201.116</a> ERROR: A=
lignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c/57=
4<br>
Mon Mar 23 14:53:16 2020 us=3D793594 OVPN_Client1/<a href=3D"http://192.168=
.201.116" rel=3D"noreferrer" target=3D"_blank">192.168.201.116</a> ERROR: A=
lignment at mroute.h/196 ptr=3D0x00f6c598 OLC=3D537/84/2562 I=3Dcrypto.c/57=
4<br>
....<br>
<br>
<br>
Tested on versions:<br>
-------<br>
OpenVPN version 2.4.8, 2.4.3 and 2.4.2<br>
Used LZO 2.10<br>
Used OpenSSL 1.1.1d and 1.0.2d<br>
<br>
OpenVPN 2.4.2 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH=
/PKTINFO] [AEAD] built on Mar 23 2020<br>
library versions: OpenSSL 1.0.2n=C2=A0 7 Dec 2017, LZO 2.10<br>
Originally developed by James Yonan<br>
Copyright (C) 2002-2017 OpenVPN Technologies, Inc. &lt;<a href=3D"mailto:sa=
les@...515..." target=3D"_blank">sales@...515...</a>&gt;<br>
<br>
OpenVPN 2.4.3 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH=
/PKTINFO] [AEAD] built on Mar 23 2020<br>
library versions: OpenSSL 1.1.1d=C2=A0 10 Sep 2019, LZO 2.10<br>
Originally developed by James Yonan<br>
Copyright (C) 2002-2017 OpenVPN Technologies, Inc. &lt;<a href=3D"mailto:sa=
les@...515..." target=3D"_blank">sales@...515...</a>&gt;<br>
<br>
OpenVPN 2.4.8 arm-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH=
/PKTINFO] [AEAD] built on Mar 23 2020<br>
library versions: OpenSSL 1.1.1d=C2=A0 10 Sep 2019, LZO 2.10<br>
Originally developed by James Yonan<br>
Copyright (C) 2002-2018 OpenVPN Inc &lt;<a href=3D"mailto:sales@...515..." =
target=3D"_blank">sales@...515...</a>&gt;<br>
<br>
<br>
<br>
For the sake of completenes here is the server config file:<br>
-------<br>
max-routes 300<br>
server 10.1.0.0 255.255.255.0<br>
server-ipv6 fd19:433a:30e5:0c2c::/64<br>
dh /etc/openvpn/lan/server/dh.pem<br>
ca /etc/openvpn/lan/server/ca.crt<br>
key /etc/openvpn/lan/server/private.key<br>
cert /etc/openvpn/lan/server/cert.crt<br>
proto udp<br>
lport 1194<br>
rport 1194<br>
comp-lzo<br>
cipher AES-256-CBC<br>
auth sha256<br>
tun-mtu 1500<br>
reneg-sec 3600<br>
ping 30<br>
ping-restart 60<br>
verb 14<br>
dev tun<br>
client-to-client<br>
client-config-dir /etc/openvpn/lan/ccd<br>
push &quot;route 192.168.1.0 255.255.255.0&quot;<br>
push=C2=A0 &quot;route-ipv6 fdb8:fead:4164:38f6::/64&quot;<br>
management /var/run/openvpnd_lan.socket unix<br>
explicit-exit-notify 1<br>
route 192.168.2.0 255.255.255.0<br>
push &quot;route 192.168.2.0 255.255.255.0&quot;<br>
route 192.168.4.0 255.255.255.0<br>
push &quot;route 192.168.4.0 255.255.255.0&quot;<br>
<br>
<br>
And the configuration of one client:<br>
--------<br>
max-routes 300<br>
client<br>
remote 192.168.202.82<br>
ca /etc/openvpn/lan/client/ca.crt<br>
key /etc/openvpn/lan/client/private.key<br>
cert /etc/openvpn/lan/client/cert.crt<br>
proto udp<br>
lport 1194<br>
rport 1194<br>
nobind<br>
comp-lzo<br>
cipher AES-256-CBC<br>
auth sha256<br>
tun-mtu 1500<br>
reneg-sec 3600<br>
ping 30<br>
ping-restart 60<br>
verb 3<br>
dev tun<br>
tun-ipv6<br>
float<br>
management /var/run/openvpn_lan.socket unix<br>
<br>
-- <br>
Servus<br>
=C2=A0 Michael<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--00000000000033af8505a18892f3--

