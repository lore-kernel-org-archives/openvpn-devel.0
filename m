MIME-Version: 1.0
In-Reply-To: <1466074077-20626-1-git-send-email-arne@...1227...>
References: <56D959C9.8050802@...1227...>
	<1466074077-20626-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 16 Jun 2016 12:07:27 -0400
Message-ID: <CAKuzo_hRCSZH8y1XJr2EOZwNqoZHYNpYU7Vqo+Nt5m_K_AUP7Q@...278...>
Content-Type: multipart/alternative; boundary=001a1148a3425fd48a0535677023
Subject: Re: [Openvpn-devel] [PATCH] Add documentation for
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

--001a1148a3425fd48a0535677023
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 16, 2016 at 6:47 AM, Arne Schwabe <arne@...1227...> wrote:

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
> index f1a4361..da4ad8b 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -497,7 +497,10 @@ and port
>  If HTTP Proxy-Authenticate is required,
>  .B authfile
>  is a file containing a username and password on 2 lines, or
> -"stdin" to prompt from console.
> +"stdin" to prompt from console. Its content can also be specified
> +in the config file with the
> +\.B http-proxy-user-pass
>

man on some systems may treat \.B as .B, but many programs may not parse
that as bold. In any case the macro is

.B not \.B

Also see below on hyphens vs dashes..


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
> +.B \-\-crl-verify, http-proxy-user-pass
>

To be consistent, that would be --http-proxy-user-pass (leading double
dashes missing).

Also using \-  for dashes to distinguish them from hyphens is the usual
practice.

Selva

--001a1148a3425fd48a0535677023
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jun 16, 2016 at 6:47 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":frq" class=3D"a3s aX=
jCH m15558d6a45a96029">=C2=A0Changes.rst=C2=A0 =C2=A0| 4 ++++<br>
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
index f1a4361..da4ad8b 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -497,7 +497,10 @@ and port<br>
=C2=A0If HTTP Proxy-Authenticate is required,<br>
=C2=A0.B authfile<br>
=C2=A0is a file containing a username and password on 2 lines, or<br>
-&quot;stdin&quot; to prompt from console.<br>
+&quot;stdin&quot; to prompt from console. Its content can also be specifie=
d<br>
+in the config file with the<br>
+\.B http-proxy-user-pass<br></div></blockquote><div><br></div><div>man on =
some systems may treat \.B as .B, but many programs may not parse that as b=
old. In any case the macro is</div><div><br></div><div>.B not \.B</div><div=
><br></div><div>Also see below on hyphens vs dashes..</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div id=3D":frq" class=3D"a3s aXjCH m15558d=
6a45a96029">
+option. (See section on inline files)<br>
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
+.B \-\-crl-verify, http-proxy-user-pass<br></div></blockquote><div><br></d=
iv><div>To be consistent, that would be --http-proxy-user-pass (leading dou=
ble dashes missing). </div><div><br></div><div>Also using \- =C2=A0for dash=
es to distinguish them from hyphens is the usual practice.</div><div><br></=
div><div>Selva</div><div><br></div></div><br></div></div>

--001a1148a3425fd48a0535677023--

