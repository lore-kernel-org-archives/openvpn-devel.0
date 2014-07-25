MIME-Version: 1.0
Sender: pstew@...410...
In-Reply-To: <20140509162908.375CFE0247@...1914...>
References: <20140509162908.375CFE0247@...1914...>
Date: Fri, 25 Jul 2014 09:12:24 -0700
Message-ID: <CAMcMvshHHCCVN97Zi_8oaswAxQDjW3R9nTMqyTLjoH7X0FPZDQ@...278...>
From: Paul Stewart <pstew@...1913...>
Content-Type: multipart/alternative; boundary=047d7b5d4b46c300cc04ff06d6aa
Subject: Re: [Openvpn-devel] [PATCH] Export --redirect-gateway parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7b5d4b46c300cc04ff06d6aa
Content-Type: text/plain; charset=UTF-8

Anyone in particular I should Cc this change to?


On Fri, May 9, 2014 at 9:23 AM, Paul Stewart <pstew@...1913...> wrote:

> Report the flags passed to the --redirect-gateway and
> --redirect-private flags, so that systems that manage routing
> tables have hints about how the routing table should be modified.
>
> Signed-off-by: Paul Stewart <pstew@...1913...>
> ---
>  doc/openvpn.8       | 10 ++++++++++
>  src/openvpn/route.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 34894e5..40ea46c 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5924,6 +5924,16 @@ modifier is specified, and deleted from the
> environment
>  after the script returns.
>  .\"*********************************************************
>  .TP
> +.B redirect_gateway
> +The comma-separated list of flags provided to the
> +.B \-\-redirect-gateway
> +option.
> +.TP
> +.B redirect_private
> +The comma-separated list of flags provided to the
> +.B \-\-redirect-private
> +option.
> +.TP
>  .B proto
>  The
>  .B \-\-proto
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 12f5b62..8c29e16 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -548,6 +548,35 @@ add_block_local (struct route_list *rl)
>      }
>  }
>
> +static void
> +setenv_redirect_gateway (struct env_set *es, unsigned int flags) {
> +  struct gc_arena gc = gc_new ();
> +  if (flags & RG_ENABLE)
> +    {
> +      struct buffer val = alloc_buf_gc( 256, &gc );
> +      char *name = "redirect_private";
> +
> +      if (flags & RG_REROUTE_GW)
> +       name = "redirect_gateway";
> +      if (flags & RG_LOCAL)
> +       buf_printf( &val, "local,");
> +      if (flags & RG_AUTO_LOCAL)
> +       buf_printf( &val, "autolocal,");
> +      if (flags & RG_DEF1)
> +       buf_printf( &val, "def1,");
> +      if (flags & RG_BYPASS_DHCP)
> +       buf_printf( &val, "bypass-dhcp,");
> +      if (flags & RG_BYPASS_DNS)
> +       buf_printf( &val, "bypass-dns,");
> +      if (flags & RG_BLOCK_LOCAL)
> +       buf_printf( &val, "block-local,");
> +      buf_rmtail(&val, ',');
> +
> +      setenv_str( es, name, BSTR(&val) );
> +    }
> +  gc_free (&gc);
> +}
> +
>  bool
>  init_route_list (struct route_list *rl,
>                  const struct route_option_list *opt,
> @@ -620,6 +649,7 @@ init_route_list (struct route_list *rl,
>      {
>        add_block_local (rl);
>        get_bypass_addresses (&rl->spec.bypass, rl->flags);
> +      setenv_redirect_gateway(es, rl->flags);
>  #ifdef ENABLE_DEBUG
>        print_bypass_addresses (&rl->spec.bypass);
>  #endif
> --
> 1.9.1.423.g4596e3a
>
>

--047d7b5d4b46c300cc04ff06d6aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Anyone in particular I should Cc this change to?</div><div=
 class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, May 9, 20=
14 at 9:23 AM, Paul Stewart <span dir=3D"ltr">&lt;<a href=3D"mailto:pstew@...220...=
..1913..." target=3D"_blank">pstew@...1913...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Report the flags passed to the --redirect-ga=
teway and<br>
--redirect-private flags, so that systems that manage routing<br>
tables have hints about how the routing table should be modified.<br>
<br>
Signed-off-by: Paul Stewart &lt;<a href=3D"mailto:pstew@...1913...">pstew@...220...=
..1913...</a>&gt;<br>
---<br>
=C2=A0doc/openvpn.8 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
=C2=A0src/openvpn/route.c | 30 ++++++++++++++++++++++++++++++<br>
=C2=A02 files changed, 40 insertions(+)<br>
<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index 34894e5..40ea46c 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -5924,6 +5924,16 @@ modifier is specified, and deleted from the environm=
ent<br>
=C2=A0after the script returns.<br>
=C2=A0.\&quot;*********************************************************<br>
=C2=A0.TP<br>
+.B redirect_gateway<br>
+The comma-separated list of flags provided to the<br>
+.B \-\-redirect-gateway<br>
+option.<br>
+.TP<br>
+.B redirect_private<br>
+The comma-separated list of flags provided to the<br>
+.B \-\-redirect-private<br>
+option.<br>
+.TP<br>
=C2=A0.B proto<br>
=C2=A0The<br>
=C2=A0.B \-\-proto<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index 12f5b62..8c29e16 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -548,6 +548,35 @@ add_block_local (struct route_list *rl)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void<br>
+setenv_redirect_gateway (struct env_set *es, unsigned int flags) {<br>
+ =C2=A0struct gc_arena gc =3D gc_new ();<br>
+ =C2=A0if (flags &amp; RG_ENABLE)<br>
+ =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0struct buffer val =3D alloc_buf_gc( 256, &amp;gc );<b=
r>
+ =C2=A0 =C2=A0 =C2=A0char *name =3D &quot;redirect_private&quot;;<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_REROUTE_GW)<br>
+ =C2=A0 =C2=A0 =C2=A0 name =3D &quot;redirect_gateway&quot;;<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_LOCAL)<br>
+ =C2=A0 =C2=A0 =C2=A0 buf_printf( &amp;val, &quot;local,&quot;);<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_AUTO_LOCAL)<br>
+ =C2=A0 =C2=A0 =C2=A0 buf_printf( &amp;val, &quot;autolocal,&quot;);<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_DEF1)<br>
+ =C2=A0 =C2=A0 =C2=A0 buf_printf( &amp;val, &quot;def1,&quot;);<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_BYPASS_DHCP)<br>
+ =C2=A0 =C2=A0 =C2=A0 buf_printf( &amp;val, &quot;bypass-dhcp,&quot;);<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_BYPASS_DNS)<br>
+ =C2=A0 =C2=A0 =C2=A0 buf_printf( &amp;val, &quot;bypass-dns,&quot;);<br>
+ =C2=A0 =C2=A0 =C2=A0if (flags &amp; RG_BLOCK_LOCAL)<br>
+ =C2=A0 =C2=A0 =C2=A0 buf_printf( &amp;val, &quot;block-local,&quot;);<br>
+ =C2=A0 =C2=A0 =C2=A0buf_rmtail(&amp;val, &#39;,&#39;);<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0setenv_str( es, name, BSTR(&amp;val) );<br>
+ =C2=A0 =C2=A0}<br>
+ =C2=A0gc_free (&amp;gc);<br>
+}<br>
+<br>
=C2=A0bool<br>
=C2=A0init_route_list (struct route_list *rl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
route_option_list *opt,<br>
@@ -620,6 +649,7 @@ init_route_list (struct route_list *rl,<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0add_block_local (rl);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0get_bypass_addresses (&amp;rl-&gt;spec.bypass, r=
l-&gt;flags);<br>
+ =C2=A0 =C2=A0 =C2=A0setenv_redirect_gateway(es, rl-&gt;flags);<br>
=C2=A0#ifdef ENABLE_DEBUG<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0print_bypass_addresses (&amp;rl-&gt;spec.bypass)=
;<br>
=C2=A0#endif<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1.423.g4596e3a<br>
<br>
</font></span></blockquote></div><br></div>

--047d7b5d4b46c300cc04ff06d6aa--

