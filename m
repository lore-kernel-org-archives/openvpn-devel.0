MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-10-arne@...1227...>
In-Reply-To: <20211019183127.614175-10-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 23 Oct 2021 13:23:47 -0400
Message-ID: <CAKuzo_g9jyuT=pTbj+vSW_DU4XTQgqMqVtwASaT0FMoBbOTL+Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000f4e68d05cf0864e4"
Subject: Re: [Openvpn-devel] [PATCH v3 09/21] Refactor early initialisation
 and uninitialisation into methods
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f4e68d05cf0864e4
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...> wrote:

> This put the early initialisation and uninitialisation that needs to
> happen between option parsing and post processing into small methods.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/openvpn.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index 0ac961429..f8e94509f 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -105,6 +105,20 @@ tunnel_point_to_point(struct context *c)
>
>  #undef PROCESS_SIGNAL_P2P
>
> +void init_early(struct context *c)
> +{
> +    net_ctx_init(c, &(*c).net_ctx);
>

&c->net_ctx would be more readable and less mysterious.


> +
> +    /* init verbosity and mute levels */
> +    init_verb_mute(c, IVM_LEVEL_1);
> +
> +}
> +
> +static void uninit_early(struct context *c)

+{
> +    net_ctx_free(&(*c).net_ctx);
>

&c->net_ctx


> +}
> +
>
>
>  /**************************************************************************/
>  /**
> @@ -193,10 +207,9 @@ openvpn_main(int argc, char *argv[])
>              open_plugins(&c, true, OPENVPN_PLUGIN_INIT_PRE_CONFIG_PARSE);
>  #endif
>
> -            net_ctx_init(&c, &c.net_ctx);
> -
> -            /* init verbosity and mute levels */
> -            init_verb_mute(&c, IVM_LEVEL_1);
> +            /* Early initialisation that need to happen before option
> +             * post processing and other early startup but after parsing
> */
> +            init_early(&c);
>
>              /* set dev options */
>              init_options_dev(&c.options);
> @@ -308,7 +321,7 @@ openvpn_main(int argc, char *argv[])
>              env_set_destroy(c.es);
>              uninit_options(&c.options);
>              gc_reset(&c.gc);
> -            net_ctx_free(&c.net_ctx);
> +            uninit_early(&c);

         }
>          while (c.sig->signal_received == SIGHUP);
>      }


Looks good otherwise. The nits could be fixed at commit time?

Selva

--000000000000f4e68d05cf0864e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div class=3D"gmail_quote"><div =
class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...2477...=
.">arne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">This put the early initialisation and uninitialisation th=
at needs to<br>
happen between option parsing and post processing into small methods.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/openvpn.c | 23 ++++++++++++++++++-----<br>
=C2=A01 file changed, 18 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c<br>
index 0ac961429..f8e94509f 100644<br>
--- a/src/openvpn/openvpn.c<br>
+++ b/src/openvpn/openvpn.c<br>
@@ -105,6 +105,20 @@ tunnel_point_to_point(struct context *c)<br>
<br>
=C2=A0#undef PROCESS_SIGNAL_P2P<br>
<br>
+void init_early(struct context *c)<br>
+{<br>
+=C2=A0 =C2=A0 net_ctx_init(c, &amp;(*c).net_ctx);<br></blockquote><div><br=
></div><div>&amp;c-&gt;net_ctx would be more readable and less mysterious.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 /* init verbosity and mute levels */<br>
+=C2=A0 =C2=A0 init_verb_mute(c, IVM_LEVEL_1);<br>
+<br>
+}<br>
+<br>
+static void uninit_early(struct context *c)</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 net_ctx_free(&amp;(*c).net_ctx);<br></blockquote><div><br></=
div><div>&amp;c-&gt;net_ctx</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+}<br>
+<br>
<br>
=C2=A0/********************************************************************=
******/<br>
=C2=A0/**<br>
@@ -193,10 +207,9 @@ openvpn_main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open_plugins(&amp;c, true, =
OPENVPN_PLUGIN_INIT_PRE_CONFIG_PARSE);<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 net_ctx_init(&amp;c, &amp;c.net_=
ctx);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* init verbosity and mute level=
s */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_verb_mute(&amp;c, IVM_LEVEL=
_1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Early initialisation that nee=
d to happen before option<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* post processing and othe=
r early startup but after parsing */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_early(&amp;c);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set dev options */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_options_dev(&amp;c.opt=
ions);<br>
@@ -308,7 +321,7 @@ openvpn_main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_set_destroy(<a href=3D"=
http://c.es" rel=3D"noreferrer" target=3D"_blank">c.es</a>);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uninit_options(&amp;c.optio=
ns);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gc_reset(&amp;c.gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 net_ctx_free(&amp;c.net_ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uninit_early(&amp;c);=C2=A0</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (c.sig-&gt;signal_received =3D=3D S=
IGHUP);<br>
=C2=A0 =C2=A0 =C2=A0}</blockquote><div>=C2=A0</div><div>Looks good otherwis=
e. The nits could be fixed at commit time?</div><div><br></div><div>Selva</=
div></div></div>

--000000000000f4e68d05cf0864e4--

