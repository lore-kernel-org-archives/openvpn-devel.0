MIME-Version: 1.0
References: <20220119151941.37529-1-openvpn@...2080...>
In-Reply-To: <20220119151941.37529-1-openvpn@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Jan 2022 11:34:14 -0500
Message-ID: <CAKuzo_jNmt+Gmb7DVnxv9UNy43whxJ=43K9Gz7P2muxUqgX5cg@...278...>
Content-Type: multipart/alternative; boundary="000000000000cbe2b605d5f1f539"
Subject: Re: [Openvpn-devel] [PATCH v2] crypto: Fix OPENSSL_FIPS enabled
 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cbe2b605d5f1f539
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for chiming in late:

On Wed, Jan 19, 2022 at 10:20 AM David Sommerseth <
openvpn@...2080...> wrote:

> From: David Sommerseth <davids@...515...>
>
> On Fedora and RHEL/CentOS, the standard OpenSSL library has the FIPS
> module enabled by default.  On these platforms, the OPENSSL_FIPS macro
> is always defined via /usr/include/openssl/opensslconf-*.h.
>
> Without this fix, the following compilation error appears:
>
>   ./src/openvpn/crypto.c: In function =E2=80=98print_cipher=E2=80=99:
>   ./src/openvpn/crypto.c:1707:43: error: =E2=80=98cipher=E2=80=99 undecla=
red (first use in
> this function); did you mean =E2=80=98iphdr=E2=80=99?
>        if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS=
))
>                                            ^~~~~~
>
> The EVP_CIPHER_fetch() and EVP_CIPHER_free() methods are also provided
> via the openssl_compat.h for older than OpenSSL 3.0.
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/crypto.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 5626e2b6..e489d453 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -34,6 +34,7 @@
>  #include "error.h"
>  #include "integer.h"
>  #include "platform.h"
> +#include "openssl_compat.h"
>
>  #include "memdbg.h"
>
> @@ -1704,10 +1705,13 @@ print_cipher(const char *ciphername)
>          printf(", TLS client/server mode only");
>      }
>  #ifdef OPENSSL_FIPS
> +    evp_cipher_type *cipher =3D EVP_CIPHER_fetch(NULL, ciphername, NULL);
> +
>      if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
>

We need to check that cipher is not NULL. Fetch can return NULL while
EVP_CIPHER_flags() requires a non-null argument. Something like: if (cipher
&& FIPS_mode && etc...) will do.

EVP_CIPHER_free() below can handle NULL, so no problem there.



   {
>          printf(", disabled by FIPS mode");
>      }
> +    EVP_CIPHER_free(cipher);

 #endif
>
>      printf(")\n");
>

Selva

--000000000000cbe2b605d5f1f539
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>Sorry for chiming in late:<di=
v><br><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, Jan 19, 2022 at 10:20 AM David Sommerseth &lt;<a href=3D"mailto:op=
envpn@...2080...">openvpn@...2080...</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">From: David Sommerseth &lt;<a href=3D"m=
ailto:davids@...515..." target=3D"_blank">davids@...515...</a>&gt;<br>
<br>
On Fedora and RHEL/CentOS, the standard OpenSSL library has the FIPS<br>
module enabled by default.=C2=A0 On these platforms, the OPENSSL_FIPS macro=
<br>
is always defined via /usr/include/openssl/opensslconf-*.h.<br>
<br>
Without this fix, the following compilation error appears:<br>
<br>
=C2=A0 ./src/openvpn/crypto.c: In function =E2=80=98print_cipher=E2=80=99:<=
br>
=C2=A0 ./src/openvpn/crypto.c:1707:43: error: =E2=80=98cipher=E2=80=99 unde=
clared (first use in this function); did you mean =E2=80=98iphdr=E2=80=99?<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FIPS_mode() &amp;&amp; !(EVP_CIPHER_flags(ci=
pher) &amp; EVP_CIPH_FLAG_FIPS))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^~~~~~<br>
<br>
The EVP_CIPHER_fetch() and EVP_CIPHER_free() methods are also provided<br>
via the openssl_compat.h for older than OpenSSL 3.0.<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515..." tar=
get=3D"_blank">davids@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/crypto.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c<br>
index 5626e2b6..e489d453 100644<br>
--- a/src/openvpn/crypto.c<br>
+++ b/src/openvpn/crypto.c<br>
@@ -34,6 +34,7 @@<br>
=C2=A0#include &quot;error.h&quot;<br>
=C2=A0#include &quot;integer.h&quot;<br>
=C2=A0#include &quot;platform.h&quot;<br>
+#include &quot;openssl_compat.h&quot;<br>
<br>
=C2=A0#include &quot;memdbg.h&quot;<br>
<br>
@@ -1704,10 +1705,13 @@ print_cipher(const char *ciphername)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;, TLS client/server mode onl=
y&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#ifdef OPENSSL_FIPS<br>
+=C2=A0 =C2=A0 evp_cipher_type *cipher =3D EVP_CIPHER_fetch(NULL, ciphernam=
e, NULL);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (FIPS_mode() &amp;&amp; !(EVP_CIPHER_flags(cipher) &=
amp; EVP_CIPH_FLAG_FIPS))<br></blockquote><div><br></div><div>We need to ch=
eck=C2=A0that cipher is not NULL. Fetch can return NULL while EVP_CIPHER_fl=
ags() requires a non-null argument. Something like: if (cipher &amp;&amp; F=
IPS_mode &amp;&amp; etc...) will do.</div><div><br></div><div>EVP_CIPHER_fr=
ee() below can handle NULL, so no problem there.</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"> =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;, disabled by FIPS mode&quot=
;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 EVP_CIPHER_free(cipher);=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0printf(&quot;)\n&quot;);<br></blockquote><div><br></div=
><div>Selva</div></div></div></div></div>

--000000000000cbe2b605d5f1f539--

