MIME-Version: 1.0
In-Reply-To: <1480051264-30193-1-git-send-email-selva.nair@...277...>
References: <1480022363-24222-1-git-send-email-selva.nair@...277...>
	<1480051264-30193-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 15 Apr 2017 12:33:32 -0400
Message-ID: <CAKuzo_hThVb9Gozz_T0sn0iZoyfNNzR5JnLEtxSrP8x2xTDy0A@...278...>
Content-Type: multipart/alternative; boundary=001a1149d3009d7145054d371feb
Subject: Re: [Openvpn-devel] [PATCH v2] Delete the IPv6 route to the
 "connected" network on tun close
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149d3009d7145054d371feb
Content-Type: text/plain; charset=UTF-8

While cleaning up my local branches this one came up..

Any comments? -- a NAK will do as well so that I can delete it :)

Selva

On Fri, Nov 25, 2016 at 12:21 AM, Selva Nair <selva.nair@...277...> wrote:

> This was missing on Windows when interactive service is in use.
>
> - Added route_ipv6_clear_host_bits(r6) to delete_route_ipv6: this is
>   required for Windows IP-helper API. Won't hurt other platforms (?)
>
> v2: Be const correct: route in delete_route_ipv6() made non-const.
> None of the exisitng calls are affected.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/route.c | 4 +++-
>  src/openvpn/route.h | 2 +-
>  src/openvpn/tun.c   | 3 +++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index fec12c1..34b1196 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2102,7 +2102,7 @@ delete_route (struct route_ipv4 *r,
>  }
>
>  void
> -delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt,
> unsigned int flags, const struct env_set *es)
> +delete_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt,
> unsigned int flags, const struct env_set *es)
>  {
>    struct gc_arena gc;
>    struct argv argv = argv_new ();
> @@ -2124,6 +2124,8 @@ delete_route_ipv6 (const struct route_ipv6 *r6,
> const struct tuntap *tt, unsigne
>
>    gc_init (&gc);
>
> +  route_ipv6_clear_host_bits (r6);
> +
>    network = print_in6_addr( r6->network, 0, &gc);
>    gateway = print_in6_addr( r6->gateway, 0, &gc);
>
> diff --git a/src/openvpn/route.h b/src/openvpn/route.h
> index c358681..70aeb65 100644
> --- a/src/openvpn/route.h
> +++ b/src/openvpn/route.h
> @@ -252,7 +252,7 @@ void copy_route_ipv6_option_list (struct
> route_ipv6_option_list *dest,
>                                    struct gc_arena *a);
>
>  void add_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt,
> unsigned int flags, const struct env_set *es);
> -void delete_route_ipv6 (const struct route_ipv6 *r, const struct tuntap
> *tt, unsigned int flags, const struct env_set *es);
> +void delete_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt,
> unsigned int flags, const struct env_set *es);
>
>  void add_route (struct route_ipv4 *r,
>                 const struct tuntap *tt,
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 560b1a8..40ce202 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5663,6 +5663,9 @@ close_tun (struct tuntap *tt)
>          {
>            if (tt->options.msg_channel)
>              {
> +              /* remove route pointing to interface */
> +              delete_route_connected_v6_net(tt, NULL);
> +
>                do_address_service (false, AF_INET6, tt);
>               if (tt->options.dns6_len > 0)
>                   do_dns6_service (false, tt);
> --
> 2.1.4
>
>

--001a1149d3009d7145054d371feb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">While cleaning up my local branches this one came up..<div=
><br></div><div>Any comments? -- a NAK will do as well so that I can delete=
 it :)</div><div><br></div><div>Selva</div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Fri, Nov 25, 2016 at 12:21 AM, Selva Nai=
r <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_=
blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><span class=3D"">This was missing on Windows when interactive serv=
ice is in use.<br>
<br>
- Added route_ipv6_clear_host_bits(r6) to delete_route_ipv6: this is<br>
=C2=A0 required for Windows IP-helper API. Won&#39;t hurt other platforms (=
?)<br>
<br>
</span>v2: Be const correct: route in delete_route_ipv6() made non-const.<b=
r>
None of the exisitng calls are affected.<br>
<span class=3D""><br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
---<br>
</span>=C2=A0src/openvpn/route.c | 4 +++-<br>
=C2=A0src/openvpn/route.h | 2 +-<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0| 3 +++<br>
=C2=A03 files changed, 7 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index fec12c1..34b1196 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -2102,7 +2102,7 @@ delete_route (struct route_ipv4 *r,<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
-delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, u=
nsigned int flags, const struct env_set *es)<br>
+delete_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigne=
d int flags, const struct env_set *es)<br>
=C2=A0{<br>
=C2=A0 =C2=A0struct gc_arena gc;<br>
=C2=A0 =C2=A0struct argv argv =3D argv_new ();<br>
<span class=3D"">@@ -2124,6 +2124,8 @@ delete_route_ipv6 (const struct rout=
e_ipv6 *r6, const struct tuntap *tt, unsigne<br>
<br>
=C2=A0 =C2=A0gc_init (&amp;gc);<br>
<br>
+=C2=A0 route_ipv6_clear_host_bits (r6);<br>
+<br>
=C2=A0 =C2=A0network =3D print_in6_addr( r6-&gt;network, 0, &amp;gc);<br>
=C2=A0 =C2=A0gateway =3D print_in6_addr( r6-&gt;gateway, 0, &amp;gc);<br>
<br>
</span>diff --git a/src/openvpn/route.h b/src/openvpn/route.h<br>
index c358681..70aeb65 100644<br>
--- a/src/openvpn/route.h<br>
+++ b/src/openvpn/route.h<br>
@@ -252,7 +252,7 @@ void copy_route_ipv6_option_list (struct route_ipv6_opt=
ion_list *dest,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_arena *a);<br>
<br>
=C2=A0void add_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, u=
nsigned int flags, const struct env_set *es);<br>
-void delete_route_ipv6 (const struct route_ipv6 *r, const struct tuntap *t=
t, unsigned int flags, const struct env_set *es);<br>
+void delete_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, uns=
igned int flags, const struct env_set *es);<br>
<br>
=C2=A0void add_route (struct route_ipv4 *r,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tuntap=
 *tt,<br>
<div class=3D"HOEnZb"><div class=3D"h5">diff --git a/src/openvpn/tun.c b/sr=
c/openvpn/tun.c<br>
index 560b1a8..40ce202 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -5663,6 +5663,9 @@ close_tun (struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;options.msg_channel)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* remove route pointing =
to interface */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 delete_route_connected_v6=
_net(<wbr>tt, NULL);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_address_service (=
false, AF_INET6, tt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.dns6_le=
n &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_dns6_serv=
ice (false, tt);<br>
--<br>
2.1.4<br>
<br>
</div></div></blockquote></div><br></div>

--001a1149d3009d7145054d371feb--

