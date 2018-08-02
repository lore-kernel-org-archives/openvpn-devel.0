From: Adam <adam@...1031...>
Message-Id: <E6871949-4FF9-4C5A-975D-12CB177BF29B@...1031...>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_1505A2D9-8DA5-48A8-AE78-16A827C551CD"
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Date: Thu, 2 Aug 2018 16:26:30 +0200
In-Reply-To: <20180723173923.GJ55859@...1296...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
 <20180723173923.GJ55859@...1296...>
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

--Apple-Mail=_1505A2D9-8DA5-48A8-AE78-16A827C551CD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> On Wed, Jul 18, 2018 at 04:33:13PM +0200, Adam wrote:
>> It turns out, NetBSD needs similar handling of subnet topology for tun i=
nterfaces as OpenBSD does.
>>=20
>> Here is a patch to fix the issue (against OpenVPN 2.4.6):
>=20
> So, the patch looks good, and it works nicely on my buildslave.
>=20
> There's two catches here - one is that with this patch format, I do not
> get proper git attribution in place, so we really really prefer patches
> that come out of "git commit -s ..." -> "git send-email".
>=20
> The other catch is that this patch is for 2.4 only, and does not apply=20
> to git master anymore (since Antonio has wrecked tun.c all over :-) ).
>=20
> So what I'd really love to see is two patches, one for 2.4 and one for
> git master, both coming out of "git commit -s" -> "git send-email" - beca=
use
> that would speed up the flow tremendously (I can ACK and commit the patch=
es
> right away, but if I adapt your patch to "git master", someone else needs
> to do the review and the credits who did the fixing are all wrong)
>=20
> thanks :)
>=20
> gert


Here it is, against the current master branch.


--Apple-Mail=_1505A2D9-8DA5-48A8-AE78-16A827C551CD
Content-Disposition: attachment;
	filename=0001-Fix-subnet-topology-on-NetBSD.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Fix-subnet-topology-on-NetBSD.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=201ac7931b5afa6b3c521d23f1847476ab6384eb10=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20=3D?UTF-8?q?Adam=3D20Ciarcin=3DCC=3D81ski?=3D=20=
<adam@...1031...>=0ADate:=20Thu,=202=20Aug=202018=2016:17:56=20+0200=0A=
Subject:=20[PATCH]=20Fix=20subnet=20topology=20on=20NetBSD.=0A=
MIME-Version:=201.0=0AContent-Type:=20text/plain;=20charset=3DUTF-8=0A=
Content-Transfer-Encoding:=208bit=0A=0ASigned-off-by:=20Adam=20=
Ciarcin=CC=81ski=20<adam@...1031...>=0A---=0A=20src/openvpn/tun.c=20|=20=
19=20++++++++++++++++---=0A=201=20file=20changed,=2016=20insertions(+),=20=
3=20deletions(-)=0A=0Adiff=20--git=20a/src/openvpn/tun.c=20=
b/src/openvpn/tun.c=0Aindex=201c7e51d9..7fe4a062=20100644=0A---=20=
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
=20=20=20=20=20if=20(tun)=0A=20=20=20=20=20{=0A@@=20-1243,8=20+1244,8=20=
@@=20do_ifconfig_ipv4(struct=20tuntap=20*tt,=20const=20char=20*ifname,=20=
int=20tun_mtu,=0A=20=20=20=20=20else=20if=20(tt->topology=20=3D=3D=20=
TOP_SUBNET)=0A=20=20=20=20=20{=0A=20=20=20=20=20=20=20=20=20=
argv_printf(&argv,=20"%s=20%s=20%s=20%s=20mtu=20%d=20netmask=20%s=20up",=20=
IFCONFIG_PATH,=0A-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20ifname,=20ifconfig_local,=20ifconfig_local,=20tun_mtu,=0A-=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
ifconfig_remote_netmask);=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20ifname,=20ifconfig_local,=20print_in_addr_t(remote_end,=20=
0,=20&gc),=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
tun_mtu,=20ifconfig_remote_netmask);=0A=20=20=20=20=20}=0A=20=20=20=20=20=
else=0A=20=20=20=20=20{=0A@@=20-1260,6=20+1261,18=20@@=20=
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

--Apple-Mail=_1505A2D9-8DA5-48A8-AE78-16A827C551CD
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit




Kind regards,
Adam
--Apple-Mail=_1505A2D9-8DA5-48A8-AE78-16A827C551CD--

