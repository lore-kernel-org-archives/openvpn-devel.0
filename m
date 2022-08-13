MIME-Version: 1.0
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-2-a@...2181...>
In-Reply-To: <20220813204224.22576-2-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 14 Aug 2022 00:34:54 +0300
Message-ID: <CAGyAFMURx14_EW-N2_rCKKD1C0dWsph8BB-Wwu6HbOoCgOmoBg@...278...>
Content-Type: multipart/alternative; boundary="00000000000004297205e6262ca5"
Subject: Re: [Openvpn-devel] [PATCH v101 2/7] dco-win: check for
 incompatible options
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

--00000000000004297205e6262ca5
Content-Type: text/plain; charset="UTF-8"

Again, this cannot be tested yet.

Stared at the code and tested with follow-up commits, looks good and works
as expected.

Acked-by: Lev Stipakov <lstipakov@...277...>


la 13. elok. 2022 klo 23.43 Antonio Quartulli (a@...2181...) kirjoitti:

> At the moment dco-win doesn't support --persist-tun and --server,
> so check for these options at startup time.
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> Changes from v100:
> * improved commit title/message
> ---
>  src/openvpn/dco.c     | 17 +++++++++++++++--
>  src/openvpn/options.c |  5 +++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index b342bee1..dcb570f9 100644
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
> index 14cb4cc4..cec6cf10 100644
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

--00000000000004297205e6262ca5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Again, this cannot be tested yet.<div><br></div><div>Stare=
d at the code and tested with follow-up commits, looks good and works as ex=
pected.</div><div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mail=
to:lstipakov@...277...">lstipakov@...277...</a>&gt;</div><div><br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">la =
13. elok. 2022 klo 23.43 Antonio Quartulli (<a href=3D"mailto:a@...2181..."=
>a@...2181...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">At the moment dco-win doesn&#39;t support --persist-tun and -=
-server,<br>
so check for these options at startup time.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
Changes from v100:<br>
* improved commit title/message<br>
---<br>
=C2=A0src/openvpn/dco.c=C2=A0 =C2=A0 =C2=A0| 17 +++++++++++++++--<br>
=C2=A0src/openvpn/options.c |=C2=A0 5 +++++<br>
=C2=A02 files changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c<br>
index b342bee1..dcb570f9 100644<br>
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
index 14cb4cc4..cec6cf10 100644<br>
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

--00000000000004297205e6262ca5--

