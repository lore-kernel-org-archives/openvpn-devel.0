MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-4-arne@...1227...>
In-Reply-To: <20211019183127.614175-4-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 21 Oct 2021 01:09:14 -0400
Message-ID: <CAKuzo_jOdVxYE4OOA+cjXCpi0PkgQqt_WHGtZT0X0vdAkJ7MXw@...278...>
Content-Type: multipart/alternative; boundary="0000000000004f750c05ced5e62e"
Subject: Re: [Openvpn-devel] [PATCH v3 03/21] [OSSL 3.0] Implement DES ECB
 encrypt via EVP_CIPHER api
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

--0000000000004f750c05ced5e62e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...> wrote:

> Even though DES is super outdated and also NTLM is super outdated,
> eliminating the warnings for OpenSSL 3.0 is still a step in the right
> direction and using the correct APIs.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto_openssl.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 1c800df7f..021698f12 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -879,10 +879,26 @@ cipher_des_encrypt_ecb(const unsigned char
> key[DES_KEY_LENGTH],
>                         unsigned char src[DES_KEY_LENGTH],
>                         unsigned char dst[DES_KEY_LENGTH])
>  {
> -    DES_key_schedule sched;
> +    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
> +    if (!ctx)
> +    {
> +        crypto_msg(M_FATAL, "%s: EVP_CIPHER_CTX_new() failed", __func__);
> +    }
> +    if (!EVP_EncryptInit_ex(ctx, EVP_bf_ecb(), NULL, key, 0))
>

Apart from the wrong cipher type that Max pointed out, this call will fail
in OpenSSL 3.0 unless legacy is loaded, right? Causing a run-time error in
that case sounds good to me but a helpful error message like legacy
provider may be required or even a check whether legacy is loaded and error
out appropriately would be helpful.

PS: can't we just get rid of the use of DES altogether?

Selva

--0000000000004f750c05ced5e62e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Even tho=
ugh DES is super outdated and also NTLM is super outdated,<br>
eliminating the warnings for OpenSSL 3.0 is still a step in the right<br>
direction and using the correct APIs.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/crypto_openssl.c | 22 +++++++++++++++++++---<br>
=C2=A01 file changed, 19 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index 1c800df7f..021698f12 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -879,10 +879,26 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KE=
Y_LENGTH],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned char src[DES_KEY_LENGTH],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned char dst[DES_KEY_LENGTH])<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DES_key_schedule sched;<br>
+=C2=A0 =C2=A0 EVP_CIPHER_CTX *ctx =3D EVP_CIPHER_CTX_new();<br>
+=C2=A0 =C2=A0 if (!ctx)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_FATAL, &quot;%s: EVP_CIPHER_CTX_n=
ew() failed&quot;, __func__);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!EVP_EncryptInit_ex(ctx, EVP_bf_ecb(), NULL, key, 0))<br=
></blockquote><div><br></div><div>Apart from the wrong cipher type that Max=
 pointed out, this call will fail in OpenSSL 3.0 unless legacy is loaded, r=
ight? Causing a run-time error in that case sounds good=C2=A0to me but a he=
lpful error message like legacy provider may be required or even a check wh=
ether legacy is loaded and error out appropriately would be helpful.</div><=
div><br></div><div>PS: can&#39;t we just get rid of the use of DES altogeth=
er?</div><div><br></div><div>Selva</div></div></div>

--0000000000004f750c05ced5e62e--

