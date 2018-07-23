From: James Bekkema <james@...1918...>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_99B9C4DF-9EBC-49ED-AECC-42B89BDDBEFC"
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 23 Jul 2018 13:45:41 +1000
Message-Id: <777939F9-A753-4A66-B40E-1346AFD588DE@...1918...>
Subject: [Openvpn-devel] [PATCH] Adds support for setting the default IPv6
 gateway for routes using the route-ipv6-gateway option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_99B9C4DF-9EBC-49ED-AECC-42B89BDDBEFC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch adds support for setting the default IPv6 gateway for routes usi=
ng the "route-ipv6-gateway=E2=80=9D option.

Currently if users try to use the "redirect-gateway ipv6=E2=80=9D option, o=
r a IPv6 route without a gateway, without using "ifconfig-ipv6" they=E2=80=
=99ll receive the message "OpenVPN ROUTE6: OpenVPN needs a gateway paramete=
r for a --route-ipv6 option and no default was specified by either --route-=
ipv6-gateway or --ifconfig-ipv6 options=E2=80=9D.

However, the "route-ipv6-gateway=E2=80=9D option doesn=E2=80=99t actually e=
xist, and it is required for bridged/TAP setups relying on IPv6 auto-config=
uration for IP assignment. This patch adds the "route-ipv6-gateway=E2=80=9D=
 option. The gateway specified must be an IPv6 address, FQDNs are not suppo=
rted (to match the behaviour of the other IPv6 related options).

Currently in production use in Viscosity for macOS and Windows, no reported=
 issues.

Signed-off-by: James Bekkema <james@...1918...>

Thanks,
James

--
James Bekkema
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

--Apple-Mail=_99B9C4DF-9EBC-49ED-AECC-42B89BDDBEFC
Content-Disposition: attachment;
	filename=route-ipv6-gateway.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="route-ipv6-gateway.diff"
Content-Transfer-Encoding: quoted-printable

=46rom=204925dea99cabdedb518be59fc14d83484b830cbe=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Bekkema=20<james@...1918...>=0A=
Date:=20Mon,=2023=20Jul=202018=2013:28:31=20+1000=0ASubject:=20[PATCH]=20=
Adds=20support=20for=20setting=20the=20default=20IPv6=20gateway=20for=20=
routes=0A=20using=20the=20route-ipv6-gateway=20option.=0A=0A---=0A=20=
doc/openvpn.8=20=20=20=20=20=20=20=20=20|=20=208=20++++++++=0A=20=
src/openvpn/init.c=20=20=20=20|=20=204=20+---=0A=20src/openvpn/options.c=20=
|=2016=20+++++++++++++++-=0A=20src/openvpn/options.h=20|=20=201=20+=0A=20=
4=20files=20changed,=2025=20insertions(+),=204=20deletions(-)=0A=0Adiff=20=
--git=20a/doc/openvpn.8=20b/doc/openvpn.8=0Aindex=2046ea58b6..7441b443=20=
100644=0A---=20a/doc/openvpn.8=0A+++=20b/doc/openvpn.8=0A@@=20-6149,8=20=
+6149,16=20@@=20into=20OpenVPN's=20``tun''.=20=20The=20gateway=20=
parameter=20is=20only=20used=20for=0A=20IPv6=20routes=20across=20``tap''=20=
devices,=20and=20if=20missing,=20the=20``ipv6remote''=0A=20field=20from=0A=
=20.B=20\-\-ifconfig\-ipv6=0A+or=0A+.B=20\-\-route\-ipv6\-gateway=0A=20=
is=20used.=0A=20.TP=0A+.B=20\-\-route\-ipv6\-gateway=20gw=0A+Specify=20a=20=
default=20gateway=0A+.B=20gw=0A+for=20use=20with=0A+.B=20=
\-\-route\-ipv6.=0A+.TP=0A=20.B=20\-\-server\-ipv6=20ipv6addr/bits=0A=20=
convenience\-function=20to=20enable=20a=20number=20of=20IPv6=20related=20=
options=20at=0A=20once,=20namely=0Adiff=20--git=20a/src/openvpn/init.c=20=
b/src/openvpn/init.c=0Aindex=20057dbb4b..d2903b87=20100644=0A---=20=
a/src/openvpn/init.c=0A+++=20b/src/openvpn/init.c=0A@@=20-1416,12=20=
+1416,10=20@@=20do_init_route_ipv6_list(const=20struct=20options=20=
*options,=0A=20=20=20=20=20int=20metric=20=3D=20-1;=20=20=20=20=20=20=20=20=
=20=20=20=20/*=20no=20metric=20set=20*/=0A=20=0A=20=20=20=20=20gw=20=3D=20=
options->ifconfig_ipv6_remote;=20=20=20=20=20=20=20=20=20/*=20default=20=
GW=20=3D=20remote=20end=20*/=0A-#if=200=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20/*=20=
not=20yet=20done=20for=20IPv6=20-=20TODO!*/=0A-=20=20=20=20if=20=
(options->route_ipv6_default_gateway)=20=20=20=20=20=20=20=20=20=20=20=20=
/*=20override?=20*/=0A+=20=20=20=20if=20=
(options->route_ipv6_default_gateway)=0A=20=20=20=20=20{=0A=20=20=20=20=20=
=20=20=20=20gw=20=3D=20options->route_ipv6_default_gateway;=0A=20=20=20=20=
=20}=0A-#endif=0A=20=0A=20=20=20=20=20if=20=
(options->route_default_metric)=0A=20=20=20=20=20{=0Adiff=20--git=20=
a/src/openvpn/options.c=20b/src/openvpn/options.c=0Aindex=20=
b89f4ba2..0d11e968=20100644=0A---=20a/src/openvpn/options.c=0A+++=20=
b/src/openvpn/options.c=0A@@=20-200,8=20+200,10=20@@=20static=20const=20=
char=20usage_message[]=20=3D=0A=20=20=20=20=20"--route-ipv6=20=
network/bits=20[gateway]=20[metric]=20:\n"=0A=20=20=20=20=20"=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20Add=20IPv6=20route=20to=20=
routing=20table=20after=20connection\n"=0A=20=20=20=20=20"=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20is=20established.=20=20Multiple=20=
routes=20can=20be=20specified.\n"=0A-=20=20=20=20"=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20gateway=20default:=20taken=20from=20=
'remote'=20in=20--ifconfig-ipv6\n"=0A+=20=20=20=20"=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20gateway=20default:=20taken=20from=20=
--route-ipv6-gateway=20or=20'remote'\n"=0A+=20=20=20=20"=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20in=20--ifconfig-ipv6\n"=0A=20=20=20=20=
=20"--route-gateway=20gw|'dhcp'=20:=20Specify=20a=20default=20gateway=20=
for=20use=20with=20--route.\n"=0A+=20=20=20=20"--route-ipv6-gateway=20gw=20=
:=20Specify=20a=20default=20gateway=20for=20use=20with=20=
--route-ipv6.\n"=0A=20=20=20=20=20"--route-metric=20m=20:=20Specify=20a=20=
default=20metric=20for=20use=20with=20--route.\n"=0A=20=20=20=20=20=
"--route-delay=20n=20[w]=20:=20Delay=20n=20seconds=20after=20connection=20=
initiation=20before\n"=0A=20=20=20=20=20"=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20adding=20routes=20(may=20be=200).=20=20If=20not=20=
specified,=20routes=20will\n"=0A@@=20-6197,6=20+6199,18=20@@=20=
add_option(struct=20options=20*options,=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20}=0A=20=20=20=20=20=20=20=20=20}=0A=20=20=20=20=20}=0A+=20=20=20=20=
else=20if=20(streq(p[0],=20"route-ipv6-gateway")=20&&=20p[1]=20&&=20=
!p[2])=0A+=20=20=20=20{=0A+=20=20=20=20=20=20=20=20if=20=
(ipv6_addr_safe(p[1]))=0A+=20=20=20=20=20=20=20=20{=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20options->route_ipv6_default_gateway=20=3D=20p[1];=0A+=20=
=20=20=20=20=20=20=20}=0A+=20=20=20=20=20=20=20=20else=0A+=20=20=20=20=20=
=20=20=20{=0A+=20=20=20=20=20=20=20=20=20=20=20=20msg(msglevel,=20=
"route-ipv6-gateway=20parm=20'%s'=20must=20be=20a=20valid=20address",=20=
p[1]);=0A+=20=20=20=20=20=20=20=20=20=20=20=20goto=20err;=0A+=20=20=20=20=
=20=20=20=20}=0A+=20=20=20=20}=0A=20=20=20=20=20else=20if=20(streq(p[0],=20=
"route-metric")=20&&=20p[1]=20&&=20!p[2])=0A=20=20=20=20=20{=0A=20=20=20=20=
=20=20=20=20=20VERIFY_PERMISSION(OPT_P_ROUTE);=0Adiff=20--git=20=
a/src/openvpn/options.h=20b/src/openvpn/options.h=0Aindex=20=
3a6c33f8..66d45081=20100644=0A---=20a/src/openvpn/options.h=0A+++=20=
b/src/openvpn/options.h=0A@@=20-329,6=20+329,7=20@@=20struct=20options=0A=
=20=20=20=20=20const=20char=20*route_script;=0A=20=20=20=20=20const=20=
char=20*route_predown_script;=0A=20=20=20=20=20const=20char=20=
*route_default_gateway;=0A+=20=20=20=20const=20char=20=
*route_ipv6_default_gateway;=0A=20=20=20=20=20int=20=
route_default_metric;=0A=20=20=20=20=20bool=20route_noexec;=0A=20=20=20=20=
=20int=20route_delay;=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_99B9C4DF-9EBC-49ED-AECC-42B89BDDBEFC--

