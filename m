From: James Bekkema <james@...1918...>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_0981E51E-3A94-4025-BDFD-363196B5FA81"
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 23 Jul 2018 13:45:12 +1000
Message-Id: <A7C436F7-3B7C-44B4-B783-71B098AE2ABB@...1918...>
Subject: [Openvpn-devel] [PATCH] Restore functionality of route-gateway's
 dhcp parameter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_0981E51E-3A94-4025-BDFD-363196B5FA81
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch restores functionality of route-gateway's dhcp parameter, and ex=
pands it to support routes using vpn_gateway.

OpenVPN supports using a =E2=80=9Cdhcp=E2=80=9D parameter for the "route-ga=
teway=E2=80=9D option, which involves intercepting the DHCP reply packet an=
d extracting the gateway to use. However, the current implementation expect=
s to have this information at the time of the initialisation of the route l=
ist, which will not happen, and so routes relying on this option are never =
added.

Rather than moving initialisation of the route list until after the route-d=
elay (which can have a negative effect on the resolution of routes using FQ=
DNs), this patch flags routes that require a DHCP gateway, and updates and =
defines them when a DHCP reply is received. If no reply is received in time=
, the routes are left undefined.

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

--Apple-Mail=_0981E51E-3A94-4025-BDFD-363196B5FA81
Content-Disposition: attachment;
	filename=route-gateway-dhcp.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="route-gateway-dhcp.diff"
Content-Transfer-Encoding: quoted-printable

=46rom=20363ad7103507bcc092fde61c3b60bd3cfbf60aaa=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Bekkema=20<james@...1918...>=0A=
Date:=20Mon,=2023=20Jul=202018=2013:21:53=20+1000=0ASubject:=20[PATCH]=20=
Restore=20functionality=20of=20route-gateway's=20dhcp=20parameter,=20and=0A=
=20expand=20to=20support=20routes=20using=20vpn_gateway.=0A=0A---=0A=20=
src/openvpn/init.c=20=20|=20=201=20+=0A=20src/openvpn/route.c=20|=2032=20=
++++++++++++++++++++++++++++++--=0A=20src/openvpn/route.h=20|=20=203=20=
+++=0A=203=20files=20changed,=2034=20insertions(+),=202=20deletions(-)=0A=
=0Adiff=20--git=20a/src/openvpn/init.c=20b/src/openvpn/init.c=0Aindex=20=
d28d1fd2..057dbb4b=20100644=0A---=20a/src/openvpn/init.c=0A+++=20=
b/src/openvpn/init.c=0A@@=20-1396,6=20+1396,7=20@@=20=
do_init_route_list(const=20struct=20options=20*options,=0A=20=20=20=20=20=
if=20(init_route_list(route_list,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20options->routes,=0A=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20gw,=0A+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
options->route_gateway_via_dhcp,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20metric,=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
link_socket_current_remote(link_socket_info),=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20es))=0Adiff=20--git=20=
a/src/openvpn/route.c=20b/src/openvpn/route.c=0Aindex=20=
ff392308..ad8ea135=20100644=0A---=20a/src/openvpn/route.c=0A+++=20=
b/src/openvpn/route.c=0A@@=20-295,6=20+295,12=20@@=20=
is_special_addr(const=20char=20*addr_str)=0A=20=20=20=20=20}=0A=20}=0A=20=
=0A+static=20bool=0A+should_use_dhcp_gateway(const=20char=20*gateway,=20=
const=20struct=20route_list=20*rl)=0A+{=0A+=20=20=20=20return=20=
(rl->spec.flags=20&=20RTSA_DHCP_ENDPOINT=20&&=20=
(!is_route_parm_defined(gateway)=20||=20!strcmp(gateway,=20=
"vpn_gateway")));=0A+}=0A+=0A=20static=20bool=0A=20init_route(struct=20=
route_ipv4=20*r,=0A=20=20=20=20=20=20=20=20=20=20=20=20struct=20addrinfo=20=
**network_list,=0A@@=20-362,7=20+368,11=20@@=20init_route(struct=20=
route_ipv4=20*r,=0A=20=0A=20=20=20=20=20/*=20gateway=20*/=0A=20=0A-=20=20=
=20=20if=20(is_route_parm_defined(ro->gateway))=0A+=20=20=20=20if=20=
(should_use_dhcp_gateway(ro->gateway,=20rl))=0A+=20=20=20=20{=0A+=20=20=20=
=20=20=20=20=20r->flags=20|=3D=20RT_DHCP_GATEWAY;=0A+=20=20=20=20}=0A+=20=
=20=20=20else=20if=20(is_route_parm_defined(ro->gateway))=0A=20=20=20=20=20=
{=0A=20=20=20=20=20=20=20=20=20if=20(!get_special_addr(rl,=20=
ro->gateway,=20&r->gateway,=20&status))=0A=20=20=20=20=20=20=20=20=20{=0A=
@@=20-414,7=20+424,10=20@@=20init_route(struct=20route_ipv4=20*r,=0A=20=20=
=20=20=20=20=20=20=20r->flags=20|=3D=20RT_METRIC_DEFINED;=0A=20=20=20=20=20=
}=0A=20=0A-=20=20=20=20r->flags=20|=3D=20RT_DEFINED;=0A+=20=20=20=20if=20=
((r->flags=20&=20RT_DHCP_GATEWAY)=20=3D=3D=200)=0A+=20=20=20=20{=0A+=20=20=
=20=20=20=20=20=20r->flags=20|=3D=20RT_DEFINED;=0A+=20=20=20=20}=0A=20=0A=
=20=20=20=20=20return=20true;=0A=20=0A@@=20-541,6=20+554,16=20@@=20=
route_list_add_vpn_gateway(struct=20route_list=20*rl,=0A=20=20=20=20=20=
rl->spec.remote_endpoint=20=3D=20addr;=0A=20=20=20=20=20rl->spec.flags=20=
|=3D=20RTSA_REMOTE_ENDPOINT;=0A=20=20=20=20=20setenv_route_addr(es,=20=
"vpn_gateway",=20rl->spec.remote_endpoint,=20-1);=0A+=0A+=20=20=20=20=
struct=20route_ipv4=20*r;=0A+=20=20=20=20for=20(r=20=3D=20rl->routes;=20=
r;=20r=20=3D=20r->next)=0A+=20=20=20=20{=0A+=20=20=20=20=20=20=20=20if=20=
(r->flags=20&=20RT_DHCP_GATEWAY)=0A+=20=20=20=20=20=20=20=20{=0A+=20=20=20=
=20=20=20=20=20=20=20=20=20r->gateway=20=3D=20addr;=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20r->flags=20|=3D=20RT_DEFINED;=0A+=20=20=20=20=20=20=20=20=
}=0A+=20=20=20=20}=0A=20}=0A=20=0A=20static=20void=0A@@=20-611,6=20=
+634,7=20@@=20bool=0A=20init_route_list(struct=20route_list=20*rl,=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20const=20struct=20=
route_option_list=20*opt,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20const=20char=20*remote_endpoint,=0A+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20bool=20remote_endpoint_dhcp,=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20int=20default_metric,=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20in_addr_t=20remote_host,=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20struct=20env_set=20*es)=0A@@=20-676,6=20=
+700,10=20@@=20init_route_list(struct=20route_list=20*rl,=0A=20=20=20=20=20=
=20=20=20=20=20=20=20=20ret=20=3D=20false;=0A=20=20=20=20=20=20=20=20=20=
}=0A=20=20=20=20=20}=0A+=20=20=20=20else=20if=20(remote_endpoint_dhcp)=0A=
+=20=20=20=20{=0A+=20=20=20=20=20=20=20=20rl->spec.flags=20|=3D=20=
RTSA_DHCP_ENDPOINT;=0A+=20=20=20=20}=0A=20=0A=20=20=20=20=20if=20=
(rl->flags=20&=20RG_ENABLE)=0A=20=20=20=20=20{=0Adiff=20--git=20=
a/src/openvpn/route.h=20b/src/openvpn/route.h=0Aindex=20=
69420228..948c892e=20100644=0A---=20a/src/openvpn/route.h=0A+++=20=
b/src/openvpn/route.h=0A@@=20-62,6=20+62,7=20@@=20struct=20=
route_special_addr=0A=20#define=20RTSA_REMOTE_ENDPOINT=20=20(1<<0)=0A=20=
#define=20RTSA_REMOTE_HOST=20=20=20=20=20=20(1<<1)=0A=20#define=20=
RTSA_DEFAULT_METRIC=20=20=20(1<<2)=0A+#define=20RTSA_DHCP_ENDPOINT=20=20=20=
=20(1<<3)=0A=20=20=20=20=20unsigned=20int=20flags;=0A=20=0A=20=20=20=20=20=
in_addr_t=20remote_endpoint;=0A@@=20-112,6=20+113,7=20@@=20struct=20=
route_ipv4=20{=0A=20#define=20RT_DEFINED=20=20=20=20=20=20=20=20(1<<0)=0A=
=20#define=20RT_ADDED=20=20=20=20=20=20=20=20=20=20(1<<1)=0A=20#define=20=
RT_METRIC_DEFINED=20(1<<2)=0A+#define=20RT_DHCP_GATEWAY=20=20=20(1<<3)=0A=
=20=20=20=20=20struct=20route_ipv4=20*next;=0A=20=20=20=20=20unsigned=20=
int=20flags;=0A=20=20=20=20=20const=20struct=20route_option=20*option;=0A=
@@=20-280,6=20+282,7=20@@=20void=20add_route_ipv6_to_option_list(struct=20=
route_ipv6_option_list=20*l,=0A=20bool=20init_route_list(struct=20=
route_list=20*rl,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20const=20struct=20route_option_list=20*opt,=0A=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20const=20char=20=
*remote_endpoint,=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20bool=20remote_endpoint_dhcp,=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20int=20default_metric,=0A=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20in_addr_t=20remote_host,=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20=
env_set=20*es);=0A--=20=0A2.17.1=0A=0A=

--Apple-Mail=_0981E51E-3A94-4025-BDFD-363196B5FA81--

