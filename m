MIME-Version: 1.0
In-Reply-To: <1385210434-28364-1-git-send-email-arne@...1227...>
References: <20131123121335.GA27496@...1296...>
	<1385210434-28364-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 23 Nov 2013 13:46:23 +0100
Message-ID: <CAA1AbxJYSMkSCzbaQL5-Nb4D-uObHe_ePPqSMwEr93HF=kA0=w@...278...>
Content-Type: multipart/alternative; boundary=001a1132f112dfeef904ebd78586
Subject: Re: [Openvpn-devel] [PATCH] Fix compile error in ssl_openssl
 introduced by polar external-management patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1132f112dfeef904ebd78586
Content-Type: text/plain; charset=ISO-8859-1

Argh, this must have slipped in while rewriting my git history to extract
these patches from my own try. Sorry!

ACK to Arne's quick fix, thanks for acting quickly.

-Steffan


On Sat, Nov 23, 2013 at 1:40 PM, Arne Schwabe <arne@...1227...> wrote:

> ---
>  src/openvpn/ssl_openssl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index d6e194a..120aa66 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -534,7 +534,7 @@ void
>  tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
>      const char *cert_file_inline)
>  {
> -  tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, NULL);
> +  tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline,
> NULL);
>  }
>
>  void
> @@ -684,7 +684,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx
> *ctx,
>    ASSERT (NULL != ctx);
>    ASSERT (NULL != cert);
>
> -  tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, &cert);
> +  tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline,
> &cert);
>
>    /* allocate custom RSA method object */
>    ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);
> --
> 1.8.3.4 (Apple Git-47)
>
>
>
> ------------------------------------------------------------------------------
> Shape the Mobile Experience: Free Subscription
> Software experts and developers: Be at the forefront of tech innovation.
> Intel(R) Software Adrenaline delivers strategic insight and game-changing
> conversations that shape the rapidly evolving mobile landscape. Sign up
> now.
> http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a1132f112dfeef904ebd78586
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Argh, this must have slipped in while rewriting my git his=
tory to extract these patches from my own try. Sorry!<div><br></div><div>AC=
K to Arne&#39;s quick fix, thanks for acting quickly.</div><div><br></div>

<div>-Steffan</div></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">On Sat, Nov 23, 2013 at 1:40 PM, Arne Schwabe <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</=
a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">---<br>
=A0src/openvpn/ssl_openssl.c | 4 ++--<br>
=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index d6e194a..120aa66 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -534,7 +534,7 @@ void<br>
=A0tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,=
<br>
=A0 =A0 =A0const char *cert_file_inline)<br>
=A0{<br>
- =A0tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, NULL);<br>
+ =A0tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline, NUL=
L);<br>
=A0}<br>
<br>
=A0void<br>
@@ -684,7 +684,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *=
ctx,<br>
=A0 =A0ASSERT (NULL !=3D ctx);<br>
=A0 =A0ASSERT (NULL !=3D cert);<br>
<br>
- =A0tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, &amp;cert=
);<br>
+ =A0tls_ctx_load_cert_file_and_copy (ctx, cert_file, cert_file_inline, &am=
p;cert);<br>
<br>
=A0 =A0/* allocate custom RSA method object */<br>
=A0 =A0ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);<br>
--<br>
1.8.3.4 (Apple Git-47)<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Shape the Mobile Experience: Free Subscription<br>
Software experts and developers: Be at the forefront of tech innovation.<br>
Intel(R) Software Adrenaline delivers strategic insight and game-changing<b=
r>
conversations that shape the rapidly evolving mobile landscape. Sign up now=
.<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D63431311&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D63431311&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br></div>

--001a1132f112dfeef904ebd78586--

