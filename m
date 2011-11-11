From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 11 Nov 2011 11:11:06 +0100
Message-ID: <6786111.khz1FHIxJB@...1524...>
In-Reply-To: <1320074961-3809-9-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
	<1320074961-3809-9-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="nextPart1826289.xy28apzrLp"
Content-Transfer-Encoding: 7Bit
Subject: Re: [Openvpn-devel] [PATCH 8/8] Fixed a typo when initialising
	cryptoapi certs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart1826289.xy28apzrLp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 31 October 2011 15:29:21 Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
>  ssl_openssl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/ssl_openssl.c b/ssl_openssl.c
> index 391968a..b95944c 100644
> --- a/ssl_openssl.c
> +++ b/ssl_openssl.c
> @@ -339,7 +339,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const
> char *cryptoapi_cert) /* Load Certificate and Private Key */
>    if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
>      msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft
> Certificate Store", -	   options->cryptoapi_cert);
> +	   cryptoapi_cert);
>  }
>  #endif /* WIN32 */

ACK, as this fixes building git master for Windows.
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen



--nextPart1826289.xy28apzrLp
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"text/cs=
s">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'Courier New'; font-size:8pt; fo=
nt-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Monday 3=
1 October 2011 15:29:21 Adriaan de Jong wrote:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Signed=
-off-by: Adriaan de Jong &lt;dejong@...1435...&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; ---</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;  ssl_o=
penssl.c |    2 +-</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;  1 fil=
es changed, 1 insertions(+), 1 deletions(-)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; diff -=
-git a/ssl_openssl.c b/ssl_openssl.c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; index =
391968a..b95944c 100644</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; --- a/=
ssl_openssl.c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; +++ b/=
ssl_openssl.c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; @@ -33=
9,7 +339,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; char *=
cryptoapi_cert) /* Load Certificate and Private Key */</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;    if =
(!SSL_CTX_use_CryptoAPI_certificate (ctx-&gt;ctx, cryptoapi_cert))</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;      m=
sg (M_SSLERR, &quot;Cannot load certificate \&quot;%s\&quot; from Microsoft=
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Certif=
icate Store&quot;, -	   options-&gt;cryptoapi_cert);</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; +	   c=
ryptoapi_cert);</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;  }</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;  #endi=
f /* WIN32 */</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">ACK, as thi=
s fixes building git master for Windows.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-- </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Heiko Hund =
| Software Engineer | Phone +49-721-25516-237 | Fax -200</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Astaro a So=
phos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Commercial =
Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"> </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Represented=
 by the General Partner Astaro Verwaltungs GmbH</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Amalienbads=
tra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Commercial =
Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Markus Henn=
ig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p></body></html>=

--nextPart1826289.xy28apzrLp--

