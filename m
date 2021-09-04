MIME-Version: 1.0
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-3-a@...2181...>
In-Reply-To: <20210904095629.6273-3-a@...2181...>
From: Greg Cox <gcox@...1057...>
Date: Sat, 4 Sep 2021 19:06:25 +0000
Message-ID: <CACDCbPqH6fQvLZAYfbX3Vn95ns7mh81srJ_MVVc9_zE1KHDcRA@...278...>
Content-Type: multipart/alternative; boundary="00000000000071f89205cb301d56"
Subject: Re: [Openvpn-devel] [PATCH 2/7] compat-mode: allow user to specify
 version to be compatible with
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000071f89205cb301d56
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 4, 2021 at 9:57 AM Antonio Quartulli <a@...2181...> wrote:

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 0d6b85cf..4d971a56 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3125,6 +3125,29 @@ options_postprocess_cipher(struct options *o)
>      }
>  }
>
> +/**
> + * Returns if we want 'backwards-compatibility' up to (but not included) a
> + * certain version
> + *
> + * @param version   the oldest version that does not compatibility
>

I feel like you dropped a word in here ^^

> + *                  e.g. 20400 for all versions < 2.4.0
> + * @return          whether compatibility should be enabled
> + */
> +static bool
> +need_compatibility_before(const struct options *o, int version)
>

I feel like you want to do `unsigned int` on your version parameter here
(why would a version go negative?) ...



> +{
> +    return o->backwards_compatible != 0 && o->backwards_compatible <
> version;
> +}
> +
> +/**
> + * Changes default values so that OpenVPN can be compatible with the user
> + * specified version
> + */
> +static void
> +options_set_backwards_compatible_options(struct options *o)
> +{
> +}
> +
>  static void
>  options_postprocess_mutate(struct options *o)
>  {
> @@ -3137,6 +3160,8 @@ options_postprocess_mutate(struct options *o)
>      helper_keepalive(o);
>      helper_tcp_nodelay(o);
>
> +    options_set_backwards_compatible_options(o);
> +
>      options_postprocess_cipher(o);
>      options_postprocess_mutate_invariant(o);
>
> @@ -6698,6 +6723,18 @@ add_option(struct options *options,
>              setenv_str(es, p[1], p[2] ? p[2] : "");
>          }
>      }
> +    else if (streq(p[0], "compat-mode") && p[1] && !p[3])
> +    {
> +        unsigned int major, minor, patch;
> +        if (!(sscanf(p[1], "%u.%u.%u", &major, &minor, &patch) == 3))
> +        {
> +            msg(msglevel, "cannot parse version number for --compat-mode:
> %s",
> +                p[1]);
> +            goto err;
> +        }
> +
> +        options->backwards_compatible = major * 10000 + minor * 100 +
> patch;
> +    }
>      else if (streq(p[0], "setenv-safe") && p[1] && !p[3])
>      {
>          VERIFY_PERMISSION(OPT_P_SETENV);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index b0e40cb7..98c21a2a 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -225,6 +225,10 @@ struct options
>
>      /* enable forward compatibility for post-2.1 features */
>      bool forward_compatible;
> +    /** What version we should try to be compatible with as major * 10000
> +
> +      * minor * 100 + patch, e.g. 2.4.7 => 20407 */
> +    unsigned int backwards_compatible;
>

... doubly so because you use `unsigned int` (imo rightly) here.

> +
>      /* list of options that should be ignored even if unknown */
>      const char **ignore_unknown_option;
>
> --
> 2.32.0
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000071f89205cb301d56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:courier new,monospace"><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 4, 2021 at 9:57 AM An=
tonio Quartulli &lt;a@...2181...&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c<br>
index 0d6b85cf..4d971a56 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -3125,6 +3125,29 @@ options_postprocess_cipher(struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+/**<br>
+ * Returns if we want &#39;backwards-compatibility&#39; up to (but not inc=
luded) a<br>
+ * certain version<br>
+ *<br>
+ * @param version=C2=A0 =C2=A0the oldest version that does not compatibili=
ty<br>
</blockquote><div><br></div><div style=3D"font-family:courier new,monospace=
" class=3D"gmail_default">I feel like you dropped a word in here ^^</div><d=
iv style=3D"font-family:courier new,monospace" class=3D"gmail_default"></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">+ *=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e.g. 20400 for all versions &lt;=
 2.4.0<br>
+ * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 whether compatibility should =
be enabled<br>
+ */<br>
+static bool<br>
+need_compatibility_before(const struct options *o, int version)<br>
</blockquote><div><br></div><div><div style=3D"font-family:courier new,mono=
space" class=3D"gmail_default">I feel like you want to do `unsigned int` on=
 your version parameter here (why would a version go negative?) ...<br></di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">+{<br>
+=C2=A0 =C2=A0 return o-&gt;backwards_compatible !=3D 0 &amp;&amp; o-&gt;ba=
ckwards_compatible &lt; version;<br>
+}<br>
+<br>
+/**<br>
+ * Changes default values so that OpenVPN can be compatible with the user<=
br>
+ * specified version<br>
+ */<br>
+static void<br>
+options_set_backwards_compatible_options(struct options *o)<br>
+{<br>
+}<br>
+<br>
=C2=A0static void<br>
=C2=A0options_postprocess_mutate(struct options *o)<br>
=C2=A0{<br>
@@ -3137,6 +3160,8 @@ options_postprocess_mutate(struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0helper_keepalive(o);<br>
=C2=A0 =C2=A0 =C2=A0helper_tcp_nodelay(o);<br>
<br>
+=C2=A0 =C2=A0 options_set_backwards_compatible_options(o);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0options_postprocess_cipher(o);<br>
=C2=A0 =C2=A0 =C2=A0options_postprocess_mutate_invariant(o);<br>
<br>
@@ -6698,6 +6723,18 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setenv_str(es, p[1], p[2] ?=
 p[2] : &quot;&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 else if (streq(p[0], &quot;compat-mode&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[3])<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int major, minor, patch;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(sscanf(p[1], &quot;%u.%u.%u&quot;, &amp;=
major, &amp;minor, &amp;patch) =3D=3D 3))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;cannot parse=
 version number for --compat-mode: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;backwards_compatible =3D major * 1=
0000 + minor * 100 + patch;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;setenv-safe&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[3])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_SETENV);<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index b0e40cb7..98c21a2a 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -225,6 +225,10 @@ struct options<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* enable forward compatibility for post-2.1 features *=
/<br>
=C2=A0 =C2=A0 =C2=A0bool forward_compatible;<br>
+=C2=A0 =C2=A0 /** What version we should try to be compatible with as majo=
r * 10000 +<br>
+=C2=A0 =C2=A0 =C2=A0 * minor * 100 + patch, e.g. 2.4.7 =3D&gt; 20407 */<br>
+=C2=A0 =C2=A0 unsigned int backwards_compatible;<br></blockquote><div><br>=
</div><div style=3D"font-family:courier new,monospace" class=3D"gmail_defau=
lt">... doubly so because you use `unsigned int` (imo rightly) here.</div><=
div style=3D"font-family:courier new,monospace" class=3D"gmail_default"></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0/* list of options that should be ignored even if unkno=
wn */<br>
=C2=A0 =C2=A0 =C2=A0const char **ignore_unknown_option;<br>
<br>
-- <br>
2.32.0<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--00000000000071f89205cb301d56--

