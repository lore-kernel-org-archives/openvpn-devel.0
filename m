MIME-Version: 1.0
References: <20220812130657.29899-1-a@...2181...>
 <20220812130657.29899-4-a@...2181...>
In-Reply-To: <20220812130657.29899-4-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 12 Aug 2022 19:50:11 +0300
Message-ID: <CAGyAFMXa2z_jhVxhuZYTNDvHghNf1P98vC=81bwG5btT_s1skw@...278...>
Content-Type: multipart/alternative; boundary="000000000000f5865905e60e13ce"
Subject: Re: [Openvpn-devel] [PATCH v100 03/10] dco-win: add platform
 dependant check on incompatible options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000f5865905e60e13ce
Content-Type: text/plain; charset="UTF-8"

Hi,

I think commit message is a bit misleading:

>dco-win: add platform dependant check on incompatible options
>Some platforms may have different constraints in terms of incompatible
>opions, therefore we add a function that explicitly checks those.
>Also, add generic option check for when ovpn-dco-win is in use.

We already have a function which does platform-specific checks on
options and this code only adds Windows-specific checks.

How about:

dco-win: check for incompatible options

At the moment dco-win doesn't support --persist-tun and --server,
so add this to options check.


pe 12. elok. 2022 klo 16.07 Antonio Quartulli (a@...2181...) kirjoitti:

> Some platforms may have different constraints in terms of incompatible
> opions, therefore we add a function that explicitly checks those.
>
> Also, add generic option check for when ovpn-dco-win is in use.
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/dco.c     | 17 +++++++++++++++--
>  src/openvpn/options.c |  5 +++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index ac694d18..d330d917 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -221,7 +221,20 @@ dco_update_keys(dco_context_t *dco, struct tls_multi
> *multi)
>  static bool
>  dco_check_option_conflict_platform(int msglevel, const struct options *o)
>  {
> -#if defined(TARGET_LINUX)
> +#if defined(_WIN32)
> +    if (o->mode == MODE_SERVER)
> +    {
> +        msg(msglevel, "Only client and p2p data channel offload is
> supported "
> +            "with ovpn-dco-win.");
> +        return false;
> +    }
> +
> +    if (o->persist_tun)
> +    {
> +        msg(msglevel, "--persist-tun is not supported with
> ovpn-dco-win.");
> +        return false;
> +    }
> +#elif defined(TARGET_LINUX)
>      /* if the device name is fixed, we need to check if an interface with
> this
>       * name already exists. IF it does, it must be a DCO interface,
> otherwise
>       * DCO has to be disabled in order to continue.
> @@ -246,7 +259,7 @@ dco_check_option_conflict_platform(int msglevel, const
> struct options *o)
>                  strerror(-ret), ret);
>          }
>      }
> -#endif /* if defined(TARGET_LINUX) */
> +#endif /* if defined(_WIN32) */
>      return true;
>  }
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 0ce3158b..90e59582 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2450,6 +2450,11 @@ options_postprocess_verify_ce(const struct options
> *options,
>      {
>          msg(M_USAGE, "--windows-driver wintun requires --dev tun");
>      }
> +
> +    if (options->windows_driver == WINDOWS_DRIVER_DCO)
> +    {
> +        dco_check_option_conflict(M_USAGE, options);
> +    }
>  #endif /* ifdef _WIN32 */
>
>      /*
> --
> 2.35.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000f5865905e60e13ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I think commit=C2=A0message is a bi=
t misleading:</div><div><br></div><div>&gt;dco-win: add platform dependant =
check on incompatible options<br></div><div>&gt;Some platforms may have dif=
ferent constraints in terms of incompatible<br>&gt;opions, therefore we add=
 a function that explicitly checks those.<br>&gt;Also, add generic option c=
heck for when ovpn-dco-win is in use.<br></div><div><br></div><div>We alrea=
dy have a function which does platform-specific checks on</div><div>options=
 and this code only adds Windows-specific checks.</div><div><br></div><div>=
How about:</div><div><br></div><div>dco-win: check for incompatible options=
</div><div><br></div><div>At the moment dco-win doesn&#39;t support --persi=
st-tun and --server,</div><div>so add this to options check.=C2=A0=C2=A0</d=
iv><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">pe 12. elok. 2022 klo 16.07 Antonio Quartulli (<a href=3D=
"mailto:a@...2181...">a@...2181...</a>) kirjoitti:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Some platforms may have different constr=
aints in terms of incompatible<br>
opions, therefore we add a function that explicitly checks those.<br>
<br>
Also, add generic option check for when ovpn-dco-win is in use.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/dco.c=C2=A0 =C2=A0 =C2=A0| 17 +++++++++++++++--<br>
=C2=A0src/openvpn/options.c |=C2=A0 5 +++++<br>
=C2=A02 files changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c<br>
index ac694d18..d330d917 100644<br>
--- a/src/openvpn/dco.c<br>
+++ b/src/openvpn/dco.c<br>
@@ -221,7 +221,20 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *=
multi)<br>
=C2=A0static bool<br>
=C2=A0dco_check_option_conflict_platform(int msglevel, const struct options=
 *o)<br>
=C2=A0{<br>
-#if defined(TARGET_LINUX)<br>
+#if defined(_WIN32)<br>
+=C2=A0 =C2=A0 if (o-&gt;mode =3D=3D MODE_SERVER)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;Only client and p2p data c=
hannel offload is supported &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;with ovpn-dco-win.&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (o-&gt;persist_tun)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;--persist-tun is not suppo=
rted with ovpn-dco-win.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+#elif defined(TARGET_LINUX)<br>
=C2=A0 =C2=A0 =C2=A0/* if the device name is fixed, we need to check if an =
interface with this<br>
=C2=A0 =C2=A0 =C2=A0 * name already exists. IF it does, it must be a DCO in=
terface, otherwise<br>
=C2=A0 =C2=A0 =C2=A0 * DCO has to be disabled in order to continue.<br>
@@ -246,7 +259,7 @@ dco_check_option_conflict_platform(int msglevel, const =
struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(-ret=
), ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-#endif /* if defined(TARGET_LINUX) */<br>
+#endif /* if defined(_WIN32) */<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 0ce3158b..90e59582 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -2450,6 +2450,11 @@ options_postprocess_verify_ce(const struct options *=
options,<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_USAGE, &quot;--windows-driver wintu=
n requires --dev tun&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 if (options-&gt;windows_driver =3D=3D WINDOWS_DRIVER_DCO)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dco_check_option_conflict(M_USAGE, options);<b=
r>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-- <br>
2.35.1<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000f5865905e60e13ce--

