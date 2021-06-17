MIME-Version: 1.0
References: <20210617061027.140-1-lstipakov@...277...>
 <20210617061226.244-1-lstipakov@...277...>
In-Reply-To: <20210617061226.244-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 17 Jun 2021 11:25:02 -0400
Message-ID: <CAKuzo_jCBkQA1FLYAFct1+=f=Vyjw8Mt1HxU+BKtR10Xx-MXQw@...278...>
Content-Type: multipart/alternative; boundary="000000000000b8e04305c4f7d248"
Subject: Re: [Openvpn-devel] [PATCH 1/2] crypto_openssl.c: disable explicit
 initialization on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000b8e04305c4f7d248
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Jun 17, 2021 at 2:13 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Commit a4071b ("crypto_openssl: add initialization to pick up local
> configuration")
> added openssl initialization to load configuration file. However on Windows
> this file is loaded from user-writable directory, such as c.\etc\ssl for
> mingw builds
> and (for example) c:\vcpkg\packages\openssl_x64-windows\openvpn.cnf for
> vcpkg
> builds. This could be a security risk.
>
> Since aforementioned commit implements a niche feature which anyway
> should use CryptoAPI on Windows, make this code conditional.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/crypto_openssl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index c571030b..603c67b0 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -154,11 +154,13 @@ crypto_init_lib_engine(const char *engine_name)
>  void
>  crypto_init_lib(void)
>  {
> +#ifndef _WIN32
>  #if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
>      OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
>  #else
>      OPENSSL_config(NULL);
>  #endif
> +#endif /* _WIN32 */
>      /*
>       * If you build the OpenSSL library and OpenVPN with
>       * CRYPTO_MDEBUG, you will get a listing of OpenSSL
> --
> 2.23.0.windows.1
>

This would make it impossible to use openssl.cnf on Windows, wouldn't it? I
use configuraton file to restrict signature algorithms, for example. There
are other uses like configuring engines.

Instead of disabling, why not make the default path a restricted location
within, say,  C:\Windows. The user can then override it using env variables.

What path does OpenSSL Windows binaries described in OpensSL wiki use?   (
https://wiki.openssl.org/index.php/Binaries)

Selva

--000000000000b8e04305c4f7d248
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Jun 17, 2021 at 2:13 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipakov =
&lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt=
;<br>
<br>
Commit a4071b (&quot;crypto_openssl: add initialization to pick up local co=
nfiguration&quot;)<br>
added openssl initialization to load configuration file. However on Windows=
<br>
this file is loaded from user-writable directory, such as c.\etc\ssl for mi=
ngw builds<br>
and (for example) c:\vcpkg\packages\openssl_x64-windows\openvpn.cnf for vcp=
kg<br>
builds. This could be a security risk.<br>
<br>
Since aforementioned commit implements a niche feature which anyway<br>
should use CryptoAPI on Windows, make this code conditional.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/crypto_openssl.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index c571030b..603c67b0 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -154,11 +154,13 @@ crypto_init_lib_engine(const char *engine_name)<br>
=C2=A0void<br>
=C2=A0crypto_init_lib(void)<br>
=C2=A0{<br>
+#ifndef _WIN32<br>
=C2=A0#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L)<br>
=C2=A0 =C2=A0 =C2=A0OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0OPENSSL_config(NULL);<br>
=C2=A0#endif<br>
+#endif /* _WIN32 */<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * If you build the OpenSSL library and OpenVPN with<br>
=C2=A0 =C2=A0 =C2=A0 * CRYPTO_MDEBUG, you will get a listing of OpenSSL<br>
-- <br>
2.23.0.windows.1<br></blockquote><div><br></div><div>This would make it imp=
ossible to use openssl.cnf on Windows, wouldn&#39;t it? I use configuraton=
=C2=A0file to restrict signature algorithms, for example. There are other u=
ses like configuring engines.</div><div><br></div><div>Instead of disabling=
, why not make the default path a restricted location within, say,=C2=A0 C:=
\Windows. The user can then override it using env variables.</div><div><br>=
</div><div>What path does OpenSSL Windows binaries described in OpensSL wik=
i use?=C2=A0 =C2=A0(<a href=3D"https://wiki.openssl.org/index.php/Binaries"=
>https://wiki.openssl.org/index.php/Binaries</a>)</div><div><br></div><div>=
Selva</div></div></div>

--000000000000b8e04305c4f7d248--

