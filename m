MIME-Version: 1.0
References: <20230105022718.1641751-1-selva.nair@...277...>
 <CAGyAFMVpquzshk7k9TfBTwTFKRNxBVkunn79TnBd2gpaoZSQwQ@...278...>
 <Y7iCSAacZKc++0bW@...1296...>
In-Reply-To: <Y7iCSAacZKc++0bW@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 6 Jan 2023 16:46:17 -0500
Message-ID: <CAKuzo_ik_xukXb9q+PNd_7wC6X4YPv+J9i2+wTX4488XvepStA@...278...>
Content-Type: multipart/alternative; boundary="000000000000e7c5ad05f19f59f0"
Subject: Re: [Openvpn-devel] [PATCH 1/3] Use IPAPI for setting ipv6 routes
 when iservice not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

--000000000000e7c5ad05f19f59f0
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 6, 2023 at 3:19 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Jan 06, 2023 at 03:44:24PM +0200, Lev Stipakov wrote:
> > Compiled and slightly tested - pinged server's tunnel IPv6 address.
>
> Do we call "route" for connect networks on Windows?  We do on some
> of the platforms, but for those where we do not, this is not a good
> test for "route add" functionality - as tunnel IP + subnet gets
> setup via the "ifconfig-ipv6" part (implicit route for connected net).
>

Yes we do call add_route_connected_v6_net() on windows, so add_route_ipv6()
should always get exercised.

Though I vaguely understand why we set the address with /128 and then set
the route for the vpn subnet with fe80::8 as the gateway for tap-windows6,
wonder why we do this for dco as well.

Selva

--000000000000e7c5ad05f19f59f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 6, 2023 at 3:19 PM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
On Fri, Jan 06, 2023 at 03:44:24PM +0200, Lev Stipakov wrote:<br>
&gt; Compiled and slightly tested - pinged server&#39;s tunnel IPv6 address=
.<br>
<br>
Do we call &quot;route&quot; for connect networks on Windows?=C2=A0 We do o=
n some<br>
of the platforms, but for those where we do not, this is not a good<br>
test for &quot;route add&quot; functionality - as tunnel IP + subnet gets <=
br>
setup via the &quot;ifconfig-ipv6&quot; part (implicit route for connected =
net).<br></blockquote><div><br></div><div>Yes we do call add_route_connecte=
d_v6_net() on windows, so add_route_ipv6() should=C2=A0always get exercised=
.</div><div><br></div><div>Though I vaguely understand why we set the addre=
ss with=C2=A0/128 and then set the route for the vpn subnet with fe80::8 as=
 the gateway for tap-windows6, wonder why we do this for dco as well.</div>=
<div><br></div><div>Selva</div></div></div>

--000000000000e7c5ad05f19f59f0--

