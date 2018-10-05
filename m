MIME-Version: 1.0
References: <20181005135849.28718-1-steffan@...1856...>
In-Reply-To: <20181005135849.28718-1-steffan@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 5 Oct 2018 20:23:28 +0500
Message-ID: <CAFHpkQH_D9EOWCKk8oF8ijqw9=rHuVhSVYJssMe841fNQnrmhg@...278...>
Content-Type: multipart/alternative; boundary="0000000000002cc70505777cdbfd"
Subject: Re: [Openvpn-devel] [PATCH (2.4)] Fix --disable-crypto build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002cc70505777cdbfd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

shall we add "--disable-crypto" to travis-ci matrix in 2.4 branch ?

=D0=BF=D1=82, 5 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 19:00, Steffan Karg=
er <steffan@...1856...>:

> Commit d2ff5164 was fine for the master branch, but broke the 2.4 build if
> the --disable-crypto configure options was used (which is removed in the
> master branch).
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 0950f07e..2d201c44 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -621,9 +621,11 @@ uninit_proxy(struct context *c)
>  static void
>  do_set_ncp_options(struct context *c)
>  {
> +#ifdef ENABLE_CRYPTO
>      c->c1.ciphername =3D c->options.ciphername;
>      c->c1.authname =3D c->options.authname;
>      c->c1.keysize =3D c->options.keysize;
> +#endif ENABLE_CRYPTO
>  }
>
>  /*
> @@ -635,9 +637,11 @@ do_set_ncp_options(struct context *c)
>  static void
>  do_unset_ncp_options(struct context *c)
>  {
> +#ifdef ENABLE_CRYPTO
>      c->options.ciphername =3D c->c1.ciphername;
>      c->options.authname =3D c->c1.authname;
>      c->options.keysize =3D c->c1.keysize;
> +#endif ENABLE_CRYPTO
>  }
>
>  void
> --
> 2.17.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000002cc70505777cdbfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">shall we add &quot;--disable-crypto&quot; to travis-ci mat=
rix in 2.4 branch ?<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
">=D0=BF=D1=82, 5 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 19:00, Steffan Ka=
rger &lt;<a href=3D"mailto:steffan@...1856...">steffan@...1856...</a>&gt;:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Commit d2ff5164 was fine for the ma=
ster branch, but broke the 2.4 build if<br>
the --disable-crypto configure options was used (which is removed in the<br>
master branch).<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856..." tar=
get=3D"_blank">steffan@...1856...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/init.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index 0950f07e..2d201c44 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -621,9 +621,11 @@ uninit_proxy(struct context *c)<br>
=C2=A0static void<br>
=C2=A0do_set_ncp_options(struct context *c)<br>
=C2=A0{<br>
+#ifdef ENABLE_CRYPTO<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;c1.ciphername =3D c-&gt;options.ciphername;<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;c1.authname =3D c-&gt;options.authname;<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;c1.keysize =3D c-&gt;options.keysize;<br>
+#endif ENABLE_CRYPTO<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -635,9 +637,11 @@ do_set_ncp_options(struct context *c)<br>
=C2=A0static void<br>
=C2=A0do_unset_ncp_options(struct context *c)<br>
=C2=A0{<br>
+#ifdef ENABLE_CRYPTO<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;options.ciphername =3D c-&gt;c1.ciphername;<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;options.authname =3D c-&gt;c1.authname;<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;options.keysize =3D c-&gt;c1.keysize;<br>
+#endif ENABLE_CRYPTO<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
-- <br>
2.17.1<br>
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
</blockquote></div>

--0000000000002cc70505777cdbfd--

