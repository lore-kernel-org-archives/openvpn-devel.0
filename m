MIME-Version: 1.0
References: <20230111160848.22906-1-gert@...1296...>
In-Reply-To: <20230111160848.22906-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 Jan 2023 17:08:53 -0500
Message-ID: <CAKuzo_jEAzk1VgRovhZ0BKPFfYxZfkX0YE62Db7F4iHbQ0L+iA@...278...>
Content-Type: multipart/alternative; boundary="000000000000e4c96905f2043f15"
Subject: Re: [Openvpn-devel] [PATCH] Repair special-casing of EEXIST for
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

--000000000000e4c96905f2043f15
Content-Type: text/plain; charset="UTF-8"

Hi,

Netlink is antonio's realm, but fwiw, I gave it a whirl:

On Wed, Jan 11, 2023 at 11:38 AM Gert Doering <gert@...1296...> wrote:

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
>  - add detailed return code handling to route_add(), assign "2" on
> "-EEXIST"
>    (and log appropriate message).
>
> (Note: sitnl_route_set() is a common function for sitnl route add and
> delete, but EEXIST can not happen on delete - so this change has no
> impact for the "delete" case)
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/networking_sitnl.c |  6 +-----
>  src/openvpn/route.c            | 10 ++++++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/src/openvpn/networking_sitnl.c
> b/src/openvpn/networking_sitnl.c
> index fe124616..92f30044 100644
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
> index 99f948ba..2db127bb 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1594,8 +1594,14 @@ add_route(struct route_ipv4 *r,
>      }
>
>      status = 1;
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
> +        status = 2;
> +    }
> +    else if (ret < 0)
>      {
>          msg(M_WARN, "ERROR: Linux route add command failed");
>          status = 0;
>

Looks good and works as expected. Got CONNECTED,ROUTE_ERROR on real errors,
not if the route exists. Also, an existing route no longer gets removed.

net_route_v4_add is also used in dco.c but there the return value is not
checked and should not be affected by the change as far as I can tell..

A couple of things:

- call to net_route_v6_add() in route_add_ipv6() also could benefit from
the same treatment
- net_route_v?_add() using iproute2 always returns success (0). We
can't distinguish between "exists" and other errors in that case, but still
it should not return unconditional success.

BTW, the same functions in networking_freebsd.c returns 0 on success, +1 on
error, not < 0. Not used in route.c and return value not checked in dco.c
so could be cleaned up in 2.7. I notice Antonio prefers -ve for error, but
that doesn't always work in cross-platform code. On Windows, some error
codes are > 2^31.

One thing to note: when a route exists here we log with D_ROUTE and real
errors with M_WARN. While this should be preferred, we do not do the same
in other route methods like IPAPI or service where such a distinction is
possible. Cases where existing route cannot be reliably detected, we have
no option. Making all route methods log consistently could be a part of the
planned re-write/fixup in 2.7.

Selva

--000000000000e4c96905f2043f15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Netlink is antonio=
&#39;s realm, but fwiw, I gave it a whirl:</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 11, 2023 at 11:=
38 AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"=
>gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">The code in sitnl_route_set() used to treat &quot;route can=
 not be installed<br>
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
=C2=A0- add detailed return code handling to route_add(), assign &quot;2&qu=
ot; on &quot;-EEXIST&quot;<br>
=C2=A0 =C2=A0(and log appropriate message).<br>
<br>
(Note: sitnl_route_set() is a common function for sitnl route add and<br>
delete, but EEXIST can not happen on delete - so this change has no<br>
impact for the &quot;delete&quot; case)<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/networking_sitnl.c |=C2=A0 6 +-----<br>
=C2=A0src/openvpn/route.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +++=
+++++--<br>
=C2=A02 files changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.=
c<br>
index fe124616..92f30044 100644<br>
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
index 99f948ba..2db127bb 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -1594,8 +1594,14 @@ add_route(struct route_ipv4 *r,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0status =3D 1;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D 2;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;ERROR: Linux route add =
command failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D 0;<br></blockquote><div><br></=
div><div>Looks good and works as expected. Got CONNECTED,ROUTE_ERROR on rea=
l errors, not if the route exists. Also, an existing route no longer gets r=
emoved.</div><div><br></div><div>net_route_v4_add is also used in dco.c but=
 there the return value=C2=A0is not checked and should not be affected by t=
he change as far as I can tell..</div><div><br></div><div>A couple of thing=
s:</div><div><br></div><div>- call to net_route_v6_add() in route_add_ipv6(=
) also could benefit from the same treatment</div><div>- net_route_v?_add()=
 using iproute2 always returns success (0). We can&#39;t=C2=A0distinguish=
=C2=A0between &quot;exists&quot; and other errors in that case, but still i=
t should not return unconditional success.</div><div><br></div><div>BTW, th=
e same functions in networking_freebsd.c returns 0 on success,=C2=A0+1 on e=
rror, not &lt; 0. Not used in route.c and return value not checked in dco.c=
 so could be cleaned up in 2.7. I notice Antonio prefers -ve for error, but=
 that doesn&#39;t always work in cross-platform code. On Windows, some erro=
r codes are &gt; 2^31.=C2=A0</div><div><br></div><div>One thing to note: wh=
en a route exists here we log with D_ROUTE and real errors with M_WARN. Whi=
le this should be preferred, we do not do the same in other route methods l=
ike IPAPI or service where such a distinction is possible. Cases where exis=
ting route cannot be reliably detected, we have no option. Making all route=
 methods log consistently could be a part of the planned re-write/fixup in =
2.7.</div><div><br></div><div>Selva</div></div></div>

--000000000000e4c96905f2043f15--

