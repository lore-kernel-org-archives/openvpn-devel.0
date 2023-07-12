MIME-Version: 1.0
References: <20230707185811.30132-1-arne@...1227...>
In-Reply-To: <20230707185811.30132-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 12 Jul 2023 14:03:19 -0400
Message-ID: <CAKuzo_jZ70eOssynFca8m1Od2=70i4tjxmjFLwcj7_EoS+Qofw@...278...>
Content-Type: multipart/alternative; boundary="000000000000cb466806004e082e"
Subject: Re: [Openvpn-devel] [PATCH] show extra info for OpenSSL errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000cb466806004e082e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This looks good except that the format of the log could be kept closer to
the current one:

On Fri, Jul 7, 2023 at 2:59=E2=80=AFPM Arne Schwabe <arne@...1227...> wrote:

> This also shows the extra data from the OpenSSL error function that
> can contain extra information. For example, the command
>
>     openvpn --providers vollbit
>
> will print out (on macOS):
>
>      OpenSSLerror:12800067:DSO support routines::could not load the shared
> library:filename(/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl=
-modules/vollbit.dylib):
> dlopen(/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/v=
ollbit.dylib,
> 0x0002): tried: '/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl=
-modules/vollbit.dylib'
> (no such file),
> '/System/Volumes/Preboot/Cryptexes/OS/opt/homebrew/Cellar/openssl@...2739...=
.../3.1.1_1/lib/ossl-modules/vollbit.dylib'
> (no such file), '/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl=
-modules/vollbit.dylib'
> (no such file)
>
> Change-Id: Ic2ee89937dcd85721bcacd1b700a20c640364f80
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto_openssl.c | 20 ++++++++++++++++++--
>  src/openvpn/openssl_compat.h | 12 ++++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index b043bb95e..d6916fc9b 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -238,9 +238,16 @@ void
>  crypto_print_openssl_errors(const unsigned int flags)
>  {
>      unsigned long err =3D 0;
> +    int line, errflags;
> +    const char *file, *data, *func;
>
> -    while ((err =3D ERR_get_error()))
> +    while ((err =3D ERR_get_error_all(&file, &line, &func, &data,
> &errflags)) !=3D 0)
>      {
> +        if (!(errflags & ERR_TXT_STRING))
> +        {
> +            data =3D "";
> +        }
> +
>          /* Be more clear about frequently occurring "no shared cipher"
> error */
>          if (ERR_GET_REASON(err) =3D=3D SSL_R_NO_SHARED_CIPHER)
>          {
> @@ -258,7 +265,16 @@ crypto_print_openssl_errors(const unsigned int flags)
>                  "tls-version-min 1.0 to the client configuration to use
> TLS 1.0+ "
>                  "instead of TLS 1.0 only");
>          }
> -        msg(flags, "OpenSSL: %s", ERR_error_string(err, NULL));
> +
> +        /* print file and line if verb >=3D8 */
> +        if (!check_debug_level(D_TLS_DEBUG_MED))
> +        {
> +            msg(flags, "OpenSSL%s:%s", ERR_error_string(err, NULL), data=
);
>

Better to retain the ':" after "OpenSSL" in case anyone is parsing the logs

msg(flags, "OpenSSL: %s:%s, ERR_error_string(err, NULL), data);


> +        }
> +        else
> +        {
> +            msg(flags, "OpenSSL (%s:%d %s): %s:%s", file, line, func,
> ERR_error_string(err, NULL), data);
>

Again, I think we could keep the same order as above with additional info
(file:line:func) moved to the end with a consistent use of the delimiter ':'

msg(flags, "OpenSSL: %s:%s:%s:%s:%s, ERR_error_string(err, NULL), data,
file, line, func);


> +        }
>      }
>  }
>
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index ffb64adf6..736ce1bd5 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -43,6 +43,7 @@
>  #include <openssl/rsa.h>
>  #include <openssl/ssl.h>
>  #include <openssl/x509.h>
> +#include <openssl/err.h>
>
>  /* Functionality missing in 1.1.0 */
>  #if OPENSSL_VERSION_NUMBER < 0x10101000L &&
> !defined(ENABLE_CRYPTO_WOLFSSL)
> @@ -799,6 +800,17 @@ EVP_MD_free(const EVP_MD *md)
>      /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */
>  }
>
> +static inline unsigned long
> +ERR_get_error_all(const char **file, int *line,
> +                  const char **func,
> +                  const char **data, int *flags)
> +{
> +    static const char *empty =3D "";
> +    *func =3D empty;
> +    long err =3D ERR_get_error_line_data(file, line, data, flags);
>

unsigned long err =3D ....


> +    return err;
> +}
> +
>  #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
>
>  #endif /* OPENSSL_COMPAT_H_ */
> --
>
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000cb466806004e082e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>This looks good ex=
cept that the format of the log could be kept closer to the current one:</d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Jul 7, 2023 at 2:59=E2=80=AFPM Arne Schwabe &lt;<a href=3D"mailt=
o:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">This also shows the ext=
ra data from the OpenSSL error function that<br>
can contain extra information. For example, the command<br>
<br>
=C2=A0 =C2=A0 openvpn --providers vollbit<br>
<br>
will print out (on macOS):<br>
<br>
=C2=A0 =C2=A0 =C2=A0OpenSSLerror:12800067:DSO support routines::could not l=
oad the shared library:filename(/opt/homebrew/Cellar/openssl@...1554.../3.1=
.1_1/lib/ossl-modules/vollbit.dylib): dlopen(/opt/homebrew/Cellar/openssl@...220...=
..1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib, 0x0002): tried: &#39;/opt=
/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib&=
#39; (no such file), &#39;/System/Volumes/Preboot/Cryptexes/OS/opt/homebrew=
/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib&#39; (no =
such file), &#39;/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-m=
odules/vollbit.dylib&#39; (no such file)<br>
<br>
Change-Id: Ic2ee89937dcd85721bcacd1b700a20c640364f80<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/crypto_openssl.c | 20 ++++++++++++++++++--<br>
=C2=A0src/openvpn/openssl_compat.h | 12 ++++++++++++<br>
=C2=A02 files changed, 30 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index b043bb95e..d6916fc9b 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -238,9 +238,16 @@ void<br>
=C2=A0crypto_print_openssl_errors(const unsigned int flags)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned long err =3D 0;<br>
+=C2=A0 =C2=A0 int line, errflags;<br>
+=C2=A0 =C2=A0 const char *file, *data, *func;<br>
<br>
-=C2=A0 =C2=A0 while ((err =3D ERR_get_error()))<br>
+=C2=A0 =C2=A0 while ((err =3D ERR_get_error_all(&amp;file, &amp;line, &amp=
;func, &amp;data, &amp;errflags)) !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(errflags &amp; ERR_TXT_STRING))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D &quot;&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Be more clear about frequently occurri=
ng &quot;no shared cipher&quot; error */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ERR_GET_REASON(err) =3D=3D SSL_R_NO_S=
HARED_CIPHER)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -258,7 +265,16 @@ crypto_print_openssl_errors(const unsigned int flags)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tls-ver=
sion-min 1.0 to the client configuration to use TLS 1.0+ &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;instead=
 of TLS 1.0 only&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(flags, &quot;OpenSSL: %s&quot;, ERR_error_=
string(err, NULL));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* print file and line if verb &gt;=3D8 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_debug_level(D_TLS_DEBUG_MED))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(flags, &quot;OpenSSL%s:%s&qu=
ot;, ERR_error_string(err, NULL), data);<br></blockquote><div><br></div><di=
v>Better to retain the &#39;:&quot; after &quot;OpenSSL&quot; in case anyon=
e is parsing the logs</div><div><br></div><div>msg(flags, &quot;OpenSSL: %s=
:%s, ERR_error_string(err, NULL), data);</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(flags, &quot;OpenSSL (%s:%d =
%s): %s:%s&quot;, file, line, func, ERR_error_string(err, NULL), data);<br>=
</blockquote><div><br></div><div>Again, I think we could keep the same orde=
r as above with additional info (file:line:func) moved to the end with a co=
nsistent use of the delimiter &#39;:&#39;</div><div><br></div><div>msg(flag=
s, &quot;OpenSSL: %s:%s:%s:%s:%s, ERR_error_string(err, NULL), data, file, =
line, func);<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h<br>
index ffb64adf6..736ce1bd5 100644<br>
--- a/src/openvpn/openssl_compat.h<br>
+++ b/src/openvpn/openssl_compat.h<br>
@@ -43,6 +43,7 @@<br>
=C2=A0#include &lt;openssl/rsa.h&gt;<br>
=C2=A0#include &lt;openssl/ssl.h&gt;<br>
=C2=A0#include &lt;openssl/x509.h&gt;<br>
+#include &lt;openssl/err.h&gt;<br>
<br>
=C2=A0/* Functionality missing in 1.1.0 */<br>
=C2=A0#if OPENSSL_VERSION_NUMBER &lt; 0x10101000L &amp;&amp; !defined(ENABL=
E_CRYPTO_WOLFSSL)<br>
@@ -799,6 +800,17 @@ EVP_MD_free(const EVP_MD *md)<br>
=C2=A0 =C2=A0 =C2=A0/* OpenSSL 1.1.1 and lower use only const EVP_MD, nothi=
ng to free */<br>
=C2=A0}<br>
<br>
+static inline unsigned long<br>
+ERR_get_error_all(const char **file, int *line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
**func,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
**data, int *flags)<br>
+{<br>
+=C2=A0 =C2=A0 static const char *empty =3D &quot;&quot;;<br>
+=C2=A0 =C2=A0 *func =3D empty;<br>
+=C2=A0 =C2=A0 long err =3D ERR_get_error_line_data(file, line, data, flags=
);<br></blockquote><div><br></div><div>unsigned long err =3D ....</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 return err;<br>
+}<br>
+<br>
=C2=A0#endif /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */<br>
<br>
=C2=A0#endif /* OPENSSL_COMPAT_H_ */<br>
-- <br><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000cb466806004e082e--

