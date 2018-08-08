Resent-Message-ID: <20180809111811.GU55859@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
From: Adam <adam@...1031...>
Message-Id: <8110ED8B-4084-4D47-87E2-7B1C14041268@...1031...>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_759D7229-686E-496A-BD43-DEABD1F2C8FE"
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Date: Wed, 8 Aug 2018 15:45:37 +0200
In-Reply-To: <20180805184515.GB55859@...1296...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
 <20180723173923.GJ55859@...1296...>
 <E6871949-4FF9-4C5A-975D-12CB177BF29B@...1031...>
 <20180805184515.GB55859@...1296...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_759D7229-686E-496A-BD43-DEABD1F2C8FE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>> Here it is, against the current master branch.
>=20
> Thanks for re-sending.  Unfortunately, it's not complete - it adds
> "remote_end", but never initializes it in the TARGET_FREEBSD branch.
>=20
> So it sort of works because it happens to puts 0.0.0.0 (or even random=20
> stack data) into "remote_end" which is then used as gateway address...=20=
=20
>=20
> Sun Aug  5 21:01:38 2018 /sbin/ifconfig tun1 10.194.3.14 0.0.0.0 mtu 1500=
 netmask 255.255.255.0 up
> Sun Aug  5 21:01:38 2018 /sbin/route add -net 10.194.3.0 0.0.0.0 -netmask=
 255.255.255.0
> add net 10.194.3.0: gateway 0.0.0.0
>=20
> (Actually, it looks like it could work, but pinging 10.194.3.1 is=20
> subsequently failing)
>=20
>=20
> All other platforms have a
>=20
>  remote_end =3D create_arbitrary_remote( tt );
>=20
> in there, to make it look less... accidential.  I assume this just got
> lost on rebasing (blame it on Antonio :-) ).
>=20
> Could you send us a v2?  thanks :)
>=20
> gert

Sorry about that. I'm on holiday, and doing it with only one eye opened. ;)

Here it is once more...

Cheers,
Adam


--Apple-Mail=_759D7229-686E-496A-BD43-DEABD1F2C8FE
Content-Disposition: attachment;
	filename=0001-Fix-subnet-topology-on-NetBSD.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Fix-subnet-topology-on-NetBSD.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20b24aed8efb5adec5d3dcab25ecf456fbd8e4415a=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20=3D?UTF-8?q?Adam=3D20Ciarcin=3DCC=3D81ski?=3D=20=
<adam@...1031...>=0ADate:=20Thu,=202=20Aug=202018=2016:17:56=20+0200=0A=
Subject:=20[PATCH]=20Fix=20subnet=20topology=20on=20NetBSD.=0A=
MIME-Version:=201.0=0AContent-Type:=20text/plain;=20charset=3DUTF-8=0A=
Content-Transfer-Encoding:=208bit=0A=0ASigned-off-by:=20Adam=20=
Ciarcin=CC=81ski=20<adam@...1031...>=0A---=0A=20src/openvpn/tun.c=20|=20=
20=20+++++++++++++++++---=0A=201=20file=20changed,=2017=20insertions(+),=20=
3=20deletions(-)=0A=0Adiff=20--git=20a/src/openvpn/tun.c=20=
b/src/openvpn/tun.c=0Aindex=201c7e51d9..50f158cb=20100644=0A---=20=
a/src/openvpn/tun.c=0A+++=20b/src/openvpn/tun.c=0A@@=20-845,7=20+845,7=20=
@@=20delete_route_connected_v6_net(struct=20tuntap=20*tt,=0A=20#endif=20=
/*=20if=20defined(_WIN32)=20||=20defined(TARGET_DARWIN)=20||=20=
defined(TARGET_NETBSD)=20||=20defined(TARGET_OPENBSD)=20*/=0A=20=0A=20=
#if=20defined(TARGET_FREEBSD)=20||=20defined(TARGET_DRAGONFLY)=20=20\=0A=
-=20=20=20=20||=20defined(TARGET_OPENBSD)=0A+=20=20=20=20||=20=
defined(TARGET_NETBSD)=20||=20defined(TARGET_OPENBSD)=0A=20/*=20we=20=
can't=20use=20true=20subnet=20mode=20on=20tun=20on=20all=20platforms,=20=
as=20that=0A=20=20*=20conflicts=20with=20IPv6=20(wants=20to=20use=20ND=20=
then,=20which=20we=20don't=20do),=0A=20=20*=20but=20the=20OSes=20want=20=
"a=20remote=20address=20that=20is=20different=20from=20ours"=0A@@=20=
-1233,6=20+1233,7=20@@=20do_ifconfig_ipv4(struct=20tuntap=20*tt,=20const=20=
char=20*ifname,=20int=20tun_mtu,=0A=20=20=20=20=20}=0A=20=0A=20#elif=20=
defined(TARGET_NETBSD)=0A+=20=20=20=20in_addr_t=20remote_end;=20=20=20=20=
=20=20=20=20=20=20=20/*=20for=20"virtual"=20subnet=20topology=20*/=0A=20=0A=
=20=20=20=20=20if=20(tun)=0A=20=20=20=20=20{=0A@@=20-1242,9=20+1243,10=20=
@@=20do_ifconfig_ipv4(struct=20tuntap=20*tt,=20const=20char=20*ifname,=20=
int=20tun_mtu,=0A=20=20=20=20=20}=0A=20=20=20=20=20else=20if=20=
(tt->topology=20=3D=3D=20TOP_SUBNET)=0A=20=20=20=20=20{=0A+=20=20=20=20=20=
=20=20=20remote_end=20=3D=20create_arbitrary_remote(tt);=0A=20=20=20=20=20=
=20=20=20=20argv_printf(&argv,=20"%s=20%s=20%s=20%s=20mtu=20%d=20netmask=20=
%s=20up",=20IFCONFIG_PATH,=0A-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20ifname,=20ifconfig_local,=20ifconfig_local,=20tun_mtu,=0A=
-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
ifconfig_remote_netmask);=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20ifname,=20ifconfig_local,=20print_in_addr_t(remote_end,=20=
0,=20&gc),=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
tun_mtu,=20ifconfig_remote_netmask);=0A=20=20=20=20=20}=0A=20=20=20=20=20=
else=0A=20=20=20=20=20{=0A@@=20-1260,6=20+1262,18=20@@=20=
do_ifconfig_ipv4(struct=20tuntap=20*tt,=20const=20char=20*ifname,=20int=20=
tun_mtu,=0A=20=20=20=20=20argv_msg(M_INFO,=20&argv);=0A=20=20=20=20=20=
openvpn_execve_check(&argv,=20es,=20S_FATAL,=20"NetBSD=20ifconfig=20=
failed");=0A=20=0A+=20=20=20=20/*=20Add=20a=20network=20route=20for=20=
the=20local=20tun=20interface=20*/=0A+=20=20=20=20if=20(!tun=20&&=20=
tt->topology=20=3D=3D=20TOP_SUBNET)=0A+=20=20=20=20{=0A+=20=20=20=20=20=20=
=20=20struct=20route_ipv4=20r;=0A+=20=20=20=20=20=20=20=20CLEAR(r);=0A+=20=
=20=20=20=20=20=20=20r.flags=20=3D=20RT_DEFINED;=0A+=20=20=20=20=20=20=20=
=20r.network=20=3D=20tt->local=20&=20tt->remote_netmask;=0A+=20=20=20=20=20=
=20=20=20r.netmask=20=3D=20tt->remote_netmask;=0A+=20=20=20=20=20=20=20=20=
r.gateway=20=3D=20remote_end;=0A+=20=20=20=20=20=20=20=20add_route(&r,=20=
tt,=200,=20NULL,=20es);=0A+=20=20=20=20}=0A+=0A=20#elif=20=
defined(TARGET_DARWIN)=0A=20=20=20=20=20/*=0A=20=20=20=20=20=20*=20=
Darwin=20(i.e.=20Mac=20OS=20X)=20seems=20to=20exhibit=20similar=20=
behaviour=20to=20OpenBSD...=0A--=20=0A2.18.0=0A=0A=

--Apple-Mail=_759D7229-686E-496A-BD43-DEABD1F2C8FE--


