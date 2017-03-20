MIME-Version: 1.0
In-Reply-To: <20170319191049.23970-1-gert@...1296...>
References: <20170319191049.23970-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 20 Mar 2017 11:38:47 -0400
Message-ID: <CAKuzo_j+DgYxgk=CNRn8S5PhWjxWmfzkNPLKBuikpm3uRkgxcQ@...278...>
Content-Type: multipart/alternative; boundary=001a1143c2acf5901d054b2b5331
Subject: Re: [Openvpn-devel] [PATCH] Fix installation of IPv6 host route to
 VPN server when using iservice.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1143c2acf5901d054b2b5331
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Mar 19, 2017 at 3:10 PM, Gert Doering <gert@...1296...> wrote:

> The "prepare IPv6 route message to interactive service" was properly
> handing the correct interface index (r->adapter_index) for this case,
> but then always overwrote the gateway address with our magic tun/tap
> fe80::8 value.  Only do this for "on tap adapter" routes.
>
> Pinpointed by Selva Nair.
>
> Trac #850
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 7e536ef..08998d5 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -3061,8 +3061,10 @@ do_route_ipv6_service(const bool add, const struct
> route_ipv6 *r, const struct t
>
>      /* In TUN mode we use a special link-local address as the next hop.
>       * The tapdrvr knows about it and will answer neighbor discovery
> packets.
> +     * (only do this for routes actually using the tun/tap device)
>       */
> -    if (tt->type == DEV_TYPE_TUN)
> +    if (tt->type == DEV_TYPE_TUN
> +        && msg.iface.index == tt->adapter_index )
>
     {
>          inet_pton(AF_INET6, "fe80::8", &msg.gateway.ipv6);
>      }
>

This should fix it. ACK.

Selva

--001a1143c2acf5901d054b2b5331
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br><div><div class=3D"gmail_extra"><div class=3D"g=
mail_quote">On Sun, Mar 19, 2017 at 3:10 PM, Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he &quot;prepare IPv6 route message to interactive service&quot; was proper=
ly<br>
handing the correct interface index (r-&gt;adapter_index) for this case,<br>
but then always overwrote the gateway address with our magic tun/tap<br>
fe80::8 value.=C2=A0 Only do this for &quot;on tap adapter&quot; routes.<br>
<br>
Pinpointed by Selva Nair.<br>
<br>
Trac #850<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/route.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index 7e536ef..08998d5 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -3061,8 +3061,10 @@ do_route_ipv6_service(const bool add, const struct r=
oute_ipv6 *r, const struct t<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* In TUN mode we use a special link-local address as t=
he next hop.<br>
=C2=A0 =C2=A0 =C2=A0 * The tapdrvr knows about it and will answer neighbor =
discovery packets.<br>
+=C2=A0 =C2=A0 =C2=A0* (only do this for routes actually using the tun/tap =
device)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (tt-&gt;type =3D=3D DEV_TYPE_TUN)<br>
+=C2=A0 =C2=A0 if (tt-&gt;type =3D=3D DEV_TYPE_TUN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; msg.iface.index =3D=3D tt-&gt;adapt=
er_index )<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet_pton(AF_INET6, &quot;fe80::8&quot;, =
&amp;msg.gateway.ipv6);<br></div>
=C2=A0 =C2=A0 =C2=A0}<span class=3D"m_2842827072425403884HOEnZb"></span><br=
></blockquote><br>This should fix it. ACK.</div><div class=3D"gmail_quote">=
<div><br></div><div>Selva</div></div></div></div></div>

--001a1143c2acf5901d054b2b5331--

