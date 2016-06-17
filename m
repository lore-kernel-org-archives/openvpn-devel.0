MIME-Version: 1.0
In-Reply-To: <1466167786-13748-1-git-send-email-arne@...1227...>
References: <56D959C9.8050802@...1227...>
	<1466167786-13748-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 17 Jun 2016 14:39:35 -0400
Message-ID: <CAKuzo_jy0nWVR9Nf8iZ-Eu1aCyUgKe+M5E7XeN9yczNqGft8UA@...278...>
Content-Type: multipart/alternative; boundary=001a11409f26518cc905357daea6
Subject: Re: [Openvpn-devel] [PATCH v2] Add documentation for
 http-proxy-user-pass option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11409f26518cc905357daea6
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 17, 2016 at 8:49 AM, Arne Schwabe <arne@...1227...> wrote:

> Patch V2: fix formatting problems
> ---
>  Changes.rst   | 4 ++++
>  doc/openvpn.8 | 7 +++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index ab322e2..f945ad7 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -51,6 +51,10 @@ AEAD (GCM) data channel cipher support
>      bytes per packet for AES-128-GCM instead of 36 bytes per packet for
>      AES-128-CBC + HMAC-SHA1).
>
> +Http proxy password inside config file
> +       Http proxy passwords can be specified with the inline file option
> +    http-proxy-user-pass
> +
>
>  User-visible Changes
>  --------------------
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index f1a4361..6e8a6c1 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -497,7 +497,10 @@ and port
>  If HTTP Proxy-Authenticate is required,
>  .B authfile
>  is a file containing a username and password on 2 lines, or
> -"stdin" to prompt from console.
> +"stdin" to prompt from console. Its content can also be specified
> +in the config file with the
> +.B \-\-http\-proxy\-user\-pass
> +option. (See section on inline files)
>
>  .B auth\-method
>  should be one of "none", "basic", or "ntlm".
> @@ -6581,7 +6584,7 @@ X509_1_C=KG
>  .SH INLINE FILE SUPPORT
>  OpenVPN allows including files in the main configuration for the
>  .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12,
> \-\-secret,
> -.B \-\-crl-verify
> +.B \-\-crl-verify,\-\-http\-proxy\-user\-pass
>

At merge time crl-verify  on that line may be changed to crl\-verify too.
Not a fault of this patch.

ACK.

Selva

--001a11409f26518cc905357daea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 17, 2016 at 8:49 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div>Patch V2: fix formatting pr=
oblems<br>
---<br>
<span>=C2=A0Changes.rst=C2=A0 =C2=A0| 4 ++++<br>
=C2=A0doc/openvpn.8 | 7 +++++--<br>
=C2=A02 files changed, 9 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/Changes.rst b/Changes.rst<br>
index ab322e2..f945ad7 100644<br>
--- a/Changes.rst<br>
+++ b/Changes.rst<br>
@@ -51,6 +51,10 @@ AEAD (GCM) data channel cipher support<br>
=C2=A0 =C2=A0 =C2=A0bytes per packet for AES-128-GCM instead of 36 bytes pe=
r packet for<br>
=C2=A0 =C2=A0 =C2=A0AES-128-CBC + HMAC-SHA1).<br>
<br>
+Http proxy password inside config file<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Http proxy passwords can be specified with the =
inline file option<br>
+=C2=A0 =C2=A0 http-proxy-user-pass<br>
+<br>
<br>
=C2=A0User-visible Changes<br>
=C2=A0--------------------<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
</span>index f1a4361..6e8a6c1 100644<br>
<span>--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -497,7 +497,10 @@ and port<br>
=C2=A0If HTTP Proxy-Authenticate is required,<br>
=C2=A0.B authfile<br>
=C2=A0is a file containing a username and password on 2 lines, or<br>
-&quot;stdin&quot; to prompt from console.<br>
+&quot;stdin&quot; to prompt from console. Its content can also be specifie=
d<br>
+in the config file with the<br>
</span>+.B \-\-http\-proxy\-user\-pass<br>
<span>+option. (See section on inline files)<br>
<br>
=C2=A0.B auth\-method<br>
=C2=A0should be one of &quot;none&quot;, &quot;basic&quot;, or &quot;ntlm&q=
uot;.<br>
@@ -6581,7 +6584,7 @@ X509_1_C=3DKG<br>
=C2=A0.SH INLINE FILE SUPPORT<br>
=C2=A0OpenVPN allows including files in the main configuration for the<br>
=C2=A0.B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \=
-\-secret,<br>
-.B \-\-crl-verify<br>
</span>+.B \-\-crl-verify,\-\-http\-proxy\-user\-pass<br></div></blockquote=
><div><br></div><div class=3D"gmail_extra">At merge time crl-verify=C2=A0 o=
n that line may be changed to crl\-verify too.=C2=A0 Not a fault of this pa=
tch. <br><br>ACK.<br><br></div><div class=3D"gmail_extra">Selva</div></div>=
</div></div>

--001a11409f26518cc905357daea6--

