MIME-Version: 1.0
References: <20230322113249.2039-1-lstipakov@...277...>
In-Reply-To: <20230322113249.2039-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 22 Mar 2023 09:03:02 -0400
Message-ID: <CAKuzo_iT15pQgAOVmr-00Jn4c7Yb_H-j28_S=GZ4_xKaFwLvaw@...278...>
Content-Type: multipart/alternative; boundary="000000000000a7cabd05f77cc8e9"
Subject: Re: [Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--000000000000a7cabd05f77cc8e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2023 at 7:34=E2=80=AFAM Lev Stipakov <lstipakov@...277...> =
wrote:

> From: Lev Stipakov <lev@...515...>
>
> Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/sig.c | 13 +++++++++----
>  src/openvpn/sig.h |  2 +-
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
> index 5b89bb42..05c0054b 100644
> --- a/src/openvpn/sig.c
> +++ b/src/openvpn/sig.c
> @@ -300,18 +300,23 @@ restore_signal_state(void)
>   * Triggered by SIGUSR2 or F2 on Windows.
>   */
>  void
> -print_status(const struct context *c, struct status_output *so)
> +print_status(struct context *c, struct status_output *so)

 {
>      struct gc_arena gc =3D gc_new();
>
>      status_reset(so);
>
> +    if (dco_enabled(&c->options))
> +    {
> +        dco_get_peer_stats(c);
> +    }
> +
>

While this is expedient, adding dco dependence to parts of code which
should be independent of such inner details look wrong style to me. Finding
a way to keep struct context a const here will lead to a better logic, I
think.

Can't we have a coarse timer that keeps the stats updated? It doesn't have
to be frequent as this is just for information.


>      status_printf(so, "OpenVPN STATISTICS");
>      status_printf(so, "Updated,%s", time_string(0, 0, false, &gc));
>      status_printf(so, "TUN/TAP read bytes," counter_format,
> c->c2.tun_read_bytes);
>      status_printf(so, "TUN/TAP write bytes," counter_format,
> c->c2.tun_write_bytes);
> -    status_printf(so, "TCP/UDP read bytes," counter_format,
> c->c2.link_read_bytes);
> -    status_printf(so, "TCP/UDP write bytes," counter_format,
> c->c2.link_write_bytes);
> +    status_printf(so, "TCP/UDP read bytes," counter_format,
> c->c2.link_read_bytes + c->c2.dco_read_bytes);
> +    status_printf(so, "TCP/UDP write bytes," counter_format,
> c->c2.link_write_bytes + c->c2.dco_write_bytes);
>

Same here --  have a place to read the total count from independent of dco.

Selva

--000000000000a7cabd05f77cc8e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Mar 22, 2023 at 7:34=E2=80=AFAM Lev Stipak=
ov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev =
Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...2092...=
..</a>&gt;<br>
<br>
Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/sig.c | 13 +++++++++----<br>
=C2=A0src/openvpn/sig.h |=C2=A0 2 +-<br>
=C2=A02 files changed, 10 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c<br>
index 5b89bb42..05c0054b 100644<br>
--- a/src/openvpn/sig.c<br>
+++ b/src/openvpn/sig.c<br>
@@ -300,18 +300,23 @@ restore_signal_state(void)<br>
=C2=A0 * Triggered by SIGUSR2 or F2 on Windows.<br>
=C2=A0 */<br>
=C2=A0void<br>
-print_status(const struct context *c, struct status_output *so)<br>
+print_status(struct context *c, struct status_output *so)</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
<br>
=C2=A0 =C2=A0 =C2=A0status_reset(so);<br>
<br>
+=C2=A0 =C2=A0 if (dco_enabled(&amp;c-&gt;options))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dco_get_peer_stats(c);<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>While this is expedient, adding dco d=
ependence to parts of code which should be independent of such inner detail=
s look wrong style to me. Finding a way to keep struct context a const here=
 will lead to a better logic, I think.</div><div><br></div><div>Can&#39;t w=
e have a coarse=C2=A0timer that keeps the stats=C2=A0updated? It doesn&#39;=
t have to be frequent as this is just for information.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0status_printf(so, &quot;OpenVPN STATISTICS&quot;);<br>
=C2=A0 =C2=A0 =C2=A0status_printf(so, &quot;Updated,%s&quot;, time_string(0=
, 0, false, &amp;gc));<br>
=C2=A0 =C2=A0 =C2=A0status_printf(so, &quot;TUN/TAP read bytes,&quot; count=
er_format, c-&gt;c2.tun_read_bytes);<br>
=C2=A0 =C2=A0 =C2=A0status_printf(so, &quot;TUN/TAP write bytes,&quot; coun=
ter_format, c-&gt;c2.tun_write_bytes);<br>
-=C2=A0 =C2=A0 status_printf(so, &quot;TCP/UDP read bytes,&quot; counter_fo=
rmat, c-&gt;c2.link_read_bytes);<br>
-=C2=A0 =C2=A0 status_printf(so, &quot;TCP/UDP write bytes,&quot; counter_f=
ormat, c-&gt;c2.link_write_bytes);<br>
+=C2=A0 =C2=A0 status_printf(so, &quot;TCP/UDP read bytes,&quot; counter_fo=
rmat, c-&gt;c2.link_read_bytes + c-&gt;c2.dco_read_bytes);<br>
+=C2=A0 =C2=A0 status_printf(so, &quot;TCP/UDP write bytes,&quot; counter_f=
ormat, c-&gt;c2.link_write_bytes + c-&gt;c2.dco_write_bytes);<br></blockquo=
te><div><br></div><div>Same here --=C2=A0 have a place to read the total co=
unt from independent of dco.</div><div><br></div><div>Selva</div></div></di=
v>

--000000000000a7cabd05f77cc8e9--

