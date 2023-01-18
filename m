MIME-Version: 1.0
References: <20230111160848.22906-1-gert@...1296...>
 <20230118074633.27586-1-gert@...1296...>
In-Reply-To: <20230118074633.27586-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 18 Jan 2023 13:14:25 -0500
Message-ID: <CAKuzo_gH7DY_4kve+vWnTJQM2eod-y8AVSmwF-GxagCZTm12BA@...278...>
Content-Type: multipart/alternative; boundary="00000000000041fb5805f28dca49"
Subject: Re: [Openvpn-devel] [PATCH v2] Repair special-casing of EEXIST for
 Linux/SITNL route install
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

--00000000000041fb5805f28dca49
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Jan 18, 2023 at 2:47 AM Gert Doering <gert@...1296...> wrote:

> The code in sitnl_route_set() used to treat "route can not be installed
> because it already exists" (EEXIST) as "not an error".
>
> This is arguably a reasonable approach, but needs to handled higher
> up - if the low level add_route() function say "no error", we will try
> to remove that route later on in delete_route(), possibly removing
> someone else's "already existing" route then.
>
> So:
>  - remove special case in sitnl_route_set()
>  - do not pass NLM_F_REPLACE flag to sitnl_route_set() call - this would
>    cause netlink to just replace existing routes, never return EEXIST
>    (see "man netlink(7)")
>  - add detailed return code handling to add_route(), assign "2" on
> "-EEXIST"
>    (and log appropriate message).
>
> (Note: sitnl_route_set() is a common function for sitnl route add and
> delete, but EEXIST can not happen on delete - so this change has no
> impact for the "delete" case)
>
> v2: use RTA_ macros, also adjust add_route_ipv6()
>

Looks good now  :)


>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/networking_sitnl.c |  6 +-----
>  src/openvpn/route.c            | 24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/src/openvpn/networking_sitnl.c
> b/src/openvpn/networking_sitnl.c
> index dece83c2..cb9a47c0 100644
> --- a/src/openvpn/networking_sitnl.c
> +++ b/src/openvpn/networking_sitnl.c
> @@ -944,10 +944,6 @@ sitnl_route_set(int cmd, uint32_t flags, int ifindex,
> sa_family_t af_family,
>      }
>
>      ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
> -    if (ret == -EEXIST)
> -    {
> -        ret = 0;
> -    }
>  err:
>      return ret;
>  }
> @@ -1177,7 +1173,7 @@ sitnl_route_add(const char *iface, sa_family_t
> af_family, const void *dst,
>          scope = RT_SCOPE_LINK;
>      }
>
> -    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE | NLM_F_REPLACE,
> ifindex,
> +    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex,
>                             af_family, dst, prefixlen, gw, table, metric,
> scope,
>                             RTPROT_BOOT, RTN_UNICAST);
>  }
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 61a40ff1..f1257b00 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1599,8 +1599,14 @@ add_route(struct route_ipv4 *r,
>      }
>
>      status = RTA_SUCCESS;
> -    if (net_route_v4_add(ctx, &r->network,
> netmask_to_netbits2(r->netmask),
> -                         &r->gateway, iface, 0, metric) < 0)
> +    int ret = net_route_v4_add(ctx, &r->network,
> netmask_to_netbits2(r->netmask),
> +                               &r->gateway, iface, 0, metric);
> +    if (ret == -EEXIST)
> +    {
> +        msg(D_ROUTE, "NOTE: Linux route add command failed because route
> exists");
> +        status = RTA_EEXIST;
> +    }
> +    else if (ret < 0)
>      {
>          msg(M_WARN, "ERROR: Linux route add command failed");
>          status = RTA_ERROR;
> @@ -1963,11 +1969,17 @@ add_route_ipv6(struct route_ipv6 *r6, const struct
> tuntap *tt,
>      }
>
>      status = RTA_SUCCESS;
> -    if (net_route_v6_add(ctx, &r6->network, r6->netbits,
> -                         gateway_needed ? &r6->gateway : NULL, device, 0,
> -                         metric) < 0)
> +    int ret = net_route_v6_add(ctx, &r6->network, r6->netbits,
> +                               gateway_needed ? &r6->gateway : NULL,
> +                               device, 0, metric);
> +    if (ret == -EEXIST)
>      {
> -        msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
> +        msg(D_ROUTE, "NOTE: Linux route add command failed because route
> exists");
>

Even the word "Linux" is redundant here and elsewhere, but we need more
changes to make logging consistent and avoid duplicates. Something for 2.7.


> +        status = RTA_EEXIST;
> +    }
> +    else if (ret < 0)
> +    {
> +        msg(M_WARN, "ERROR: Linux route add command failed");
>          status = RTA_ERROR;
>      }
>

Acked-by: Selva Nair <selva.nair@...277...>

--00000000000041fb5805f28dca49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Jan 18, 2023 at 2:47 AM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The code=
 in sitnl_route_set() used to treat &quot;route can not be installed<br>
because it already exists&quot; (EEXIST) as &quot;not an error&quot;.<br>
<br>
This is arguably a reasonable approach, but needs to handled higher<br>
up - if the low level add_route() function say &quot;no error&quot;, we wil=
l try<br>
to remove that route later on in delete_route(), possibly removing<br>
someone else&#39;s &quot;already existing&quot; route then.<br>
<br>
So:<br>
=C2=A0- remove special case in sitnl_route_set()<br>
=C2=A0- do not pass NLM_F_REPLACE flag to sitnl_route_set() call - this wou=
ld<br>
=C2=A0 =C2=A0cause netlink to just replace existing routes, never return EE=
XIST<br>
=C2=A0 =C2=A0(see &quot;man netlink(7)&quot;)<br>
=C2=A0- add detailed return code handling to add_route(), assign &quot;2&qu=
ot; on &quot;-EEXIST&quot;<br>
=C2=A0 =C2=A0(and log appropriate message).<br>
<br>
(Note: sitnl_route_set() is a common function for sitnl route add and<br>
delete, but EEXIST can not happen on delete - so this change has no<br>
impact for the &quot;delete&quot; case)<br>
<br>
v2: use RTA_ macros, also adjust add_route_ipv6()<br></blockquote><div><br>=
</div><div>Looks good now=C2=A0 :)</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/networking_sitnl.c |=C2=A0 6 +-----<br>
=C2=A0src/openvpn/route.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 +++=
+++++++++++++++------<br>
=C2=A02 files changed, 19 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.=
c<br>
index dece83c2..cb9a47c0 100644<br>
--- a/src/openvpn/networking_sitnl.c<br>
+++ b/src/openvpn/networking_sitnl.c<br>
@@ -944,10 +944,6 @@ sitnl_route_set(int cmd, uint32_t flags, int ifindex, =
sa_family_t af_family,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);<br>
-=C2=A0 =C2=A0 if (ret =3D=3D -EEXIST)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0err:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
@@ -1177,7 +1173,7 @@ sitnl_route_add(const char *iface, sa_family_t af_fam=
ily, const void *dst,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scope =3D RT_SCOPE_LINK;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE | NLM_F_RE=
PLACE, ifindex,<br>
+=C2=A0 =C2=A0 return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 af_family, dst, prefixlen, gw, table, metric, scop=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RTPROT_BOOT, RTN_UNICAST);<br>
=C2=A0}<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index 61a40ff1..f1257b00 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -1599,8 +1599,14 @@ add_route(struct route_ipv4 *r,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0status =3D RTA_SUCCESS;<br>
-=C2=A0 =C2=A0 if (net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_net=
bits2(r-&gt;netmask),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;r-&gt;gateway, iface, 0, metric) &lt; 0)<br>
+=C2=A0 =C2=A0 int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmas=
k_to_netbits2(r-&gt;netmask),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;r-&gt;gateway, iface, 0, metric)=
;<br>
+=C2=A0 =C2=A0 if (ret =3D=3D -EEXIST)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_ROUTE, &quot;NOTE: Linux route add comma=
nd failed because route exists&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D RTA_EEXIST;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;ERROR: Linux route add =
command failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D RTA_ERROR;<br>
@@ -1963,11 +1969,17 @@ add_route_ipv6(struct route_ipv6 *r6, const struct =
tuntap *tt,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0status =3D RTA_SUCCESS;<br>
-=C2=A0 =C2=A0 if (net_route_v6_add(ctx, &amp;r6-&gt;network, r6-&gt;netbit=
s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0gateway_needed ? &amp;r6-&gt;gateway : NULL, device, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0metric) &lt; 0)<br>
+=C2=A0 =C2=A0 int ret =3D net_route_v6_add(ctx, &amp;r6-&gt;network, r6-&g=
t;netbits,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gateway_needed ? &amp;r6-&gt;gateway =
: NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device, 0, metric);<br>
+=C2=A0 =C2=A0 if (ret =3D=3D -EEXIST)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;ERROR: Linux IPv6 route can&=
#39;t be added&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_ROUTE, &quot;NOTE: Linux route add comma=
nd failed because route exists&quot;);<br>
</blockquote><div><br></div><div>Even the word &quot;Linux&quot; is redunda=
nt here and elsewhere, but we need more changes to make logging consistent =
and avoid duplicates. Something for 2.7.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =
=3D RTA_EEXIST;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;ERROR: Linux route add comma=
nd failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D RTA_ERROR;<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>Acked-by: Selva N=
air &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nai=
r@...277...</a>&gt;=C2=A0</div></div></div>

--00000000000041fb5805f28dca49--

