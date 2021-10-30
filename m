MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-11-arne@...1227...>
In-Reply-To: <20211019183127.614175-11-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 30 Oct 2021 15:28:43 -0400
Message-ID: <CAKuzo_ikOZgK1oJ_-p9Y46MQ__6u2SD4ctJp-CotW3fEfufz-g@...278...>
Content-Type: multipart/alternative; boundary="000000000000a4653305cf96f4cf"
Subject: Re: [Openvpn-devel] [PATCH v3 10/21] [OSSL 3.0] Replace
 EVP_get_cipherbyname with EVP_CIPHER_fetch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a4653305cf96f4cf
Content-Type: text/plain; charset="UTF-8"

This has an ACK, but will leak memory in OpenSSL 3.0

On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...> wrote:

> In OpenSSL 3.0 EVP_get_cipherbyname return a non NULL algorithm
> even if the algorithm is not avaialble with the currently available
> provider. Luckily EVP_get_cipherbyname can be used here as drop
> in replacement and returns only non NULL if the algorithm is actually
> currently supported.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto_openssl.c |  6 +++---
>  src/openvpn/openssl_compat.h | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 93c85a836..b10bd7cd5 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -572,7 +572,7 @@ cipher_kt_get(const char *ciphername)
>      ASSERT(ciphername);
>
>      ciphername = translate_cipher_name_from_openvpn(ciphername);
> -    cipher = EVP_get_cipherbyname(ciphername);
> +    cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
>

In OpenSSL 3.0, this 'cipher' must be freed. But the compat function is
written using get_cipherbyname() which returns a const variable that should
not be freed. Also, here we want to return a const cipher to the caller.

One option is to continue using get_cipherbyname() but add a helper call
for OpenSSL 3.0 to check algorithm availability. Say,
EVP_CIPHER_available() that fetches, checks the result and frees ---  to be
used on top of the existing code.

Selva

--000000000000a4653305cf96f4cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This has an ACK, but will leak memory in OpenSSL 3.0<=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1386...=
227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">In OpenSSL 3.0 EVP_get_cipherbynam=
e return a non NULL algorithm<br>
even if the algorithm is not avaialble with the currently available<br>
provider. Luckily EVP_get_cipherbyname can be used here as drop<br>
in replacement and returns only non NULL if the algorithm is actually<br>
currently supported.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/crypto_openssl.c |=C2=A0 6 +++---<br>
=C2=A0src/openvpn/openssl_compat.h | 17 +++++++++++++++++<br>
=C2=A02 files changed, 20 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index 93c85a836..b10bd7cd5 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -572,7 +572,7 @@ cipher_kt_get(const char *ciphername)<br>
=C2=A0 =C2=A0 =C2=A0ASSERT(ciphername);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ciphername =3D translate_cipher_name_from_openvpn(ciphe=
rname);<br>
-=C2=A0 =C2=A0 cipher =3D EVP_get_cipherbyname(ciphername);<br>
+=C2=A0 =C2=A0 cipher =3D EVP_CIPHER_fetch(NULL, ciphername, NULL);<br></bl=
ockquote><div><br></div><div>In OpenSSL 3.0, this &#39;cipher&#39; must be =
freed. But the compat function is written using get_cipherbyname() which re=
turns a const variable that should not be freed. Also, here we want to retu=
rn a const cipher to the caller.</div><div><br></div><div>One option is to =
continue using get_cipherbyname() but add a helper call for OpenSSL 3.0 to =
check algorithm availability. Say, EVP_CIPHER_available() that fetches, che=
cks the result and frees ---=C2=A0 to=C2=A0be used on top of the existing c=
ode.</div><div>=C2=A0</div><div>Selva</div></div></div>

--000000000000a4653305cf96f4cf--

