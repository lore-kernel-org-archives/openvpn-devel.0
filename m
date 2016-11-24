MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Nov 2016 22:43:20 -0500
Message-ID: <CAKuzo_gyYfD=YsV-GCU+-g93sctikfR+zC_4_E3vHfVo1oREMA@...278...>
Content-Type: multipart/alternative; boundary=001a113bc880b930fe054203cf4f
Subject: [Openvpn-devel] IPv6 route addition error on SIGHUP restarts
	(Windows)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113bc880b930fe054203cf4f
Content-Type: text/plain; charset=UTF-8

Hi,

I see the following route addition error during SIGHUP restarts on Windows.

Wed Nov 23 21:44:39 2016 add_route_ipv6(xxxx:xxxx:e001:3b08::/64 ->
xxxx:xxxx:e001:3b08::1001 metric 0) dev SanSel-VPN
Wed Nov 23 21:44:39 2016 ROUTE: route addition failed using service: The
object already exists.   [status=5010 if_index=24]
Wed Nov 23 21:44:39 2016 IPv6 route addition via service failed

I'm not familiar with the relevant code, but looks like the route added by
add_route_connected_v6_net() is not deleted on disconnect. Probably this
route doesn't make it into the route_list.

Selva

--001a113bc880b930fe054203cf4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>I see the following route addition error d=
uring SIGHUP restarts on Windows.<br>=C2=A0<br>Wed Nov 23 21:44:39 2016 add=
_route_ipv6(xxxx:xxxx:e001:<wbr>3b08::/64 -&gt; xxxx:xxxx:e001:3b08::1001 m=
etric 0) dev SanSel-VPN<br>Wed Nov 23 21:44:39 2016 ROUTE: route addition f=
ailed using service: The object already exists.=C2=A0=C2=A0 [status=3D5010 =
if_index=3D24]<br>Wed Nov 23 21:44:39 2016 IPv6 route addition via service =
failed<br><br>I&#39;m not familiar with the relevant code, but looks like t=
he route added by=C2=A0 add_route_connected_v6_net() is not deleted on disc=
onnect. Probably this route doesn&#39;t make it into the route_list.<br><br=
></div>Selva<br></div>

--001a113bc880b930fe054203cf4f--

