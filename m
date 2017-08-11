MIME-Version: 1.0
In-Reply-To: <20170811090744.31750-6-a@...2181...>
References: <20170811090744.31750-1-a@...2181...>
 <20170811090744.31750-6-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 11 Aug 2017 11:11:21 -0400
Message-ID: <CAKuzo_gpjo3d6O+Z8XrCGt0DVaySR8AZrQ4MyVxqpx0spD8gwQ@...278...>
Content-Type: multipart/alternative; boundary="001a113dcafc06b80405567bbb30"
Subject: Re: [Openvpn-devel] [PATCH 5/5] use NULL instead of 0 when
 assigning pointers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113dcafc06b80405567bbb30
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 11, 2017 at 5:07 AM, Antonio Quartulli <a@...2181...> wrote:

> From: Antonio Quartulli <antonio@...515...>
>
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/ps.c                 | 2 +-
>  src/openvpn/ssl_openssl.c        | 2 +-
>  src/openvpn/ssl_verify_openssl.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
> index 45e24ded..5136a20c 100644
> --- a/src/openvpn/ps.c
> +++ b/src/openvpn/ps.c
> @@ -922,7 +922,7 @@ port_share_open(const char *host,
>          openvpn_close_socket(fd[1]);
>
>          exit(0);
> -        return 0; /* NOTREACHED */
> +        return NULL; /* NOTREACHED */

     }
>
>  error:
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index fa06f068..c977b9e2 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -703,7 +703,7 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO
> *bio)
>      for (;; )
>      {
>          cert = NULL;
> -        if (!PEM_read_bio_X509(bio, &cert, 0, NULL)) /* takes ownership
> of cert */
> +        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL)) /* takes
> ownership of cert */
>          {
>              break;
>          }
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_
> openssl.c
> index ea474955..2f3b10b9 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -202,8 +202,8 @@ extract_x509_field_ssl(X509_NAME *x509, const char
> *field_name, char *out,
>  {
>      int lastpos = -1;
>      int tmp = -1;
> -    X509_NAME_ENTRY *x509ne = 0;
> -    ASN1_STRING *asn1 = 0;
> +    X509_NAME_ENTRY *x509ne = NULL;
> +    ASN1_STRING *asn1 = NULL;
>


Constant 0 or (void *) 0 assigned to a pointer are the same as NULL
pointer, so why bother?

int *a = 0; is perfectly valid in my view.

Of course,
int i = 0; int *a = i;
would be bad style and error-prone, and the compiler would warn, but not
the use of literal 0.

Selva

--001a113dcafc06b80405567bbb30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Aug 11, 2017 at 5:07 AM, Antonio Quartulli <span dir=3D"ltr">&l=
t;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">From: Antonio Quartulli &lt;<=
a href=3D"mailto:antonio@...515...">antonio@...515...</a>&gt;<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:antonio@...515...">a=
ntonio@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 2 +-<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0src/openvpn/ssl_verify_<wbr>openssl.c | 4 ++--<br>
=C2=A03 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c<br>
index 45e24ded..5136a20c 100644<br>
--- a/src/openvpn/ps.c<br>
+++ b/src/openvpn/ps.c<br>
@@ -922,7 +922,7 @@ port_share_open(const char *host,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_close_socket(fd[1]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0; /* NOTREACHED */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL; /* NOTREACHED */</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0error:<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index fa06f068..c977b9e2 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -703,7 +703,7 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *=
bio)<br>
=C2=A0 =C2=A0 =C2=A0for (;; )<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cert =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!PEM_read_bio_X509(bio, &amp;cert, 0, NULL=
)) /* takes ownership of cert */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!PEM_read_bio_X509(bio, &amp;cert, NULL, N=
ULL)) /* takes ownership of cert */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/ssl_verify_<wbr>openssl.c b/src/openvpn/ssl_verify=
_<wbr>openssl.c<br>
index ea474955..2f3b10b9 100644<br>
--- a/src/openvpn/ssl_verify_<wbr>openssl.c<br>
+++ b/src/openvpn/ssl_verify_<wbr>openssl.c<br>
@@ -202,8 +202,8 @@ extract_x509_field_ssl(X509_<wbr>NAME *x509, const char=
 *field_name, char *out,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int lastpos =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0int tmp =3D -1;<br>
-=C2=A0 =C2=A0 X509_NAME_ENTRY *x509ne =3D 0;<br>
-=C2=A0 =C2=A0 ASN1_STRING *asn1 =3D 0;<br>
+=C2=A0 =C2=A0 X509_NAME_ENTRY *x509ne =3D NULL;<br>
+=C2=A0 =C2=A0 ASN1_STRING *asn1 =3D NULL;<br></blockquote><div><br></div><=
div><br></div><div>Constant 0 or (void *) 0 assigned to a pointer are the s=
ame as NULL pointer, so why bother?</div><div><br></div><div>int *a =3D 0; =
is perfectly valid in my view.</div><div>=C2=A0</div><div>Of course,</div><=
div>int i =3D 0; int *a =3D i;=C2=A0</div><div>would be bad style and error=
-prone, and the compiler would warn, but not the use of literal 0.<br></div=
><div><br></div><div>Selva</div></div></div></div>

--001a113dcafc06b80405567bbb30--

